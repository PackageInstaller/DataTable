from __future__ import annotations

import json
import struct
from pathlib import Path

from AMF3 import AMF3Decoder, amf3_to_jsonable
from CompressUtil import xor_u32_be, zlib_decompress

FLAG_XOR_OPS = 1
FLAG_COMPRESS = 2
FLAG_GMF = 4


def decrypt_gs_bytes(raw: bytes) -> tuple[int, object]:
    if not raw:
        raise ValueError("空 GS 文件")
    flags = raw[0]
    pos = 1
    if flags & FLAG_COMPRESS:
        if pos + 4 > len(raw):
            raise ValueError("GS 压缩头不完整")
        key = struct.unpack(">I", raw[pos : pos + 4])[0]
        pos += 4
        payload = xor_u32_be(raw[pos:], key)
        raw = zlib_decompress(payload)
        flags = raw[0]
        pos = 1
    inner_key = None
    if flags & FLAG_XOR_OPS:
        if pos + 4 > len(raw):
            raise ValueError("GS 内层 XOR 头不完整")
        inner_key = struct.unpack(">I", raw[pos : pos + 4])[0]
        pos += 4
    if flags & FLAG_GMF:
        raise ValueError("遇到 GMF 序列化的 GS，尚未实现")
    obj = AMF3Decoder(raw[pos:]).read_element()
    if inner_key is not None and isinstance(obj, list) and len(obj) > 1 and isinstance(obj[1], list):
        obj = list(obj)
        obj[1] = [int(x) ^ inner_key for x in obj[1]]
    return flags, obj


def decrypt_gs_file(path: Path) -> object:
    _, obj = decrypt_gs_bytes(path.read_bytes())
    return obj


def dump_gs_json(src: Path, dst: Path) -> None:
    dst.parent.mkdir(parents=True, exist_ok=True)
    _, obj = decrypt_gs_bytes(src.read_bytes())
    dst.write_text(
        json.dumps(amf3_to_jsonable(obj), ensure_ascii=False, indent=2),
        encoding="utf-8",
    )
