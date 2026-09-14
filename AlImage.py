"""贴图集 ``ALTX`` 与位图 ``ALIG``。

``ALTX``（``ALTextureAtxLoader::Load`` @0x143d624）
    * `ALTX` + u8 ver + u8 flags + u16 子纹理数 + u32 图像偏移
    * u16 子纹理偏移表 @12：version != 0 时是**增量**（``pos += offsets[i]``），
      version == 0 时是绝对偏移
    * 子纹理：u32 share_id + u16 图块数 + u8 flags
      (+0x80000000 由 ``ALTextureImp::SetCenterBoundsCopy`` 处理)
      之后是图块（每块 4×i16：x,y,w,h）、中心点（每块 2×i16）、名字(NUL 结尾)
    * flags & 2：图像流前面有额外头（&4 时再 &8 读 2 个 u16；否则读 u32 偏移）

``ALIG``（``ALAigImageHandler::Load`` @0x1341eb4）
    * `ALIG` + u8 ver + u8 flags + u16 调色板数 + 4CC 格式
    * v0：u32 宽 @16，u32 高 @20，u16 调色板偏移 @24，u16 数据偏移 @26
    * v1：u32 宽 @16，u32 高 @20，u16 调色板偏移 @26，u32 数据偏移 @28
    * v2+：u16 宽 @16，u16 高 @18，u16 调色板偏移 @22，u32 数据偏移 @28
    * 调色板是 4 字节 **R,G,B,A**

像素格式（``ALImageImp*::GetPixelColorMain``）：

* ``RGBA``/``8888``：R,G,B,A 字节序；``BGRA``：B,G,R,A
* ``4444``（4CC ``ABG4``）：bit0-3=A，4-7=B，8-11=G，12-15=R
  （``ALImageImp4444::SetPixelColorMain`` @0x133cf44 / ``ClearMain`` @0x133cf84）
* ``5551``（4CC ``ABG5``）：bit0=A，1-5=B，6-10=G，11-15=R
  （``ALImageImp5551::SetPixelColorMain`` @0x133d5d0 / ``ClearMain`` @0x133d60c）
* ``PAL8``/``PAL4``/``PAL1``：索引查调色板；``PAL6``：u16 索引（大调色板）

调色板字节序
    * 格式串：``ALImageImp32::GetFormat()`` @0x1340a4c 返回 1094862674 = ``"RGBA"``，
      ``ALImageImpPal8::GetFormat()`` @0x13410f0 = ``"PAL8"``、``ALImageImpPal16`` = ``"PAL6"``
      —— 32 位词小端就是 byte0=R、byte1=G、byte2=B、byte3=A。
    * 装载：``ALAigImageHandler::Load`` @0x1341eb4 把文件的 4 字节调色板向量装配成
      ``b0 | b1<<8 | b2<<16 | b3<<24``（SIMD ``vld4q_s8`` 去交织后逐字节移位或位），
      随后 ``ALPaletteImp::SetPaletteData`` @0x13bd704 对调色板数组直接 ``memcpy``
      —— 文件里的 4 字节 == 引擎 32 位词，**文件就是 R,G,B,A**。
    * 取色：``ALImageImpPal8::GetPixelColorMain`` @0x133e784 返回
      ``palette[index]``（原始 32 位词），和 ``ALImageImp32`` 的像素同域。
"""

from __future__ import annotations

import json
import struct
from dataclasses import dataclass, field

import numpy as np
from PIL import Image

ALTX_MAGIC = b"ALTX"
ALIG_MAGIC = b"ALIG"

_EXPAND4 = np.arange(16, dtype=np.uint8) * 17
_EXPAND5 = np.array([(v << 3) | (v >> 2) for v in range(32)], dtype=np.uint8)


def is_altx(data: bytes) -> bool:
    return len(data) >= 16 and data[:4] == ALTX_MAGIC


def is_alig(data: bytes) -> bool:
    return len(data) >= 32 and data[:4] == ALIG_MAGIC


# ------------------------------------------------------------------ 位图


@dataclass(slots=True)
class AligHeader:
    version: int
    flags: int
    palette_count: int
    format: str
    width: int
    height: int
    palette_offset: int
    data_offset: int


def parse_alig_header(data: bytes) -> AligHeader:
    version = data[4]
    flags = data[5]
    palette_count = struct.unpack_from("<H", data, 6)[0]
    fmt = data[8:12].decode("latin1").rstrip("\x00")
    if version == 0:
        width, height = struct.unpack_from("<II", data, 16)
        palette_offset = struct.unpack_from("<H", data, 24)[0]
        data_offset = struct.unpack_from("<H", data, 26)[0]
    elif version == 1:
        width, height = struct.unpack_from("<II", data, 16)
        palette_offset = struct.unpack_from("<H", data, 26)[0]
        data_offset = struct.unpack_from("<I", data, 28)[0]
    else:
        width, height = struct.unpack_from("<HH", data, 16)
        palette_offset = struct.unpack_from("<H", data, 22)[0]
        data_offset = struct.unpack_from("<I", data, 28)[0]
    return AligHeader(
        version=version,
        flags=flags,
        palette_count=palette_count,
        format=fmt,
        width=width,
        height=height,
        palette_offset=palette_offset,
        data_offset=data_offset,
    )


def _palette_table(data: bytes, header: AligHeader) -> np.ndarray | None:
    if header.palette_count <= 0:
        return None
    start = header.palette_offset
    end = start + header.palette_count * 4
    if end > len(data):
        return None
    return np.frombuffer(data[start:end], dtype=np.uint8).reshape(-1, 4)


def _pixels(data: bytes, header: AligHeader, count: int, width: int) -> np.ndarray:
    start = header.data_offset
    end = start + count * width
    if end > len(data):
        raise ValueError("ALIG 像素数据越界")
    return np.frombuffer(data[start:end], dtype=np.uint8)


def alig_to_image(data: bytes, header: AligHeader | None = None) -> Image.Image:
    header = header or parse_alig_header(data)
    width, height = header.width, header.height
    if width <= 0 or height <= 0:
        raise ValueError("ALIG 尺寸异常")
    fmt = header.format
    pixels = width * height

    if fmt in ("RGBA", "8888"):
        raw = _pixels(data, header, pixels, 4).reshape(height, width, 4)
        return Image.fromarray(raw, "RGBA")
    if fmt == "BGRA":
        raw = _pixels(data, header, pixels, 4).reshape(height, width, 4)
        return Image.fromarray(raw[:, :, [2, 1, 0, 3]], "RGBA")

    if fmt in ("ABG4", "4444", "ARGB4"):
        raw = np.frombuffer(
            data[header.data_offset : header.data_offset + pixels * 2], dtype="<u2"
        ).astype(np.uint16)
        out = np.empty((height, width, 4), dtype=np.uint8)
        out[:, :, 0] = _EXPAND4[(raw >> 12) & 0xF]
        out[:, :, 1] = _EXPAND4[(raw >> 8) & 0xF]
        out[:, :, 2] = _EXPAND4[(raw >> 4) & 0xF]
        out[:, :, 3] = _EXPAND4[raw & 0xF]
        return Image.fromarray(out.reshape(height, width, 4), "RGBA")

    if fmt in ("RGB5", "ABG5", "5551", "ARGB5"):
        raw = np.frombuffer(
            data[header.data_offset : header.data_offset + pixels * 2], dtype="<u2"
        ).astype(np.uint16)
        out = np.empty((height, width, 4), dtype=np.uint8)
        out[:, :, 0] = _EXPAND5[(raw >> 11) & 0x1F]
        out[:, :, 1] = _EXPAND5[(raw >> 6) & 0x1F]
        out[:, :, 2] = _EXPAND5[(raw >> 1) & 0x1F]
        out[:, :, 3] = np.where(raw & 1, 255, 0).astype(np.uint8)
        return Image.fromarray(out.reshape(height, width, 4), "RGBA")

    palette = _palette_table(data, header)

    if fmt in ("PAL6", "PAL16"):
        indices = np.frombuffer(
            data[header.data_offset : header.data_offset + pixels * 2], dtype="<u2"
        )
        if palette is None:
            raise ValueError("PAL6 缺少调色板")
        return Image.fromarray(palette[np.clip(indices, 0, len(palette) - 1)].reshape(height, width, 4))

    if fmt == "PAL4":
        packed = _pixels(data, header, (width + 1) // 2 * height, 1).reshape(height, -1)
        indices = np.empty((height, packed.shape[1] * 2), dtype=np.uint8)
        indices[:, 0::2] = packed >> 4
        indices[:, 1::2] = packed & 0x0F
        indices = indices[:, :width]
        if palette is None:
            raise ValueError("PAL4 缺少调色板")
        return Image.fromarray(palette[np.clip(indices, 0, len(palette) - 1)], "RGBA")

    if fmt == "PAL1":
        packed = _pixels(data, header, (width + 7) // 8 * height, 1).reshape(height, -1)
        bits = np.unpackbits(packed, axis=1)[:, :width]
        if palette is None:
            raise ValueError("PAL1 缺少调色板")
        return Image.fromarray(palette[np.clip(bits, 0, len(palette) - 1)], "RGBA")

    if fmt == "PAL8":
        indices = _pixels(data, header, pixels, 1).reshape(height, width)
        if palette is None:
            raise ValueError("PAL8 缺少调色板")
        return Image.fromarray(palette[np.clip(indices, 0, len(palette) - 1)], "RGBA")

    raise ValueError(f"未支持的 ALIG 格式 {fmt!r}")


@dataclass(slots=True)
class AtlasFrame:
    x: int
    y: int
    width: int
    height: int
    center_x: int = 0
    center_y: int = 0


@dataclass(slots=True)
class AtlasChild:
    share_id: int
    flags: int
    name: str = ""
    frames: list[AtlasFrame] = field(default_factory=list)


@dataclass(slots=True)
class Atlas:
    version: int
    flags: int
    name: str
    image_offset: int
    image: Image.Image | None
    children: list[AtlasChild]


def _read_cstr(data: bytes, offset: int, limit: int = 256) -> str:
    if offset < 0 or offset >= len(data):
        return ""
    end = data.find(b"\x00", offset, min(len(data), offset + limit))
    if end == -1:
        end = min(len(data), offset + limit)
    return data[offset:end].decode("utf-8", "replace")


def parse_atlas(data: bytes) -> Atlas:
    version = data[4]
    flags = data[5]
    child_count = struct.unpack_from("<H", data, 6)[0]
    image_offset = struct.unpack_from("<I", data, 8)[0]

    offsets = struct.unpack_from(f"<{child_count}H", data, 12) if child_count else ()
    # 名字紧跟在偏移表后面并按 4 字节对齐（ALTextureAtxLoader 只按偏移取子纹理）
    name_start = (12 + child_count * 2 + 3) & ~3
    atlas_name = _read_cstr(data, name_start, 64)
    if atlas_name and not atlas_name.isprintable():
        atlas_name = ""

    image = None
    image_start = image_offset
    if flags & 2:
        if flags & 4:
            if flags & 8:
                image_start += 4
            # 图像流自身带内嵌 ALIG
        else:
            image_start = struct.unpack_from("<I", data, image_offset)[0]
    if image_start < len(data) and data[image_start : image_start + 4] == ALIG_MAGIC:
        try:
            image = alig_to_image(data[image_start:])
        except ValueError:
            image = None

    children: list[AtlasChild] = []
    position = 0
    for index, raw_offset in enumerate(offsets):
        position = raw_offset if version == 0 else position + raw_offset
        if position + 8 > len(data):
            continue
        share_id, frame_count = struct.unpack_from("<IH", data, position)
        child_flags = data[position + 6]
        frames: list[AtlasFrame] = []
        frame_pos = position + 8
        for _ in range(frame_count):
            if frame_pos + 8 > len(data):
                break
            x, y, w, h = struct.unpack_from("<hhhh", data, frame_pos)
            frames.append(AtlasFrame(x, y, w, h))
            frame_pos += 8
        center_pos = position + 8 + frame_count * 8
        for frame in frames:
            if center_pos + 4 > len(data):
                break
            frame.center_x, frame.center_y = struct.unpack_from("<hh", data, center_pos)
            center_pos += 4
        child_name = ""
        if child_flags & 1:
            child_name = _read_cstr(data, center_pos, 64)
        if not child_name:
            child_name = atlas_name if index == 0 else ""
        children.append(
            AtlasChild(share_id=share_id, flags=child_flags, name=child_name, frames=frames)
        )

    if not atlas_name and children:
        atlas_name = children[0].name
    return Atlas(
        version=version,
        flags=flags,
        name=atlas_name,
        image_offset=image_offset,
        image=image,
        children=children,
    )


def atlas_metadata(atlas: Atlas) -> str:
    payload = {
        "name": atlas.name,
        "version": atlas.version,
        "flags": atlas.flags,
        "image_offset": atlas.image_offset,
        "image_size": list(atlas.image.size) if atlas.image else None,
        "sprites": [
            {
                "share_id": child.share_id,
                "flags": child.flags,
                "name": child.name,
                "frames": [
                    {
                        "x": frame.x,
                        "y": frame.y,
                        "width": frame.width,
                        "height": frame.height,
                        "center_x": frame.center_x,
                        "center_y": frame.center_y,
                    }
                    for frame in child.frames
                ],
            }
            for child in atlas.children
        ],
    }
    return json.dumps(payload, ensure_ascii=False, indent=2)
