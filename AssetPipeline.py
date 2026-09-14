from __future__ import annotations

import json
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path
from typing import Any, Iterator

from PIL import Image
from rich.progress import (
    BarColumn,
    MofNCompleteColumn,
    Progress,
    SpinnerColumn,
    TextColumn,
    TimeElapsedColumn,
)

import AlFormat

Image.MAX_IMAGE_PIXELS = None

_CRYPTO_KEYS: list | None = None


def _crypto_keys() -> list:
    """运行时 AES 密钥（_cache/frida/aes.json + 内置常量），只读一次。"""
    global _CRYPTO_KEYS
    if _CRYPTO_KEYS is None:
        try:
            import AlCrypto

            _CRYPTO_KEYS = AlCrypto.known_keys()
        except Exception:  # noqa: BLE001
            _CRYPTO_KEYS = []
    return _CRYPTO_KEYS


def _replacement(base: Path, value: Any, ext: str) -> Path:
    if isinstance(value, Image.Image):
        return base.with_suffix(".png")
    if isinstance(value, tuple):
        return base.with_suffix(value[1])
    if ext:
        return base.with_suffix(ext)
    return base


def process_bytes(
    name: str,
    data: bytes,
    *,
    root: Path,
    rel: Path | None = None,
    depth: int = 0,
    manifest: list[dict] | None = None,
    stats: dict[str, int] | None = None,
) -> int:
    """把 ``data`` 递归还原到 ``root/rel``，返回写出的文件数。"""
    if depth > 12:
        return 0
    rel = rel or Path(name)

    # 不认识的格式：先试运行时 AES 密钥，再原样落盘
    if not AlFormat.detect(data):
        keys = _crypto_keys()
        if keys and len(data) >= 64 and len(data) % 16 == 0:
            try:
                import AlCrypto

                hit = AlCrypto.try_decrypt(data, keys=keys)
            except Exception:  # noqa: BLE001
                hit = None
            if hit is not None:
                if stats is not None:
                    stats[f"AES-{hit.mode.upper()}"] = stats.get(
                        f"AES-{hit.mode.upper()}", 0
                    ) + 1
                if manifest is not None:
                    manifest.append(
                        {
                            "path": str(root / rel),
                            "source": str(rel).replace("\\", "/"),
                            "note": f"AES-{hit.mode.upper()} key={hit.key.hex} ({hit.note})",
                            "size": len(data),
                        }
                    )
                return process_bytes(
                    name,
                    hit.data,
                    root=root,
                    rel=rel,
                    depth=depth + 1,
                    manifest=manifest,
                    stats=stats,
                )
        target = root / rel
        target.parent.mkdir(parents=True, exist_ok=True)
        target.write_bytes(data)
        _record(manifest, target, rel, "raw")
        if stats is not None:
            stats["raw"] = stats.get("raw", 0) + 1
        return 1

    result = AlFormat.process(name, data)
    if stats is not None:
        key = (result.note.split(" ")[0] or "raw").replace("\x00", "")
        stats[key] = stats.get(key, 0) + 1

    # 单一产物
    if set(result.files) == {""}:
        value = result.files[""]
        if (
            isinstance(value, (bytes, bytearray))
            and not result.ext
            and bytes(value) != data
        ):
            # 解压 / 内嵌出来的新数据，继续按格式识别（ALL4 -> ALTB，ALFT -> ALIG…）
            return process_bytes(
                name,
                bytes(value),
                root=root,
                rel=rel,
                depth=depth + 1,
                manifest=manifest,
                stats=stats,
            )
        target = _replacement(root / rel, value, result.ext)
        target.parent.mkdir(parents=True, exist_ok=True)
        AlFormat.save(target, value)
        _record(manifest, target, rel, result.note)
        return 1

    # 多产物（归档 / 贴图集）：展开到子目录
    if len(result.files) > 1 or (result.files and "" not in result.files):
        written = 0
        archive_dir = rel.with_suffix("") if rel.suffix else rel
        for member, blob in result.files.items():
            member_rel = archive_dir / Path(member)
            if isinstance(blob, (bytes, bytearray)):
                # 归档内若还有归档/压缩，继续拆
                written += process_bytes(
                    member,
                    bytes(blob),
                    root=root,
                    rel=member_rel,
                    depth=depth + 1,
                    manifest=manifest,
                    stats=stats,
                )
            else:
                target = _replacement(root / member_rel, blob, "")
                target.parent.mkdir(parents=True, exist_ok=True)
                AlFormat.save(target, blob)
                _record(manifest, target, member_rel, result.note)
                written += 1
        return written

    target = root / rel
    target.parent.mkdir(parents=True, exist_ok=True)
    target.write_bytes(data)
    _record(manifest, target, rel, "raw")
    return 1


def _record(manifest: list[dict] | None, target: Path, rel: Path, note: str) -> None:
    if manifest is None:
        return
    manifest.append(
        {
            "path": str(target),
            "source": str(rel).replace("\\", "/"),
            "note": note,
            "size": target.stat().st_size if target.exists() else 0,
        }
    )


def process_tree(
    source_dir: Path,
    dest_dir: Path,
    *,
    pattern: str = "*",
    jobs: int = 8,
    manifest_name: str = "_manifest.json",
    verbose: bool = False,
) -> dict:
    """批量处理目录（多线程，IO 与解析重叠）。"""
    dest_dir.mkdir(parents=True, exist_ok=True)
    files = [p for p in source_dir.rglob(pattern) if p.is_file()]
    manifest: list[dict] = []
    stats: dict[str, int] = {}

    def work(path: Path) -> tuple[int, str]:
        rel = path.relative_to(source_dir)
        data = path.read_bytes()
        lock_manifest: list[dict] = []
        lock_stats: dict[str, int] = {}
        count = process_bytes(
            str(rel),
            data,
            root=dest_dir,
            rel=rel,
            manifest=lock_manifest,
            stats=lock_stats,
        )
        return count, json.dumps(
            {"manifest": lock_manifest, "stats": lock_stats}, ensure_ascii=False
        )

    written = 0
    with Progress(
        SpinnerColumn(),
        TextColumn("[bold blue]{task.description}"),
        BarColumn(),
        MofNCompleteColumn(),
        TimeElapsedColumn(),
    ) as progress:
        task = progress.add_task(f"提取 {source_dir.name}", total=len(files) or 1)

        def consume(path: Path, count: int, payload: str) -> None:
            nonlocal written
            data = json.loads(payload)
            manifest.extend(data["manifest"])
            for key, value in data["stats"].items():
                stats[key] = stats.get(key, 0) + value
            written += count
            progress.update(task, description=f"提取 {path.name}"[:60], advance=1)
            if verbose:
                print(f"  {path.name} -> {count}")

        if jobs <= 1:
            for path in files:
                consume(path, *work(path))
        else:
            with ThreadPoolExecutor(max_workers=jobs) as pool:
                for path, (count, payload) in zip(files, pool.map(work, files)):
                    consume(path, count, payload)

    (dest_dir / manifest_name).write_text(
        json.dumps(
            {"files": written, "sources": len(files), "stats": stats, "entries": manifest},
            ensure_ascii=False,
            indent=2,
        ),
        encoding="utf-8",
    )
    return {"files": written, "sources": len(files), "stats": stats}


def iter_tables(root: Path) -> Iterator[tuple[Path, bytes]]:
    """遍历目录里所有 ALTB 表（含被 ALL4 包裹的）。"""
    for path in sorted(root.rglob("*")):
        if not path.is_file():
            continue
        try:
            data = path.read_bytes()
        except OSError:
            continue
        if data[:4] == b"ALTB":
            yield path, data
        elif data[:4] == b"ALL4":
            try:
                import AlCompress

                inner = AlCompress.decode_all4(data)
            except Exception:  # noqa: BLE001
                continue
            if inner[:4] == b"ALTB":
                yield path, inner
