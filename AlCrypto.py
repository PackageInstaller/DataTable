"""Aqualead 引擎的加解密
"""

from __future__ import annotations

import json
import struct
from dataclasses import dataclass
from pathlib import Path

from Crypto.Cipher import AES

from Config import CACHE_DIR

KEYS_FILE = CACHE_DIR / "frida" / "aes.json"

# 解密成功的判定：明文开头出现这些 magic
PLAINTEXT_MAGIC = (
    b"ALAR",
    b"ALTB",
    b"ALRD",
    b"ALTX",
    b"ALIG",
    b"ALOD",
    b"ALMT",
    b"ALSN",
    b"ALFT",
    b"ALL4",
    b"ALLZ",
    b"OggS",
)

TEXT_MAGIC = (b"{", b"[", b"<?xml", b"<!DOCTYPE", b"ID_", b"# ")

# 引擎里以常量字符串形式存在的 16 字节密钥（sub_A709DC 注册的 4 把 + 其它）
BUILTIN_KEYS = (
    "fiGbY64z87xJmHkq",
    "F9UvCWQ6rHMr8jAk",
    "Aa4SiizSduyLyMUx",
    "9mi4RSaYvzdb",
    "wB7QzSDb9hiSS7KT",
    "uV9Deeinsb2pkM2V",
)


@dataclass(slots=True)
class KeyInfo:
    bits: int
    key: bytes
    source: str = ""

    @property
    def hex(self) -> str:
        return self.key.hex()


@dataclass(slots=True)
class DecryptHit:
    mode: str
    key: KeyInfo
    data: bytes
    note: str = ""


def _load_runtime_keys(path: Path | None = None) -> list[KeyInfo]:
    path = path or KEYS_FILE
    if not path.is_file():
        return []
    try:
        raw = json.loads(path.read_text(encoding="utf-8"))
    except (OSError, json.JSONDecodeError):
        return []
    items = raw if isinstance(raw, list) else raw.get("keys", [])
    keys: list[KeyInfo] = []
    for item in items:
        try:
            if isinstance(item, str) and ":" in item:
                bits, hexkey = item.split(":", 1)
                keys.append(KeyInfo(int(bits), bytes.fromhex(hexkey), str(path)))
            elif isinstance(item, dict) and item.get("key"):
                keys.append(
                    KeyInfo(int(item.get("bits", 128)), bytes.fromhex(item["key"]), str(path))
                )
        except ValueError:
            continue
    return keys


def known_keys(extra: list[KeyInfo] | None = None) -> list[KeyInfo]:
    """运行时抓到的密钥优先，再补上引擎里的常量密钥。"""
    keys: list[KeyInfo] = list(extra or [])
    keys.extend(_load_runtime_keys())
    for text in BUILTIN_KEYS:
        raw = text.encode("utf-8")
        keys.append(KeyInfo(len(raw) * 8, raw, "builtin"))
    seen: set[tuple[int, bytes]] = set()
    unique: list[KeyInfo] = []
    for info in keys:
        if info.bits not in (128, 192, 256) or len(info.key) * 8 != info.bits:
            continue
        marker = (info.bits, info.key)
        if marker in seen:
            continue
        seen.add(marker)
        unique.append(info)
    return unique


def aes_ecb_decrypt(key: bytes, data: bytes) -> bytes:
    return AES.new(key, AES.MODE_ECB).decrypt(data[: len(data) // 16 * 16])


def aes_cbc_decrypt(key: bytes, data: bytes, iv: bytes | None = None) -> bytes:
    return AES.new(key, AES.MODE_CBC, iv or b"\x00" * 16).decrypt(
        data[: len(data) // 16 * 16]
    )


def aes_ctr_decrypt(key: bytes, data: bytes, nonce: bytes | None = None) -> bytes:
    return AES.new(key, AES.MODE_CTR, nonce=nonce or b"\x00" * 8).decrypt(data)


def _decrypt(mode: str, key: bytes, data: bytes) -> bytes:
    if mode == "ecb":
        return aes_ecb_decrypt(key, data)
    if mode == "ctr":
        return aes_ctr_decrypt(key, data)
    return aes_cbc_decrypt(key, data)


def xor128_keystream(seed: tuple[int, int, int, int], length: int) -> bytes:
    """``StructCryptFilter::Filter`` 用的 xor128 流。"""
    x, y, z, w = seed
    mask = 0xFFFFFFFF
    out = bytearray()
    while len(out) < length:
        t = (x ^ ((x << 11) & mask)) & mask
        x, y, z = y, z, w
        w = (w ^ (w >> 19) ^ t ^ (t >> 8)) & mask
        out += struct.pack("<I", w)
    return bytes(out[:length])


def xor128_apply(seed: tuple[int, int, int, int], data: bytes) -> bytes:
    stream = xor128_keystream(seed, len(data))
    return bytes(a ^ b for a, b in zip(data, stream))


def looks_plain(data: bytes) -> str | None:
    if len(data) < 4:
        return None
    for magic in PLAINTEXT_MAGIC:
        if data.startswith(magic):
            return magic.decode("latin1")
    for magic in TEXT_MAGIC:
        if data.startswith(magic):
            return "text"
    return None


def try_decrypt(
    data: bytes,
    *,
    keys: list[KeyInfo] | None = None,
    modes: tuple[str, ...] = ("cbc", "ecb", "ctr"),
    head: int = 8192,
) -> DecryptHit | None:
    """用已知密钥/模式试探解密，只有命中已知 magic 才认。"""
    keys = keys or known_keys()
    if not keys or len(data) < 32:
        return None
    sample = data[: min(len(data), max(64, head))]
    for info in keys:
        for mode in modes:
            try:
                probe = _decrypt(mode, info.key, sample)
            except ValueError:
                continue
            note = looks_plain(probe)
            if note is None:
                continue
            return DecryptHit(mode, info, _decrypt(mode, info.key, data), note)
    return None
