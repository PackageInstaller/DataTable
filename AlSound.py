"""音频 ``ALSN`` 与字体 ``ALFT``。

``ALSoundLoaderAsn::Load``（0x1402d34）：
    * ``ALSN`` + u8 ver + u8 flags + u8 通道 + u8 位深标志
    * u32 @8/@12（循环区间）、u32 @16/@20（裁切）、u32 @24（音频数据偏移）、
      u8 @28（音量）
    * 音频载荷在 +32；``flags & 0x08``（且开启 mp3 标志）时前面还有一个
      NUL 结尾的文件名需要跳过
"""

from __future__ import annotations

import struct

ALSN_MAGIC = b"ALSN"
ALFT_MAGIC = b"ALFT"
OGG_MAGIC = b"OggS"
ID3_MAGIC = b"ID3"
MP3_FRAME_SYNC = 0xFF


def is_alsn(data: bytes) -> bool:
    return len(data) >= 32 and data[:4] == ALSN_MAGIC


def is_alft(data: bytes) -> bool:
    if len(data) < 16 or data[:4] != ALFT_MAGIC:
        return False
    # 只有 0/1 版本被引擎接受
    return data[4] <= 1


def alsn_payload_offset(data: bytes) -> int:
    flags = data[5]
    offset = 32
    if flags & 0x08:
        end = data.find(b"\x00", offset, min(len(data), offset + 256))
        if end != -1:
            offset = end + 1
    return offset


def alsn_audio(data: bytes) -> tuple[bytes, str]:
    """返回 ``(音频数据, 扩展名)``。"""
    payload = data[alsn_payload_offset(data) :]
    if payload.startswith(OGG_MAGIC):
        return payload, ".ogg"
    if payload.startswith(ID3_MAGIC) or (payload and payload[0] == MP3_FRAME_SYNC):
        return payload, ".mp3"
    return payload, ".bin"


def alsn_info(data: bytes) -> dict:
    return {
        "version": data[4],
        "flags": data[5],
        "channels": data[6],
        "bits": data[7],
        "loop_begin": struct.unpack_from("<I", data, 8)[0],
        "loop_end": struct.unpack_from("<I", data, 12)[0],
        "sample_count": struct.unpack_from("<I", data, 16)[0],
        "sample_rate": struct.unpack_from("<I", data, 20)[0],
        "data_offset": struct.unpack_from("<I", data, 24)[0],
        "volume": data[28],
    }


def alft_embedded_image_offset(data: bytes) -> int | None:
    """``ALFT`` 里内嵌的贴图（ALTX/ALIG）偏移，找不到返回 None。"""
    if not is_alft(data):
        return None
    flags = data[5]
    conv_count = struct.unpack_from("<H", data, 12)[0]
    offset = 14 + conv_count * 6
    if offset + 2 > len(data):
        return None
    if flags & 0x08:
        extra = struct.unpack_from("<H", data, offset)[0]
        offset += 2 + extra
    offset = (offset + 3) & ~3
    if flags & 0x40:
        if offset + 8 > len(data):
            return None
        offset = struct.unpack_from("<I", data, offset + 4)[0]
    if offset >= len(data):
        return None
    if data[offset : offset + 4] in (b"ALTX", b"ALIG"):
        return offset
    return None
