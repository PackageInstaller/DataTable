"""ALAR v2 / v3 归档（Aqualead AAR）。
``ALAarArchiveHandler3``（version == 3）
    * 头：``ALAR`` + u8 ver + u8 flags + u16 count
    * u16 ``header_size`` @16，u16 偏移表 @18（共 count 项）
    * ``shift = 2 if flags & 0x08 else 0``，第 i 个条目位于 ``offsets[i] << shift``
      （相对文件头；flags & 0x04 表示 header 单独存放，见 GetHeaderMain）
    * 条目：u32 id / u32 offset / u32 size / u32 info / u16 name_hash / char name[]
      - ``info & 0x80000000`` 时才有名字，名字紧跟 name_hash
      - ``info & 0xFFFFFF`` 是 GetRangeCount（分卷数）

``ALAarArchiveHandler2``（version == 2）
    * 头：``ALAR`` + u8 ver + u8 flags + u16 count
    * 条目表 @16，每项 16 字节：u32 id / u32 offset / u32 size / u32 info
    * 文件名存在数据前面的 32 字节里（``offset - 34`` 起，NUL 结尾），
      文件名哈希是 ``offset - 2`` 处的 u16
"""

from __future__ import annotations

import struct
from dataclasses import dataclass, field

ALAR_MAGIC = b"ALAR"
NAME_FLAG = 0x80000000


@dataclass(slots=True)
class ArchiveEntry:
    index: int
    entry_id: int
    offset: int
    size: int
    info: int
    name: str | None = None
    name_hash: int = 0

    @property
    def range_count(self) -> int:
        return self.info & 0xFFFFFF


@dataclass(slots=True)
class Archive:
    version: int
    flags: int
    entries: list[ArchiveEntry] = field(default_factory=list)
    header_size: int = 0


def is_alar(data: bytes) -> bool:
    return len(data) >= 8 and data[:4] == ALAR_MAGIC


def _read_cstr(data: bytes, offset: int, limit: int = 512) -> str:
    if offset < 0 or offset >= len(data):
        return ""
    end = data.find(b"\x00", offset, min(len(data), offset + limit))
    if end == -1:
        end = min(len(data), offset + limit)
    return data[offset:end].decode("utf-8", "replace")


def parse_alar3(data: bytes) -> Archive:
    flags = data[5]
    count = struct.unpack_from("<H", data, 6)[0]
    shift = 2 if flags & 0x08 else 0
    header_size = struct.unpack_from("<H", data, 16)[0]
    archive = Archive(version=3, flags=flags, header_size=header_size)
    table_end = 18 + count * 2
    if table_end > len(data):
        raise ValueError("ALAR3 偏移表越界")
    offsets = struct.unpack_from(f"<{count}H", data, 18)
    for index, raw_offset in enumerate(offsets):
        entry_pos = raw_offset << shift
        if entry_pos + 18 > len(data):
            continue
        entry_id, offset, size, info = struct.unpack_from("<IIII", data, entry_pos)
        name_hash = struct.unpack_from("<H", data, entry_pos + 16)[0]
        name = None
        if info & NAME_FLAG:
            name = _read_cstr(data, entry_pos + 18)
        archive.entries.append(
            ArchiveEntry(index, entry_id, offset, size, info, name, name_hash)
        )
    return archive


def parse_alar2(data: bytes) -> Archive:
    flags = data[5]
    count = struct.unpack_from("<H", data, 6)[0]
    archive = Archive(version=2, flags=flags, header_size=16 + count * 16)
    for index in range(count):
        entry_pos = 16 + 16 * index
        if entry_pos + 16 > len(data):
            break
        entry_id, offset, size, info = struct.unpack_from("<IIII", data, entry_pos)
        name = None
        name_hash = 0
        if info & NAME_FLAG:
            # 名字挂在数据前面：32 字节字符串 + u16 哈希
            name = _read_cstr(data, offset - 34, 32)
            if offset >= 2:
                name_hash = struct.unpack_from("<H", data, offset - 2)[0]
        archive.entries.append(
            ArchiveEntry(index, entry_id, offset, size, info, name, name_hash)
        )
    return archive


def parse_alar(data: bytes) -> Archive:
    if not is_alar(data):
        raise ValueError("不是 ALAR 归档")
    version = data[4]
    if version == 3:
        return parse_alar3(data)
    if version == 2:
        return parse_alar2(data)
    raise ValueError(f"未知的 ALAR 版本 {version}")


def iter_members(data: bytes, archive: Archive | None = None):
    """产出 ``(名字, 数据)``；无名条目用 ``%04d`` 序号占位。"""
    archive = archive or parse_alar(data)
    for entry in archive.entries:
        if entry.offset + entry.size > len(data):
            continue
        name = entry.name or f"{entry.index:04d}_{entry.entry_id:08X}.bin"
        yield name, data[entry.offset : entry.offset + entry.size]


def has_named_members(data: bytes) -> bool:
    try:
        archive = parse_alar(data)
    except ValueError:
        return False
    return any(entry.info & NAME_FLAG for entry in archive.entries)
