"""Aqualead 数据表：``ALTB`` 记录表 + ``ALRD`` 结构定义。
* ``ALRecordPropBind::CreateTry``（0x1414440）解析 ``ALRD``：
  magic(4) + u8 ver + u8 flags + u16 字段数 + u16 记录长度，随后每个字段是
  ``u16 记录内偏移 + u8 类型 + u8 标志 + u8 主名长度 + u8 别名长度``
  + 主名(NUL) + 别名(NUL) + 对齐 4 + 类型参数 + 对齐 4。
  类型参数长度由 switch 的读取字节数决定（PARAM_SIZE）。
* 字段类型 -> ``ALTableDirect*PropImp`` 类名给出了记录内值的真实类型：

  ====== ============================= ====
  类型   类                            大小
  ====== ============================= ====
  1      ALTableDirectIntPropImp        4
  2      ALTableDirectInt16PropImp      2
  3      ALTableDirectInt8PropImp       1
  4      ALTableDirectFloatPropImp      4
  5      ALTableDirectBoolPropImp       1
  6      ALTableDirectAnglePropImp      4
  7      ALTableDirectDatePropImp       4
  8      ALTableDirectTimePropImp       4
  9      ALTableDirectDateTimePropImp   8
  10     ALTableDirectInt64PropImp      8
  11     ALTableDirectDoublePropImp     8
  32     ALTableDirectRefStringPropImp  4
  33     ALTableDirectValueStringPropImp 32
  64     ALTableDirectVectorPropImp    12
  65     ALTableDirectColorPropImp     16
  66     ALTableDirectRectPropImp      16
  ====== ============================= ====

* ``ALTB`` 头：magic(4) + u8 ver + u8 flags + u16 记录数 + u16 schema偏移 +
  u16 数据偏移 + u16 记录长度，flags & 4 时后面还有 8 字节，其中 u32@20 是
  字符串池偏移（长度前缀类型 32 的值都相对这里）。
"""

from __future__ import annotations

import json
import struct
from dataclasses import dataclass

ALTB_MAGIC = b"ALTB"
ALRD_MAGIC = b"ALRD"

#: 类型参数区长度（IDA ``ALRecordPropBind::CreateTry`` switch 各分支的 Read 总和）
PARAM_SIZE: dict[int, int] = {
    1: 8,
    2: 4,
    3: 2,
    4: 12,
    5: 1,
    6: 8,
    7: 8,
    8: 8,
    9: 8,
    10: 16,
    11: 12,
    32: 0,
    33: 4,
    64: 4,
    65: 0,
    66: 0,
    96: 4,
    97: 6,
    98: 0,
    99: 10,
    100: 0,
}

#: 记录内值的大小（字节）
VALUE_SIZE: dict[int, int] = {
    1: 4,
    2: 2,
    3: 1,
    4: 4,
    5: 1,
    6: 4,
    7: 4,
    8: 4,
    9: 8,
    10: 8,
    11: 8,
    32: 4,
    33: 32,
    64: 12,
    65: 16,
    66: 16,
    96: 4,
    97: 4,
    98: 0,
    99: 4,
    100: 0,
}

#: 类型名（写进 JSON 的 ``_fields``）
TYPE_NAME: dict[int, str] = {
    1: "int32",
    2: "int16",
    3: "int8",
    4: "float",
    5: "bool",
    6: "angle",
    7: "date",
    8: "time",
    9: "datetime",
    10: "int64",
    11: "double",
    32: "string",
    33: "fixed_string",
    64: "vector3",
    65: "color",
    66: "rect",
    96: "table_ref",
    97: "lookup",
    98: "record_index",
    99: "lookup2",
    100: "func",
}


@dataclass(slots=True)
class Field:
    name: str
    alias: str
    type_code: int
    flags: int
    offset: int
    size: int

    @property
    def type_name(self) -> str:
        return TYPE_NAME.get(self.type_code, f"unknown_{self.type_code}")


@dataclass(slots=True)
class Table:
    version: int
    flags: int
    record_count: int
    record_size: int
    data_offset: int
    schema_offset: int
    string_pool: int | None
    fields: list[Field]
    tag: str = ""

    @property
    def is_table(self) -> bool:
        return bool(self.fields)


def is_altb(data: bytes) -> bool:
    return len(data) >= 20 and data[:4] == ALTB_MAGIC


def is_alrd(data: bytes) -> bool:
    return len(data) >= 10 and data[:4] == ALRD_MAGIC


def parse_schema(data: bytes, offset: int, end: int | None = None) -> tuple[list[Field], int, int]:
    """解析 ``ALRD``，返回 ``(字段表, 记录长度(可能为 0), 结束位置)``。"""
    if data[offset : offset + 4] != ALRD_MAGIC:
        raise ValueError("缺少 ALRD magic")
    end = len(data) if end is None else min(end, len(data))
    field_count = struct.unpack_from("<H", data, offset + 6)[0]
    record_size = struct.unpack_from("<H", data, offset + 8)[0]
    pos = offset + 10
    fields: list[Field] = []
    for _ in range(field_count):
        if pos + 6 > end:
            break
        field_offset, type_code, field_flags, len1, len2 = struct.unpack_from(
            "<HBBBB", data, pos
        )
        pos += 6
        name = data[pos : pos + len1].decode("utf-8", "replace")
        pos += len1 + 1
        alias = data[pos : pos + len2].decode("utf-8", "replace")
        pos += len2 + 1
        pos = (pos + 3) & ~3
        pos += PARAM_SIZE.get(type_code, 0)
        pos = (pos + 3) & ~3
        fields.append(
            Field(
                name=name or f"field_{field_offset}",
                alias=alias,
                type_code=type_code,
                flags=field_flags,
                offset=field_offset,
                size=0,
            )
        )
    _fill_sizes(fields, record_size)
    return fields, record_size, pos


def _fill_sizes(fields: list[Field], record_size: int) -> None:
    """用偏移差补全字段宽度，保证每个字段都能取到值。"""
    ordered = sorted(fields, key=lambda f: f.offset)
    limit = record_size or 0
    for index, field in enumerate(ordered):
        size = VALUE_SIZE.get(field.type_code, 0)
        next_offset = ordered[index + 1].offset if index + 1 < len(ordered) else limit
        if next_offset and next_offset > field.offset:
            span = next_offset - field.offset
            if size == 0 or size > span:
                size = span
        field.size = size


def parse_table(data: bytes) -> Table:
    """解析 ``ALTB``（含内嵌 schema）。"""
    if not is_altb(data):
        raise ValueError("不是 ALTB 数据")
    version, flags = data[4], data[5]
    record_count, schema_offset, data_offset, record_size = struct.unpack_from(
        "<HHHH", data, 6
    )
    string_pool = None
    if flags & 0x04 and len(data) >= 24:
        string_pool = struct.unpack_from("<I", data, 20)[0]
        if string_pool >= len(data):
            string_pool = None
    schema = data[schema_offset : schema_offset + 4]
    if schema != ALRD_MAGIC:
        raise ValueError(f"ALTB schema 位置异常 @0x{schema_offset:X}")
    fields, embedded_record_size, _ = parse_schema(data, schema_offset, data_offset)
    if not record_size:
        record_size = embedded_record_size
    if not record_size and fields:
        record_size = max((f.offset + f.size for f in fields), default=0)
    tag = ""
    if flags & 0x10 and len(data) >= 20:
        raw = data[16:20]
        if all(0x20 <= b < 0x7F for b in raw):
            tag = raw.decode("ascii")
    return Table(
        version=version,
        flags=flags,
        record_count=record_count,
        record_size=record_size,
        data_offset=data_offset,
        schema_offset=schema_offset,
        string_pool=string_pool,
        fields=fields,
        tag=tag,
    )


def _decode_value(field: Field, raw: bytes, strings: bytes | None) -> object:
    code = field.type_code
    if code == 1:
        return struct.unpack_from("<i", raw)[0]
    if code == 2:
        return struct.unpack_from("<h", raw)[0]
    if code == 3:
        return struct.unpack_from("<b", raw)[0]
    if code == 4:
        return round(struct.unpack_from("<f", raw)[0], 6)
    if code == 5:
        return bool(raw[0])
    if code == 6:
        # ALTableDirectAnglePropImp：u32 定点角度（ALFixNum，360 度 = 1<<16）
        return round(struct.unpack_from("<I", raw)[0] / 65536.0, 4)
    if code == 7:
        return struct.unpack_from("<I", raw)[0]
    if code == 8:
        return struct.unpack_from("<I", raw)[0]
    if code == 9:
        date, time = struct.unpack_from("<II", raw)
        return {"date": date, "time": time}
    if code == 10:
        return struct.unpack_from("<q", raw)[0]
    if code == 11:
        return round(struct.unpack_from("<d", raw)[0], 6)
    if code == 32:
        offset = struct.unpack_from("<I", raw)[0]
        if strings is None or offset >= len(strings):
            return None if strings is not None else ""
        end = strings.find(b"\x00", offset)
        if end == -1:
            end = len(strings)
        return strings[offset:end].decode("utf-8", "replace")
    if code == 33:
        end = raw.find(b"\x00")
        text = raw[:end] if end != -1 else raw
        return text.decode("utf-8", "replace")
    if code == 64:
        x, y, z = struct.unpack_from("<fff", raw)
        return {"x": round(x, 4), "y": round(y, 4), "z": round(z, 4)}
    if code == 65:
        r, g, b, a = struct.unpack_from("<ffff", raw)
        return {"r": round(r, 4), "g": round(g, 4), "b": round(b, 4), "a": round(a, 4)}
    if code == 66:
        x, y, w, h = struct.unpack_from("<ffff", raw)
        return {"x": round(x, 4), "y": round(y, 4), "w": round(w, 4), "h": round(h, 4)}
    if code in (96, 97, 99):
        return struct.unpack_from("<I", raw[:4])[0]
    return raw.hex()


def iter_records(data: bytes, table: Table) -> list[dict]:
    """按 schema 解出所有记录（``struct.unpack_from`` 批量取值，速度优先）。"""
    strings = None
    if table.string_pool is not None:
        strings = data[table.string_pool :]
    fields = sorted(table.fields, key=lambda f: f.offset)
    records: list[dict] = []
    base = table.data_offset
    record_size = table.record_size
    limit = len(data)
    for index in range(table.record_count):
        start = base + index * record_size
        if record_size <= 0 or start + record_size > limit:
            break
        row = data[start : start + record_size]
        record: dict = {}
        for field in fields:
            size = field.size
            if size <= 0 or field.type_code in (98, 100):
                continue
            chunk = row[field.offset : field.offset + size]
            if len(chunk) < size:
                continue
            try:
                record[field.name] = _decode_value(field, chunk, strings)
            except struct.error:
                record[field.name] = chunk.hex()
        records.append(record)
    return records


def table_to_dict(data: bytes, table: Table | None = None, *, with_fields: bool = True) -> dict:
    table = table or parse_table(data)
    output: dict = {
        "_meta": {
            "version": table.version,
            "flags": f"0x{table.flags:02X}",
            "record_count": table.record_count,
            "record_size": table.record_size,
            "tag": table.tag,
            # ALDate/ALTime 的编码（见 IDA ALDate::ALDate / GetYear）：
            #   日期 = 距 0001-01-01 的天数，时间 = 距 00:00 的秒数
            "date_epoch": "0001-01-01" if _has_date_types(table) else "",
        },
    }
    if with_fields:
        output["_fields"] = [
            {
                "name": field.name,
                "alias": field.alias,
                "type": field.type_name,
                "type_code": field.type_code,
                "offset": field.offset,
                "size": field.size,
            }
            for field in sorted(table.fields, key=lambda f: f.offset)
        ]
    output["records"] = iter_records(data, table)
    return output


def _has_date_types(table: Table) -> bool:
    return any(field.type_code in (7, 8, 9) for field in table.fields)


def table_to_json(data: bytes, table: Table | None = None, *, indent: int = 2) -> str:
    return json.dumps(
        table_to_dict(data, table), ensure_ascii=False, indent=indent
    )
