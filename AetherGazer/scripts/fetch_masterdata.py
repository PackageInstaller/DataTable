from __future__ import annotations

import argparse
import sys
import tempfile
import urllib.request
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(ROOT / "masterdata"))

from extract_config import extract_config_bin  # noqa: E402
from config_parser import load_schema, parse_config, write_masterdata  # noqa: E402

DEFAULT_API = (
    "https://open.ys4fun.com/game-website-server/pass/sdk/"
    "get_game_hot_update_version?gameId=1"
)


def fetch_hot_info(api: str):
    import json

    with urllib.request.urlopen(api, timeout=30) as resp:
        data = json.loads(resp.read().decode("utf-8"))
    info = data.get("data") or {}
    return info


def download(ys: Path, api: str) -> None:
    print("[*] 获取热更新版本信息 ...")
    info = fetch_hot_info(api)
    bases = [b for b in info.get("downloadUrl", "").split(";") if b]
    assethash = info.get("assethash")
    if not bases or not assethash:
        raise RuntimeError("热更新接口未返回 downloadUrl/assethash")
    # 下载清单找 config.ys 的哈希
    manifest = None
    for base in bases:
        try:
            with urllib.request.urlopen(
                base.rstrip("/") + "/" + assethash, timeout=60
            ) as resp:
                manifest = resp.read()
            break
        except Exception:
            continue
    if manifest is None:
        raise RuntimeError("无法下载资源清单")
    import json

    entry = None
    for line in json.loads(manifest.decode("utf-8")).get("assetHashList", []):
        p, md5, size = line.split("|")[:3]
        if p == "config.ys":
            entry = (md5, int(size))
            break
    if entry is None:
        raise RuntimeError("清单中未找到 config.ys")
    md5, size = entry
    url = bases[0].rstrip("/") + "/" + md5 + ".ys"
    print(f"[*] 下载 {url} ({size} bytes) ...")
    req = urllib.request.Request(
        url, headers={"User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64)"}
    )
    with urllib.request.urlopen(req, timeout=120) as resp:
        ys.write_bytes(resp.read())
    print(f"[*] 已保存 -> {ys}")


def main() -> int:
    ap = argparse.ArgumentParser(description="获取并反序列化深空之眼数据表")
    ap.add_argument("--ys", default=None, help="本地 config.ys（不存在则自动下载）")
    ap.add_argument("--api", default=DEFAULT_API, help="热更新版本接口")
    ap.add_argument("--out", default=".", help="输出根目录（MasterData 在其下）")
    ap.add_argument("--keep-ys", action="store_true", help="保留下载的 config.ys")
    ap.add_argument("--compact", action="store_true", help="紧凑 JSON 输出")
    args = ap.parse_args()

    out = Path(args.out)
    tmp: Path | None = None
    ys: Path
    if args.ys:
        ys = Path(args.ys)
        if not ys.exists():
            print(f"[!] {ys} 不存在", file=sys.stderr)
            return 2
    else:
        tmp = Path(tempfile.mkdtemp(prefix="ag_masterdata_"))
        ys = tmp / "config.ys"
        try:
            download(ys, args.api)
        except Exception as exc:  # noqa: BLE001
            print(f"[!] 下载失败: {exc}", file=sys.stderr)
            return 1

    print(f"[*] 提取 Config TextAsset ...")
    cfg = extract_config_bin(ys)
    schema = load_schema(
        Path(__file__).resolve().parent.parent / "masterdata" / "config_schema.json"
    )
    tables = parse_config(cfg, schema)
    md_dir = out / "MasterData"
    write_masterdata(tables, md_dir, args.compact)
    raw_rows = sum(1 for t in tables for r in t["rows"] if "__raw__" in r["data"])
    unknown_fields = sum(
        len(r["data"].get("__unknown__", []))
        for t in tables
        for r in t["rows"]
        if "__unknown__" in r["data"]
    )
    print(f"[*] 表数: {len(tables)}，总行数: {sum(t['rowCount'] for t in tables)}")
    print(f"[*] 未解码行: {raw_rows}，未知字段: {unknown_fields}")
    print(f"[*] 已写出 -> {md_dir.resolve()}")
    if tmp is not None:
        if args.keep_ys:
            (out / "config.ys").write_bytes(ys.read_bytes())
        import shutil

        shutil.rmtree(tmp, ignore_errors=True)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
