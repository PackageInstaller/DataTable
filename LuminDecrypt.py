from __future__ import annotations

from pathlib import Path
from typing import Union

from lumin.pure_block import decrypt_core_block, get_keystream
from lumin.rawfile import MAGIC as RAWFILE_MAGIC, decrypt as decrypt_rawfile, is_encrypted as is_rawfile_encrypted
from lumin.unityfs import UnityFS, is_unityfs


def is_bundle_encrypted(data: bytes) -> bool:
    if not is_unityfs(data):
        return False
    try:
        return UnityFS(data).is_encrypted_core()
    except Exception:
        return False


def decrypt_bundle(data: bytes) -> bytes:
    if not is_unityfs(data):
        return data
    try:
        fs = UnityFS(data)
        return fs.decrypted_bytes() if fs.is_encrypted_core() else data
    except Exception:
        return data


def decrypt_file(input_path: Union[str, Path], output_path: Union[str, Path] | None = None) -> bytes:
    raw = Path(input_path).read_bytes()
    if is_rawfile_encrypted(raw):
        res = decrypt_rawfile(raw)
    elif is_bundle_encrypted(raw):
        res = decrypt_bundle(raw)
    else:
        res = raw

    if output_path:
        out = Path(output_path)
        out.parent.mkdir(parents=True, exist_ok=True)
        out.write_bytes(res)
    return res


def decrypt_file_in_place(path: Union[str, Path]) -> bool:
    p = Path(path)
    if not p.is_file():
        return False
    raw = p.read_bytes()
    if is_rawfile_encrypted(raw):
        p.write_bytes(decrypt_rawfile(raw))
        return True
    if is_bundle_encrypted(raw):
        p.write_bytes(decrypt_bundle(raw))
        return True
    return False


__all__ = [
    "RAWFILE_MAGIC",
    "decrypt_bundle",
    "decrypt_core_block",
    "decrypt_file",
    "decrypt_file_in_place",
    "decrypt_rawfile",
    "get_keystream",
    "is_bundle_encrypted",
    "is_rawfile_encrypted",
]
