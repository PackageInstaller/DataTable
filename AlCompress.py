"""Aqualead 引擎压缩容器。

* ``ALL4``：``ALLz4Decoder`` —— 头 12 字节，之后是标准 LZ4 frame。
  ``HeaderCheck`` 校验 magic(4) + u8 版本(<=1)，解压大小取 u32@8。
* ``ALLZ``：``ALLzDecoder`` —— 自定义位流 LZ，头部字段：
  ``minBitsLength``(5) ``minBitsOffset``(6) ``minBitsLiteral``(7) ``dstSize``(u32@8)，
  位流自 12 字节处开始（LSB first）。
"""

from __future__ import annotations

import struct

import lz4.frame

ALL4_MAGIC = b"ALL4"
ALLZ_MAGIC = b"ALLZ"
LZ4_FRAME_MAGIC = b"\x04\x22\x4d\x18"


def is_all4(data: bytes) -> bool:
    return len(data) >= 12 and data[:4] == ALL4_MAGIC and data[4] <= 1


def is_allz(data: bytes) -> bool:
    return len(data) >= 12 and data[:4] == ALLZ_MAGIC and data[4] <= 1


def all4_size(data: bytes) -> int:
    """``ALLz4Decoder::HeaderCheck`` 返回的原始大小。"""
    return struct.unpack_from("<I", data, 8)[0]


def decode_all4(data: bytes) -> bytes:
    frame = data[12:]
    if not frame.startswith(LZ4_FRAME_MAGIC):
        # 少见的裸块：补一个 frame magic 再试
        frame = LZ4_FRAME_MAGIC + data[16:]
    return lz4.frame.decompress(frame)


class _BitReader:
    """LSB-first 位读取器（对应 ALLzDecoder 里的位缓冲）。"""

    __slots__ = ("data", "pos", "bits", "count")

    def __init__(self, data: bytes, pos: int = 12) -> None:
        self.data = data
        self.pos = pos
        self.bits = 0
        self.count = 0

    def _fill(self, need: int) -> None:
        data = self.data
        pos = self.pos
        bits = self.bits
        count = self.count
        end = len(data)
        while count < need:
            if pos >= end:
                break
            bits |= data[pos] << count
            pos += 1
            count += 8
        self.bits = bits
        self.count = count
        self.pos = pos

    def bit(self) -> int:
        self._fill(1)
        if self.count <= 0:
            return 0
        value = self.bits & 1
        self.bits >>= 1
        self.count -= 1
        return value

    def bits_value(self, width: int) -> int:
        self._fill(width)
        if self.count < width:
            value = self.bits & ((1 << self.count) - 1)
            self.bits = 0
            self.count = 0
            return value
        value = self.bits & ((1 << width) - 1)
        self.bits >>= width
        self.count -= width
        return value

    def unary(self) -> int:
        n = 0
        while self.bit():
            n += 1
        return n

    def byte(self) -> int:
        return self.bits_value(8)


def decode_allz(data: bytes) -> bytes:
    """``ALLzDecoder::Decode`` 的自定义 LZ 解压。"""
    if not is_allz(data):
        raise ValueError("不是 ALLZ 数据")
    min_bits_length = data[5]
    min_bits_offset = data[6]
    min_bits_literal = data[7]
    dst_size = struct.unpack_from("<I", data, 8)[0]

    reader = _BitReader(data)
    dst = bytearray(dst_size)
    dst_pos = 0

    def control(min_bits: int) -> int:
        u = reader.unary()
        n = reader.bits_value(u + min_bits)
        if u > 0:
            n += ((1 << u) - 1) << min_bits
        return n

    def read_length() -> int:
        return 3 + control(min_bits_length)

    def read_offset() -> int:
        return -1 - control(min_bits_offset)

    def read_literal_len() -> int:
        return 1 + control(min_bits_literal)

    def copy_match(offset: int, length: int) -> None:
        nonlocal dst_pos
        src = dst_pos + offset if offset < 0 else offset
        for _ in range(length):
            if dst_pos >= dst_size:
                break
            if src < dst_size:
                dst[dst_pos] = dst[src]
            dst_pos += 1
            src += 1

    def copy_literal(length: int) -> None:
        nonlocal dst_pos
        for _ in range(length):
            if dst_pos >= dst_size:
                dst_pos += 1
                continue
            dst[dst_pos] = reader.byte()
            dst_pos += 1

    copy_literal(read_literal_len())
    word_offset = read_offset()
    word_length = read_length()
    literal_length = 0
    finish = "overflow"
    while reader.pos < len(data) or reader.count > 0:
        if dst_pos + word_length >= dst_size:
            finish = "word"
            break
        if reader.bit() == 0:
            literal_length = read_literal_len()
            if dst_pos + word_length + literal_length >= dst_size:
                finish = "literal"
                break
            copy_match(word_offset, word_length)
            copy_literal(literal_length)
            word_offset = read_offset()
            word_length = read_length()
        else:
            copy_match(word_offset, word_length)
            word_offset = read_offset()
            word_length = read_length()

    if finish == "word":
        copy_match(word_offset, word_length)
    elif finish == "literal":
        copy_match(word_offset, word_length)
        copy_literal(literal_length)

    return bytes(dst)
