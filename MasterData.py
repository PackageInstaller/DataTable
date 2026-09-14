from __future__ import annotations

import hashlib
import json
import re
from dataclasses import dataclass
from pathlib import Path

import AlArchive
import AlCompress
import AlTable
from Config import MASTER_DIR

SAFE_RE = re.compile(r"[^\w\u4e00-\u9fff.\-]+")


@dataclass(slots=True)
class TableSource:
    rel: Path
    data: bytes
    container: str = ""
    payload: dict | None = None


def _table_json(data: bytes) -> dict | None:
    if b'"_fields"' not in data[:65536] or b'"records"' not in data[:65536]:
        return None
    try:
        payload = json.loads(data.decode("utf-8"))
    except (UnicodeDecodeError, json.JSONDecodeError):
        return None
    return payload if isinstance(payload, dict) else None


def iter_tables(roots: list[Path], *, max_depth: int = 4) -> list[TableSource]:
    found: list[TableSource] = []
    for root in roots:
        if not root.is_dir():
            continue
        for path in sorted(root.rglob("*")):
            if not path.is_file():
                continue
            try:
                data = path.read_bytes()
            except OSError:
                continue
            rel = path.relative_to(root)
            if path.suffix.lower() == ".json":
                payload = _table_json(data)
                if payload is not None:
                    found.append(TableSource(rel=rel, data=data, container="json", payload=payload))
                continue
            _collect(rel, data, found, depth=0, max_depth=max_depth)
    return found


def _collect(
    rel: Path, data: bytes, found: list[TableSource], *, depth: int, max_depth: int
) -> None:
    container = ""
    if data[:4] == b"ALL4":
        try:
            data = AlCompress.decode_all4(data)
            container = "ALL4"
        except Exception:  # noqa: BLE001
            return
    elif data[:4] == b"ALLZ":
        try:
            data = AlCompress.decode_allz(data)
            container = "ALLZ"
        except Exception:  # noqa: BLE001
            return
    if data[:4] in (b"ALTB", b"ALRD"):
        found.append(TableSource(rel=rel, data=data, container=container))
        return
    if depth >= max_depth or data[:4] != b"ALAR":
        return
    try:
        members = list(AlArchive.iter_members(data))
    except ValueError:
        return
    stem = rel.with_suffix("") if rel.suffix else rel
    for member, blob in members:
        _collect(stem / Path(member), blob, found, depth=depth + 1, max_depth=max_depth)


def _output_name(source: TableSource) -> str:
    """用文件名当表名；哈希名的就退回相对路径。"""
    stem = source.rel.stem
    if re.fullmatch(r"[0-9a-fA-F]{16,}", stem):
        name = "/".join(SAFE_RE.sub("_", part) for part in source.rel.parts)
        return re.sub(r"\.(atb|ard|bin|json)$", "", name, flags=re.IGNORECASE)
    return SAFE_RE.sub("_", stem)


def convert(
    roots: list[Path],
    *,
    out_dir: Path | None = None,
    verbose: bool = True,
) -> dict:
    out_dir = Path(out_dir) if out_dir else MASTER_DIR
    out_dir.mkdir(parents=True, exist_ok=True)

    index: dict[str, dict] = {}
    aliases: dict[str, list[str]] = {}
    written = 0
    skipped = 0
    for source in iter_tables([Path(r) for r in roots]):
        digest = hashlib.sha1(source.data).hexdigest()
        name = _output_name(source)
        target = out_dir / f"{name}.json"
        if digest in index:
            aliases.setdefault(index[digest]["path"], []).append(str(source.rel))
            skipped += 1
            continue
        try:
            if source.payload is not None:
                payload = source.payload
                records, fields = len(payload.get("records", [])), len(payload.get("_fields", []))
            elif source.data[:4] == b"ALTB":
                table = AlTable.parse_table(source.data)
                payload = AlTable.table_to_dict(source.data, table)
                records, fields = len(payload["records"]), len(payload["_fields"])
            else:
                schema, record_size, _ = AlTable.parse_schema(source.data, 0)
                payload = {
                    "_meta": {
                        "version": source.data[4],
                        "flags": f"0x{source.data[5]:02X}",
                        "record_size": record_size,
                    },
                    "_fields": [
                        {
                            "name": f.name,
                            "alias": f.alias,
                            "type": f.type_name,
                            "type_code": f.type_code,
                            "offset": f.offset,
                            "size": f.size,
                        }
                        for f in schema
                    ],
                }
                records, fields = 0, len(schema)
        except (ValueError, IndexError, KeyError) as exc:
            print(f"[masterdata] 跳过 {source.rel}: {exc}")
            continue

        target.write_text(
            json.dumps(payload, ensure_ascii=False, indent=2), encoding="utf-8"
        )
        rel_target = str(target.relative_to(out_dir)).replace("\\", "/")
        index[digest] = {
            "path": rel_target,
            "sha1": digest,
            "size": len(source.data),
            "container": source.container,
            "records": records,
            "fields": fields,
            "source": str(source.rel).replace("\\", "/"),
        }
        written += 1
        if verbose and written % 200 == 0:
            print(f"[masterdata] 已导出 {written} 张表…")

    for name, extra in aliases.items():
        if name in index:
            index[name]["aliases"] = sorted(set(extra))
    (out_dir / "_index.json").write_text(
        json.dumps(
            {"tables": written, "duplicates": skipped, "files": index},
            ensure_ascii=False,
            indent=2,
        ),
        encoding="utf-8",
    )
    print(f"[masterdata] 导出 {written} 张表（重复 {skipped} 份）-> {out_dir}")
    return {"tables": written, "duplicates": skipped}
