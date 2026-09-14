"""热更清单格式
    ALHttpImp::Open(http, url); ALHttpImp::Wait(http);
    for (i = 0; i < size; ++i) buf[i] ^= 0xDA;
    ALStringListImp::Load(list, stream);

解出来是 CSV，每行 5 段：

    <组哈希 sha1>,<内容 md5>,<flags>,<12 位左补零的文件大小>,<逻辑资源名>

例：
    cc4d86565a1c1d6aa8f6b44a7b02810d48f38d4c,94813ead410360a7bbac5e7b5ba86632,5,000000721636,AnnounceMenu.aar

资源 URL = ``<CDN>/<组哈希>/<内容 md5>``，文件名就是内容的 md5（``ALCalcMD5``）。
"""

from __future__ import annotations

import json
import re
from dataclasses import asdict, dataclass
from pathlib import Path

MANIFEST_XOR = 0xDA


@dataclass(slots=True)
class AssetEntry:
    group: str
    md5: str
    flag: int
    size: int
    name: str

    @property
    def url(self) -> str:
        from Config import CDN_HOST

        return f"{CDN_HOST}{self.group}/{self.md5}"

    @property
    def suffix(self) -> str:
        dot = self.name.rfind(".")
        return self.name[dot:].lower() if dot != -1 else ""

    def to_dict(self) -> dict:
        return asdict(self)


def decode(data: bytes) -> list[AssetEntry]:
    """XOR 0xDA 后按 CSV 解析。"""
    text = bytes(b ^ MANIFEST_XOR for b in data).decode("utf-8", "replace")
    entries: list[AssetEntry] = []
    for line in text.splitlines():
        line = line.strip()
        if not line:
            continue
        parts = line.split(",")
        if len(parts) != 5:
            raise ValueError(f"清单格式异常: {line[:80]!r}")
        group, md5, flag, size, name = parts
        if len(group) != 40 or len(md5) != 32:
            raise ValueError(f"清单哈希异常: {line[:80]!r}")
        entries.append(
            AssetEntry(
                group=group.lower(),
                md5=md5.lower(),
                flag=int(flag or 0),
                size=int(size),
                name=name,
            )
        )
    return entries


def looks_like_manifest(data: bytes, *, sample: int = 8) -> bool:
    """判断一份数据是不是（异或过的）清单，用于自动识别。"""
    if len(data) < 64:
        return False
    try:
        text = bytes(b ^ MANIFEST_XOR for b in data[:8192]).decode("ascii")
    except UnicodeDecodeError:
        return False
    lines = [line for line in text.split("\n") if line.strip()][:sample]
    if len(lines) < 2:
        return False
    for line in lines:
        parts = line.split(",")
        if len(parts) != 5:
            return False
        group, md5, _flag, size, name = parts
        if len(group) != 40 or len(md5) != 32 or not size.isdigit() or not name:
            return False
        if not all(c in "0123456789abcdef" for c in group + md5):
            return False
    return True


def load(path: Path) -> list[AssetEntry]:
    """读本地清单：原始（XOR 过的）二进制或导出的 json 都认。"""
    data = Path(path).read_bytes()
    if data[:1] == b"[":
        return [AssetEntry(**item) for item in json.loads(data)]
    return decode(data)


def dump_json(entries: list[AssetEntry], path: Path) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(
        json.dumps([e.to_dict() for e in entries], ensure_ascii=False, indent=2),
        encoding="utf-8",
    )


def filter_entries(
    entries: list[AssetEntry],
    *,
    suffixes: tuple[str, ...] = (),
    limit: int = 0,
) -> list[AssetEntry]:
    """按扩展名过滤（例如只要数据表 ``atb/ard``）。"""
    selected = entries
    if suffixes:
        wanted = {s.lower() if s.startswith(".") else "." + s.lower() for s in suffixes}
        selected = [e for e in selected if e.suffix in wanted]
    return selected[:limit] if limit > 0 else selected


def stats(entries: list[AssetEntry]) -> dict:
    total = sum(e.size for e in entries)
    by_ext: dict[str, int] = {}
    for entry in entries:
        by_ext[entry.suffix] = by_ext.get(entry.suffix, 0) + 1
    return {
        "entries": len(entries),
        "bytes": total,
        "mb": round(total / 1048576, 1),
        "by_ext": dict(sorted(by_ext.items(), key=lambda kv: -kv[1])),
    }


# ------------------------------------------------------------------ API（查 AssetPath）

#: 每个 API 端点的报文体 XOR key（常量就在调用点，如 ``sub_D05028`` 的 ``LOBYTE(v24)=79``）
API_KEYS = {
    "jWbtv5NR": {"request": 0x4F, "response": 0x27},
    "Vp3nCs62": {"request": 0x12, "response": 0x31},
    "Pp8JnRQx": {"request": 0x5C, "response": 0x44},
    "PeMDvjps": {"request": 0x49, "response": 0x24},
    "qX5kSDt2": {"request": 0x54, "response": 0x3A},
    "Cc4te9YB": {"request": 0x4E, "response": 0x0B},
}
HEX40_RE = re.compile(rb"\b[0-9a-f]{40}\b")


def decode_api_body(raw: bytes, key: int, *, header: int = 4) -> tuple[bytes, str]:
    """解 API 响应：``头(4B) + XOR(key)(正文)``，返回 ``(头, 正文文本)``。"""
    return raw[:header], bytes(b ^ key for b in raw[header:]).decode("utf-8", "replace")


def parse_asset_path(xml_text: str) -> str:
    """从 ``jWbtv5NR`` 响应里取 ``AssetPath``（版本目录）。"""
    index = xml_text.find("AssetPath")
    if index == -1:
        return ""
    hit = HEX40_RE.search(xml_text[index : index + 256].encode("utf-8", "replace"))
    return hit.group().decode("ascii") if hit else ""
