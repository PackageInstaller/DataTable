"""Unity 6000.5 (SerializedFile v23) AssetBundle 极简解析器。

UnityPy 1.25.x 尚不认识该格式，这里手写解析：
  UnityFS v8 头 + BlockInfoNeedPaddingAtStart(0x200) 数据对齐
  SerializedFile v23: 48 字节大端头 / type 带 [16B hash][16B tree_hash][u32 size]['mhtt' blob]
  对象表: [pathID i64][offset u64][size u32][flags u32]，offset 相对 data_offset
只用于提取 TextAsset（m_Name + m_Script）等固定布局对象。
"""

from __future__ import annotations

import lz4.block
import struct
from dataclasses import dataclass
from typing import Dict, List, Optional


@dataclass
class UnityObject:
    path_id: int
    type_id: int
    offset: int  # 相对 data_offset
    size: int

    def data(self, buf: bytes, data_offset: int) -> bytes:
        start = data_offset + self.offset
        return buf[start:start + self.size]


def _decompress_blocks(bundle: bytes) -> bytes:
    if not bundle.startswith(b"UnityFS"):
        return bundle
    i = bundle.index(b"\0") + 1
    fmt = struct.unpack_from(">I", bundle, i)[0]
    i += 4
    j = bundle.index(b"\0", i)
    j2 = bundle.index(b"\0", j + 1)
    i = j2 + 1
    _size, comp_size, uncomp_size, flags = struct.unpack_from(">QIII", bundle, i)
    i += 20
    if fmt >= 7:
        i = (i + 15) & ~15  # align_stream(16)

    def lz4_decompress(raw: bytes, out_size: int) -> bytes:
        return lz4.block.decompress(raw, uncompressed_size=out_size)

    if flags & 0x80:  # BlocksInfoAtTheEnd
        info = bundle[len(bundle) - comp_size:]
    else:
        info = bundle[i:i + comp_size]
    ct = flags & 0x3F
    if ct == 1 or ct == 3:
        info = lz4_decompress(info, uncomp_size)
    elif ct == 2:
        import lzma
        info = lzma.decompress(info)
    hash_len = 16
    nb = struct.unpack_from(">I", info, hash_len)[0]
    p = hash_len + 4
    blocks = []
    for _ in range(nb):
        unc, comp, bflags = struct.unpack_from(">IIH", info, p)
        blocks.append((unc, comp, bflags))
        p += 10
    nn = struct.unpack_from(">I", info, p)[0]
    p += 4
    for _ in range(nn):
        p += 16  # offset i64 + size i64
        p += 4   # flags u32
        end = info.index(b"\0", p)
        node_name = info[p:end].decode("utf-8", "replace")
        p = end + 1

    data_start = (i + comp_size + 15) & ~15 if flags & 0x200 else i + comp_size
    if flags & 0x80:
        data_start = i
    out = bytearray()
    off = data_start
    for unc, comp, bflags in blocks:
        raw = bundle[off:off + comp]
        ct2 = bflags & 0x3F
        if ct2 == 1 or ct2 == 3:
            out += lz4_decompress(raw, unc)
        elif ct2 == 2:
            import lzma
            out += lzma.decompress(raw)
        else:
            out += raw
        off += comp
    return bytes(out)


def _parse_tree_blob(blob: bytes) -> None:
    """'mhtt' blob 只做合法性检查（TextAsset 布局固定，无需完整树）。"""
    if blob[:4] != b"mhtt":
        raise ValueError("bad type tree magic")
    bver, nodes, ssize = struct.unpack_from("<III", blob, 4)
    if bver < 19:
        node_size = 24
    else:
        node_size = 32
    if len(blob) < 16 + nodes * node_size + ssize:
        raise ValueError("truncated type tree")


def parse_serialized_v23(buf: bytes) -> Dict[str, object]:
    """解析 SerializedFile v23，返回 {data_offset, objects: {name: UnityObject}}。"""
    version = struct.unpack_from(">I", buf, 8)[0]
    metadata_size = struct.unpack_from(">Q", buf, 0x10)[0]
    _file_size = struct.unpack_from(">Q", buf, 0x18)[0]
    data_offset = struct.unpack_from(">Q", buf, 0x20)[0]
    if version < 22:
        raise ValueError(f"only v22/23 supported, got {version}")

    pos = 0x30
    end = buf.index(b"\0", pos)
    pos = end + 1  # unity version string ("0.0.0")
    pos += 4  # target platform
    enable_tree = buf[pos]
    pos += 1
    type_count = struct.unpack_from("<I", buf, pos)[0]
    pos += 4

    types: List[int] = []
    for _ in range(type_count):
        class_id = struct.unpack_from("<i", buf, pos)[0]
        pos += 4
        stripped = buf[pos]
        pos += 1
        script_idx = struct.unpack_from("<h", buf, pos)[0]
        pos += 2
        if script_idx >= 0 or class_id in (-1, 114) or class_id == 2089858483:
            pos += 16  # script_id
        pos += 16  # old_type_hash
        if enable_tree and not stripped and version >= 23:
            pos += 16  # tree hash
            tree_size = struct.unpack_from("<I", buf, pos)[0]
            pos += 4
            _parse_tree_blob(buf[pos:pos + tree_size])
            pos += tree_size
        if version >= 21:
            deps = struct.unpack_from("<I", buf, pos)[0]
            pos += 4 + 4 * deps
        types.append(class_id)

    obj_count = struct.unpack_from("<I", buf, pos)[0]
    pos += 4
    objects: Dict[str, object] = {}
    raw_objects = []
    pos = (pos + 3) & ~3  # 对齐到 4 字节
    for _ in range(obj_count):
        path_id, off, size, oflags = struct.unpack_from("<qQII", buf, pos)
        pos += 24
        raw_objects.append(UnityObject(path_id, 0, off, size))

    # script types
    if version >= 11:
        sc = struct.unpack_from("<I", buf, pos)[0]
        pos += 4
        pos += sc * 12
    # externals
    ec = struct.unpack_from("<I", buf, pos)[0]
    pos += 4
    for _ in range(ec):
        pos += 12
        end = buf.index(b"\0", pos)
        pos = end + 1
    if version >= 20:
        rc = struct.unpack_from("<I", buf, pos)[0]
        pos += 4
        for _ in range(rc):
            class_id = struct.unpack_from("<i", buf, pos)[0]
            pos += 4
            stripped = buf[pos]
            pos += 1
            script_idx = struct.unpack_from("<h", buf, pos)[0]
            pos += 2
            if script_idx >= 0:
                pos += 16
            pos += 16
            if enable_tree and not stripped and version >= 23:
                pos += 16
                tree_size = struct.unpack_from("<I", buf, pos)[0]
                pos += 4 + tree_size
            if version >= 21:
                deps = struct.unpack_from("<I", buf, pos)[0]
                pos += 4 + 4 * deps
                for _i in range(3):  # class name / namespace / assembly
                    end = buf.index(b"\0", pos)
                    pos = end + 1
    return {"data_offset": data_offset, "objects": raw_objects, "types": types}


def read_text_asset(obj_data: bytes) -> tuple[str, bytes]:
    """TextAsset: [u32 len][m_Name bytes, 4 对齐][u32 len][m_Script bytes]。"""
    ln = struct.unpack_from("<I", obj_data, 0)[0]
    name = obj_data[4:4 + ln].decode("utf-8", "replace").rstrip("\0")
    q = 4 + ((ln + 3) & ~3)
    slen = struct.unpack_from("<I", obj_data, q)[0]
    return name, obj_data[q + 4:q + 4 + slen]


def extract_text_assets(bundle_path) -> List[tuple[str, bytes]]:
    """从 UnityFS bundle 中提取全部 TextAsset (name, data)。"""
    with open(bundle_path, "rb") as f:
        buf = f.read()
    inner = _decompress_blocks(buf)
    info = parse_serialized_v23(inner)
    out = []
    data_offset = info["data_offset"]
    for obj in info["objects"]:
        try:
            raw = obj.data(inner, data_offset)
            name, payload = read_text_asset(raw)
            out.append((name, payload))
        except Exception:  # noqa: BLE001
            continue
    return out
