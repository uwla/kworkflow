#!/bin/bash

include './tests/unit/utils.sh'

script_dir="$(dirname "$0")"
container_dir="${script_dir}/podman"
expected_kw_version='beta'$'\n''Branch: master'$'\n''Commit: af4d2e3'

build_archlinux_image()
{
  podman image build --file "${container_dir}/Containerfile_archlinux" --tag kw-archlinux
}

build_debian_image()
{
  podman image build --file "${container_dir}/Containerfile_debian" --tag kw-debian
}

build_fedora_image()
{
  podman image build --file "${container_dir}/Containerfile_fedora" --tag kw-fedora
}

test_installs_on_archlinux()
{
  build_archlinux_image > /dev/null
  output="$(podman container run kw-archlinux /root/.local/bin/kw --version)"
  assertEquals "$expected_kw_version" "$output"
}

test_installs_on_debian()
{
  build_debian_image > /dev/null
  output="$(podman container run kw-debian /root/.local/bin/kw --version)"
  assertEquals "$expected_kw_version" "$output"
}

test_installs_on_fedora()
{
  build_fedora_image > /dev/null
  output="$(podman container run kw-fedora /root/.local/bin/kw --version)"
  assertEquals "$expected_kw_version" "$output"
}

invoke_shunit
