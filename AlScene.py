"""场景装配 ``ALOD`` 与动作 ``ALMT``
``ALAssembleHandlerAod::Load`` / ``LoadSub`` / ``LoadSub2`` / ``LoadSub3``
    头（16 字节）::

        "ALOD" u8 ver u8 flags u8 节点数 u8 字段数 u32 id u32 动作偏移
        u16 节点偏移表[节点数] @16
        u16 字段名偏移表[字段数]  @16+2*节点数
        ……字段名（NUL 结尾）

    节点（``LoadSub``：``v16 = base + offset``）::

        +0  u32 id（4 字符标签，如 "WD00"）
        +4  u32 class（4 字符类名，如 "WDBU"，ALNodeFactory::CreateByID 用）
        +8  u8 属性数   +9 u8 子节点数   +10 u8 碰撞数   +11 对齐
        +12 u16 属性值偏移[属性数]     （偏移是相对节点、且以 2 字节为单位）
        +12+2*属性   u16 子节点偏移[子节点数]
        ……          u16 碰撞偏移[碰撞数]
        ……          u8  字段索引[属性数]   （指向文件头的字段名表）

    属性值长度由「下一个属性值的偏移」推出；类型按字段名 + 长度判定
    （``Pos/Scale/Center/Color3`` 浮点、``Texture0ID`` 两个 u16、
    ``ParentNodeID/WidgetTag`` 4 字符标签、``Text`` 内联字符串等），
    同时保留 ``raw`` 十六进制，避免误判丢信息。

``ALMT``（``ALMotionImpAMT``）：头 + 目标节点标签 + 字段名（带 u16 哈希）+ 动作块。
"""

from __future__ import annotations

import json
import struct

ALOD_MAGIC = b"ALOD"
ALMT_MAGIC = b"ALMT"


def is_alod(data: bytes) -> bool:
    return len(data) >= 16 and data[:4] == ALOD_MAGIC and data[4] <= 3


def is_almt(data: bytes) -> bool:
    return len(data) >= 12 and data[:4] == ALMT_MAGIC


def _cstr(data: bytes, offset: int, limit: int = 256) -> str:
    if offset < 0 or offset >= len(data):
        return ""
    end = data.find(b"\x00", offset, min(len(data), offset + limit))
    if end == -1:
        end = min(len(data), offset + limit)
    return data[offset:end].decode("utf-8", "replace")


def _tag(raw: bytes) -> str:
    return raw.decode("latin1").strip()


def _floats(raw: bytes) -> list[float]:
    return [round(v, 6) for v in struct.unpack(f"<{len(raw) // 4}f", raw)]


def _plausible_floats(raw: bytes) -> bool:
    for value in struct.unpack(f"<{len(raw) // 4}f", raw):
        if value != value or value in (float("inf"), float("-inf")):
            return False
        if value != 0.0 and abs(value) < 1e-6:
            return False
    return True


FLOAT_FIELDS = ("Pos", "Scale", "Center", "Rot", "Color", "Alpha", "Angle", "Rate", "Offset")
TAG_FIELDS = ("ParentNodeID", "NodeID", "ParentID")
TEXT_FIELDS = ("Text", "Name", "Label", "Comment")

#: 常见字段的字节长度（拿不到时退回「下一个属性偏移」推算）
FIELD_SIZE = {
    "Texture0ID": 4,
    "ParentNodeID": 4,
    "WidgetSize": 4,
    "WidgetTag": 4,
    "WidgetSkinID": 4,
    "TextSize": 4,
    "TextUseShadow": 2,
    "TextShadowColor": 16,
    "Color3": 12,
    "Color": 16,
    "Pos": 12,
    "Scale": 12,
    "Center": 12,
    "Rot": 4,
    "Alpha": 4,
    "Text": 32,
}


def decode_value(field: str, raw: bytes) -> object:
    """按字段名 + 长度解一个属性值（``raw`` 始终保留在外层）。"""
    if not raw:
        return None
    if field == "Texture0ID" and len(raw) >= 4:
        return {"Id1": struct.unpack_from("<H", raw)[0], "Id2": struct.unpack_from("<H", raw, 2)[0]}
    if field in TAG_FIELDS and len(raw) >= 4:
        return _tag(raw[:4])
    if field in TEXT_FIELDS and len(raw) >= 8:
        text = raw.split(b"\x00", 1)[0].decode("utf-8", "replace")
        if text and (not text.isascii() or text.isprintable()):
            return text
    if len(raw) % 4 == 0 and any(field.startswith(f) for f in FLOAT_FIELDS):
        return _floats(raw)
    if len(raw) == 8 and _plausible_floats(raw):
        return _floats(raw)
    if len(raw) == 12 and _plausible_floats(raw):
        return _floats(raw)
    if len(raw) == 4:
        value = struct.unpack("<i", raw)[0]
        if "Size" in field:
            return {"width": value & 0xFFFF, "height": value >> 16}
        return value
    if len(raw) == 2:
        return struct.unpack("<H", raw)[0]
    if len(raw) == 1:
        return raw[0]
    return raw.hex()


def _parse_node(data: bytes, offset: int, fields: list[str], depth: int = 0) -> dict | None:
    """解析一个节点（子节点递归，深度受限）。"""
    if depth > 4 or offset + 12 > len(data):
        return None
    node_id, node_class = struct.unpack_from("<II", data, offset)
    prop_count, child_count, collision_count = data[offset + 8], data[offset + 9], data[offset + 10]
    cursor = offset + 12
    if cursor + 2 * (prop_count + child_count + collision_count) + prop_count > len(data):
        return None
    prop_offsets = struct.unpack_from(f"<{prop_count}H", data, cursor)
    cursor += 2 * prop_count
    child_offsets = struct.unpack_from(f"<{child_count}H", data, cursor) if child_count else ()
    cursor += 2 * child_count
    collision_offsets = (
        struct.unpack_from(f"<{collision_count}H", data, cursor) if collision_count else ()
    )
    cursor += 2 * collision_count
    field_indexes = data[cursor : cursor + prop_count]

    properties: dict = {}
    for index, (value_offset, field_index) in enumerate(zip(prop_offsets, field_indexes)):
        field = fields[field_index] if field_index < len(fields) else f"field_{field_index}"
        start = offset + (value_offset & ~1)
        size = FIELD_SIZE.get(field, 0)
        if not size and index + 1 < len(prop_offsets):
            size = (prop_offsets[index + 1] & ~1) - (value_offset & ~1)
        raw = data[start : start + (size or 8)]
        properties[field] = {"value": decode_value(field, raw), "raw": raw.hex()}

    return {
        "id": _tag(struct.pack("<I", node_id)),
        "class": _tag(struct.pack("<I", node_class)),
        "properties": properties,
        "children": [
            node
            for node in (_parse_node(data, off, fields, depth + 1) for off in child_offsets)
            if node is not None
        ],
        "collisions": [
            {"offset": off, "raw": data[off : off + 8].hex()} for off in collision_offsets
        ],
    }


def parse_alod(data: bytes) -> dict:
    """完整解析 ``ALOD``：节点树 + 属性值 + 内嵌动作。"""
    version, flags = data[4], data[5]
    node_count, field_count = data[6], data[7]
    scene_id, motion_offset = struct.unpack_from("<II", data, 8)

    if 16 + 2 * (node_count + field_count) > len(data):
        raise ValueError("ALOD 偏移表越界")
    node_offsets = struct.unpack_from(f"<{node_count}H", data, 16)
    field_offsets = struct.unpack_from(f"<{field_count}H", data, 16 + 2 * node_count)
    fields = [_cstr(data, off, 64) for off in field_offsets]

    nodes = [
        node for node in (_parse_node(data, off, fields) for off in node_offsets) if node
    ]

    motions = []
    if motion_offset and motion_offset + 4 <= len(data) and data[motion_offset : motion_offset + 4] == ALMT_MAGIC:
        try:
            motions.append(parse_almt(data[motion_offset:]))
        except (ValueError, struct.error):
            motions.append({"offset": motion_offset, "size": len(data) - motion_offset})

    return {
        "_meta": {"version": version, "flags": flags, "scene_id": scene_id,
                  "node_count": node_count, "field_count": field_count},
        "fields": fields,
        "nodes": nodes,
        "motions": motions,
    }


def parse_almt(data: bytes) -> dict:
    """``ALMT`` 动作（头 + 目标节点 + 字段名 + 动作块偏移）。"""
    version = data[4]
    if version > 2:
        entry_count = struct.unpack_from("<H", data, 6)[0]
        field_count, motion_count = data[8], data[9]
        cursor = 12
    else:
        field_count, entry_count = data[6], data[7]
        motion_count = data[8]
        cursor = 12

    targets = []
    if cursor + 4 * entry_count <= len(data):
        for _ in range(entry_count):
            targets.append(_tag(data[cursor : cursor + 4]))
            cursor += 4

    motion_offsets = []
    if cursor + 4 * motion_count <= len(data):
        motion_offsets = list(struct.unpack_from(f"<{motion_count}I", data, cursor))
        cursor += 4 * motion_count

    # 字段表：u16 偏移（相对 ALMT 起点，直接指向名字；名字前 2 字节是该名字的哈希）
    field_names = []
    if cursor + 2 * field_count <= len(data):
        for offset in struct.unpack_from(f"<{field_count}H", data, cursor):
            field_names.append(_cstr(data, offset, 64))
        cursor += 2 * field_count

    return {
        "_meta": {"version": version, "entry_count": entry_count,
                  "field_count": field_count, "motion_count": motion_count},
        "targets": targets,
        "fields": field_names,
        "motions": [
            # 动作体（ALMotionBodyAMT）的关键帧还没解，按原样带上，避免丢数据
            {
                "offset": offset,
                "size": (motion_offsets[index + 1] if index + 1 < len(motion_offsets) else len(data))
                - offset,
                "raw": data[max(0, offset - 32) : (motion_offsets[index + 1] if index + 1 < len(motion_offsets) else len(data))].hex()[:8192],
            }
            for index, offset in enumerate(motion_offsets)
            if offset < len(data)
        ],
        "size": len(data),
    }


def alod_to_json(data: bytes) -> str:
    return json.dumps(parse_alod(data), ensure_ascii=False, indent=2)


def almt_to_json(data: bytes) -> str:
    return json.dumps(parse_almt(data), ensure_ascii=False, indent=2)
