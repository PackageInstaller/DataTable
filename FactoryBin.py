"""BinaryConfig/*.bin 反序列化。

对应 IDA：
    DataManager.loadSingleFactoryBIN          @ 0x02C3EB74
    BinarySectionContext.ReadData             @ 0x0321AC40
    BinarySection.ReadData / ReadLine         @ 0x03218C74 / 0x03218E38
    CAPropertyBinarySection.ReadData          @ 0x02F3ACA0
    CAPropertyBinarySection.ReadSingleProperty@ 0x02F3AEC4
    CAIndexBinarySection.ReadData             @ 0x02F3A9F8
    PropertyType 枚举                         il2cpp.cs TypeDef 13124

文件布局（WriteData @ 0x0321AFC0）：
    u8 version(=1)
    BinaryReader.ReadString hash              # 7-bit 长度 + UTF-8，32+32 hex MD5
    i32 stringPoolLength
    [string pool]                             # 若干 ReadString
    i32 rootSize
    [SingleBin: metaSection + menuSection + dataSection]
"""

from __future__ import annotations

import gzip
import json
import struct
from pathlib import Path
from typing import Any, Callable

PROPERTY_TYPE = {
    0: "Int",
    1: "Double",
    2: "SafeNumber",
    3: "Bool",
    4: "String",
    5: "Enum",
    6: "Factory",
    7: "Array",
    8: "Tree",
    9: "Png",
    10: "Rect",
    11: "Text",
    12: "StringT",
    13: "TextT",
    14: "Path",
    15: "Long",
    90: "SysButton",
    91: "SysLine",
    99: "Array_Item_VO",
}

_POOL_STRING = frozenset({4, 5, 9, 10, 11, 12, 13, 14})
_INT32 = frozenset({0, 6})
_INT64 = frozenset({2, 15})
_ARRAY = frozenset({7, 8})


class BinError(ValueError):
    pass


class _Cur:
    def __init__(self, data: bytes) -> None:
        self.b = data
        self.i = 0
        self.pool_start = 0
        self.pool_len = 0
        self._pool: dict[int, str] = {}

    def remain(self) -> int:
        return len(self.b) - self.i

    def seek(self, pos: int) -> None:
        if pos < 0 or pos > len(self.b):
            raise BinError(f"seek {pos} out of {len(self.b)}")
        self.i = pos

    def u8(self) -> int:
        if self.i >= len(self.b):
            raise BinError("eof u8")
        v = self.b[self.i]
        self.i += 1
        return v

    def i32(self) -> int:
        if self.i + 4 > len(self.b):
            raise BinError("eof i32")
        v = struct.unpack_from("<i", self.b, self.i)[0]
        self.i += 4
        return v

    def i64(self) -> int:
        if self.i + 8 > len(self.b):
            raise BinError("eof i64")
        v = struct.unpack_from("<q", self.b, self.i)[0]
        self.i += 8
        return v

    def f64(self) -> float:
        if self.i + 8 > len(self.b):
            raise BinError("eof f64")
        v = struct.unpack_from("<d", self.b, self.i)[0]
        self.i += 8
        return v

    def take(self, n: int) -> bytes:
        if n < 0 or self.i + n > len(self.b):
            raise BinError(f"eof take {n}")
        v = self.b[self.i : self.i + n]
        self.i += n
        return v

    def r7(self) -> int:
        n = 0
        shift = 0
        while True:
            b = self.u8()
            n |= (b & 0x7F) << shift
            if b < 0x80:
                return n
            shift += 7
            if shift > 35:
                raise BinError("bad 7-bit int")

    def dotnet_string(self) -> str:
        n = self.r7()
        if n == 0:
            return ""
        return self.take(n).decode("utf-8", "replace")

    def pool_str(self, off: int) -> str:
        if off in self._pool:
            return self._pool[off]
        if off < 0 or off >= self.pool_len:
            return ""
        saved = self.i
        try:
            self.seek(self.pool_start + off)
            s = self.dotnet_string()
        except BinError:
            s = ""
        finally:
            self.i = saved
        self._pool[off] = s
        return s


def _align(c: _Cur, start: int, size: int) -> None:
    end = start + size
    if end < c.i or end > len(c.b):
        raise BinError(f"section overread {c.i} vs {start}+{size}")
    c.seek(end)


def _read_primitive(c: _Cur, item_type: int) -> Any:
    if item_type in _INT32:
        return c.i32()
    if item_type == 1:
        return c.f64()
    if item_type in _INT64:
        return c.i64()
    if item_type == 3:
        return bool(c.u8())
    if item_type in _POOL_STRING:
        return c.pool_str(c.i32())
    raise BinError(f"primitive itemType {item_type}")


def _read_array(c: _Cur) -> list[Any]:
    # ArrayInfoTable：itemType + numItems + items[numItems]
    # GetLineTypeRealTime 把 items 固定成 PropertyMap；空数组常见 itemType=99。
    size = c.i32()
    start = c.i
    item_type = c.u8()
    n = c.i32()
    saved = c.i
    items: list[Any] = []
    try:
        for _ in range(max(n, 0)):
            items.append(_read_property_map(c))
        _align(c, start, size)
    except BinError:
        c.i = saved
        try:
            items = [_read_primitive(c, item_type) for _ in range(max(n, 0))]
            _align(c, start, size)
        except BinError:
            c.seek(start + size)
            items = [{"_unparsed": True, "itemType": item_type, "numItems": n}]
    return items


def _read_value(c: _Cur, ptype: int) -> Any:
    if ptype in _INT32:
        return c.i32()
    if ptype == 1:
        return c.f64()
    if ptype in _INT64:
        return c.i64()
    if ptype == 3:
        return bool(c.u8())
    if ptype in _POOL_STRING:
        return c.pool_str(c.i32())
    if ptype in _ARRAY:
        return _read_array(c)
    raise BinError(f"PropertyType {ptype}")


def _read_ca_property(c: _Cur) -> tuple[str, int, Any]:
    size = c.i32()
    start = c.i
    key = c.pool_str(c.i32())
    ptype = c.u8()
    value = _read_value(c, ptype)
    _align(c, start, size)
    return key, ptype, value


def _read_property_map(c: _Cur) -> dict[str, Any]:
    size = c.i32()
    start = c.i
    n = c.i32()
    out: dict[str, Any] = {}
    for _ in range(max(n, 0)):
        key, _ptype, value = _read_ca_property(c)
        out[key] = value
    _align(c, start, size)
    return out


def _read_ca_index(c: _Cur) -> dict[str, Any]:
    size = c.i32()
    start = c.i
    cid = c.i32()
    idcn = c.pool_str(c.i32())
    index = c.i32()
    _align(c, start, size)
    return {"id": cid, "idCN": idcn, "index": index}


def parse_factory_bin(data: bytes) -> dict[str, Any]:
    c = _Cur(data)
    ver = c.u8()
    if ver != 1:
        raise BinError(f"BinarySection version {ver}")
    digest = c.dotnet_string()
    c.pool_len = c.i32()
    c.pool_start = c.i
    if c.pool_len < 0 or c.pool_start + c.pool_len > len(data):
        raise BinError("bad string pool")
    c.seek(c.pool_start + c.pool_len)

    root_size = c.i32()
    root_start = c.i

    meta_size = c.i32()
    meta_start = c.i
    meta = {
        "author": c.dotnet_string(),
        "date": c.i64(),
        "etc": c.dotnet_string(),
    }
    _align(c, meta_start, meta_size)

    menu_size = c.i32()
    menu_start = c.i
    n_menu = c.i32()
    indexes = [_read_ca_index(c) for _ in range(max(n_menu, 0))]
    _align(c, menu_start, menu_size)

    data_size = c.i32()
    data_start = c.i
    n_data = c.i32()
    cas = [_read_property_map(c) for _ in range(max(n_data, 0))]
    _align(c, data_start, data_size)
    _align(c, root_start, root_size)

    records: list[dict[str, Any]] = []
    for idx in indexes:
        rec: dict[str, Any] = {"id": idx["id"], "idCN": idx["idCN"]}
        i = idx["index"]
        if isinstance(i, int) and 0 <= i < len(cas):
            for k, v in cas[i].items():
                if k not in rec:
                    rec[k] = v
        records.append(rec)
    return {
        "version": ver,
        "hash": digest,
        "meta": meta,
        "count": len(records),
        "records": records,
    }


def _read_checked_strings(c: _Cur) -> tuple[list[str], int]:
    n = c.i32()
    items = [c.dotnet_string() for _ in range(max(n, 0))]
    checksum = c.i32()
    return items, checksum


def parse_guide_asset(data: bytes) -> dict[str, Any]:
    """SplitPackageController.ReadGuideAssetBinary @ 0x02BA58F4。

    gzip 后：count + ReadString×N + checksum，共三段
    specialPathList / removeSpecialPathList / maskedFileList。
    """
    if data[:2] == b"\x1f\x8b":
        data = gzip.decompress(data)
    c = _Cur(data)
    special, cs1 = _read_checked_strings(c)
    remove, cs2 = _read_checked_strings(c)
    masked, cs3 = _read_checked_strings(c)
    return {
        "specialPathList": special,
        "removeSpecialPathList": remove,
        "maskedFileList": masked,
        "checksum": [cs1, cs2, cs3],
        "remain": c.remain(),
    }


def dump_factory_file(src: Path, dest: Path) -> None:
    payload = parse_factory_bin(src.read_bytes())
    dest.parent.mkdir(parents=True, exist_ok=True)
    dest.write_text(json.dumps(payload, ensure_ascii=False, indent=2), encoding="utf-8")


def dump_all_factories(
    src_dir: Path,
    dest_dir: Path,
    on_file: Callable[[Path, bool, str | None], None] | None = None,
) -> tuple[int, int]:
    ok = fail = 0
    files = sorted(p for p in src_dir.glob("*.bin") if p.is_file())
    dest_dir.mkdir(parents=True, exist_ok=True)
    for path in files:
        dest = dest_dir / (path.stem + ".json")
        try:
            dump_factory_file(path, dest)
            ok += 1
            if on_file:
                on_file(path, True, None)
        except Exception as exc:  # noqa: BLE001
            fail += 1
            if on_file:
                on_file(path, False, str(exc))
    return ok, fail
