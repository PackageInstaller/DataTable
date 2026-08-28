from __future__ import annotations

import lzma
import struct
import zlib

from Config import CUSTOM_B64_ALPHABET, CUSTOM_B64_PAD


def xor_u32_be(data: bytes, key: int) -> bytes:
    out = bytearray()
    i = 0
    n = len(data)
    key &= 0xFFFFFFFF
    while i + 4 <= n:
        value = struct.unpack(">I", data[i : i + 4])[0]
        out += struct.pack(">I", (value ^ key) & 0xFFFFFFFF)
        i += 4
    out += data[i:]
    return bytes(out)


def hu_checksum(data: bytes) -> int:
    """huList.bin 使用的 16 位累加校验（首 2 字节先置 0）。"""
    buf = bytearray(data)
    if len(buf) >= 2:
        buf[0] = 0
        buf[1] = 0
    pos = 0
    total = 0
    end = len(buf) - 1
    while pos < end:
        total += (buf[pos] << 8) | buf[pos + 1]
        if total > 65535:
            total = (total + 1) % 65536
        pos += 2
    if pos < len(buf):
        total += buf[pos]
    if total > 65535:
        total = (total + 1) % 65536
    return total


def verify_hulist(data: bytes) -> bool:
    if len(data) < 2:
        return False
    stored = (data[0] << 8) | data[1]
    return stored == hu_checksum(data)


def lzma_decompress(data: bytes) -> bytes:
    """Adobe ByteArray.uncompress('lzma')：5 字节属性 + 8 字节小端长度 + LZMA。"""
    dec = lzma.LZMADecompressor(format=lzma.FORMAT_ALONE)
    return dec.decompress(data)


def zlib_decompress(data: bytes) -> bytes:
    if data.startswith(b"\x78\x01") or data.startswith(b"\x78\x9c") or data.startswith(b"\x78\xda"):
        return zlib.decompress(data)
    try:
        return zlib.decompress(data)
    except zlib.error:
        return zlib.decompress(data, -15)


def maybe_zlib(data: bytes) -> bytes:
    if data[:2] in (b"\x78\x01", b"\x78\x9c", b"\x78\xda"):
        try:
            return zlib.decompress(data)
        except zlib.error:
            return data
    return data


def decode_custom_b64(text: str) -> bytes:
    """预加载器自定义 Base64：O/0 对调，+/ 换成 ,;，填充为 '('。"""
    decode_tbl = [64] * 128
    for i, ch in enumerate(CUSTOM_B64_ALPHABET):
        decode_tbl[ord(ch)] = i
    n = len(text)
    rem = n % 4
    if rem == 2:
        text += CUSTOM_B64_PAD * 2
        n = len(text)
    elif rem == 3:
        text += CUSTOM_B64_PAD
        n = len(text)
    out = bytearray(n * 3 >> 2)
    i = j = 0
    c = d = 0
    while i < n:
        a = decode_tbl[ord(text[i]) & 0x7F]
        b = decode_tbl[ord(text[i + 1]) & 0x7F]
        c = decode_tbl[ord(text[i + 2]) & 0x7F]
        d = decode_tbl[ord(text[i + 3]) & 0x7F]
        out[j] = ((a << 2) + ((b & 0x30) >> 4)) & 0xFF
        out[j + 1] = (((b & 0x0F) << 4) + ((c & 0x3C) >> 2)) & 0xFF
        out[j + 2] = (((c & 3) << 6) + d) & 0xFF
        j += 3
        i += 4
    if c == 64:
        del out[-2:]
    elif d == 64:
        del out[-1:]
    return bytes(out)
