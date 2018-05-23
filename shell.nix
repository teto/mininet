with import <nixpkgs> {};

# let 
#   pyEnv = pkgs.python.withPackages(ps: with ps; [
#     mininet-python
#   ]);
# in
# pkgs.stdenv.mkDerivation {
#   name = "mininet";

#   buildInputs = [
#     pyEnv
#     pkgs.mininet
#   ];
# }

# {pkgs ? import <nixpkgs> {} }:

pythonPackages.buildPythonPackage {
  name = "mininet";
  version="alpha";

  # need to access mnexec
  propagatedBuiltInputs = [ 
    (python.withPackages (ps: [ ps.setuptools ]))
    # pythonPackages.setuptools 
  ];
  src = ./.;
    postInstall = ''
      echo "__import__('pkg_resources').declare_namespace(__name__)" >> "$out/lib/${python.libPrefix}"/site-packages/mininet/__init__.py
    '';

}
