from __future__ import annotations

import json
import struct
from io import BytesIO
from pathlib import Path


def parse_language_bin(data: bytes) -> dict[int, str]:
    if len(data) < 4:
        raise ValueError("语言包过短")
    stream = BytesIO(data)
    count = struct.unpack(">i", stream.read(4))[0]
    if count < 0 or count > 1_000_000:
        raise ValueError(f"语言包条目数异常: {count}")
    entries: list[tuple[int, int]] = []
    for _ in range(count):
        rec = stream.read(6)
        if len(rec) < 6:
            raise ValueError("语言包索引表截断")
        sid, offset = struct.unpack(">Hi", rec)
        entries.append((sid, offset))
    result: dict[int, str] = {}
    for sid, offset in entries:
        if offset <= 0 or offset >= len(data):
            continue
        stream.seek(offset)
        length_bytes = stream.read(2)
        if len(length_bytes) < 2:
            continue
        length = struct.unpack(">H", length_bytes)[0]
        raw = stream.read(length)
        result[sid] = raw.decode("utf-8", errors="replace")
    return result


def looks_like_language(data: bytes, min_entries: int = 20) -> dict[int, str] | None:
    try:
        table = parse_language_bin(data)
    except ValueError:
        return None
    if len(table) < min_entries:
        return None
    return table


def dump_language_json(src: Path, dst: Path) -> int:
    table = parse_language_bin(src.read_bytes())
    dst.parent.mkdir(parents=True, exist_ok=True)
    payload = {str(k): v for k, v in sorted(table.items())}
    dst.write_text(json.dumps(payload, ensure_ascii=False, indent=2), encoding="utf-8")
    txt = dst.with_suffix(".txt")
    lines = [f"{k}\t{v.replace(chr(10), '\\n')}" for k, v in sorted(table.items())]
    txt.write_text("\n".join(lines), encoding="utf-8")
    return len(table)
