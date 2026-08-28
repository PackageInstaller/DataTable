from __future__ import annotations

import json
import re
from pathlib import Path

from AMF3 import AMF3Decoder, amf3_to_jsonable
from CompressUtil import lzma_decompress, verify_hulist, zlib_decompress
from Config import CACHE_DIR, INDEX_URL, MASTER_DIR, resolve_assets
from HttpUtil import http_download, http_get


def parse_game_setting(assets: Path) -> dict[str, str]:
    path = assets / "config" / "gameSetting.txt"
    if not path.exists():
        path = Path(__file__).resolve().parent / "assets" / "config" / "gameSetting.txt"
    result = {"platform": "oc", "channelId": "taptap"}
    if not path.exists():
        return result
    for line in path.read_text(encoding="utf-8", errors="replace").splitlines():
        line = line.strip()
        if not line or line.startswith("//"):
            continue
        if "=" not in line:
            continue
        key, value = line.split("=", 1)
        result[key.strip()] = value.strip().strip('"')
    return result


def parse_client_version(assets: Path) -> str:
    xml = assets / "META-INF" / "AIR" / "application.xml"
    if not xml.exists():
        xml = Path(__file__).resolve().parent / "assets" / "META-INF" / "AIR" / "application.xml"
    if xml.exists():
        m = re.search(r"<versionNumber>\s*([^<]+)\s*</versionNumber>", xml.read_text(encoding="utf-8", errors="replace"))
        if m:
            return m.group(1).strip()
    return "2.50.0"


def parse_index(text: str) -> list[dict[str, str]]:
    rows = []
    for raw in text.splitlines():
        line = raw.strip()
        if not line or line.startswith("//"):
            continue
        line = line.replace("，", ",").replace("：", ":")
        parts = [p.strip() for p in re.split(r"\s*,\s*", line)]
        if len(parts) < 5:
            continue
        rows.append(
            {
                "platform": parts[0],
                "channel": parts[1],
                "client_version": parts[2],
                "server": parts[3],
                "static": parts[4],
            }
        )
    return rows


def match_index(rows: list[dict[str, str]], platform: str, channel: str, version: str) -> dict[str, str]:
    for row in rows:
        if row["platform"] not in (platform, "*"):
            continue
        if row["channel"] not in (channel, "*"):
            continue
        if row["client_version"] not in (version, "*"):
            continue
        if row["server"].startswith("过期"):
            raise RuntimeError(f"客户端版本已过期: {row['server']} {row['static']}")
        return row
    raise RuntimeError(f"index.txt 无匹配: {platform}/{channel}/{version}")


def normalize_url(url: str) -> str:
    url = url.strip().rstrip("/")
    if url.startswith("http://") or url.startswith("https://"):
        return url
    return "http://" + url


def fetch_index() -> str:
    return http_get(INDEX_URL + f"?r=1").decode("utf-8", errors="replace")


def fetch_info(server: str, platform: str, client_version: str, channel: str, asset_version: str) -> dict:
    base = normalize_url(server)
    url = (
        f"{base}/info/?platform={platform}"
        f"&client_version={client_version}"
        f"&asset_version={asset_version}"
        f"&channel={channel}"
    )
    text = http_get(url).decode("utf-8", errors="replace")
    return json.loads(text)


def parse_hulist(data: bytes) -> tuple[str, list[dict], dict | None]:
    if not verify_hulist(data):
        print("[hu] 警告: huList.bin 校验和不匹配，继续解析")
    version = f"{int.from_bytes(data[2:4], 'big')}.{int.from_bytes(data[4:6], 'big')}.{int.from_bytes(data[6:8], 'big')}"
    dec = AMF3Decoder(data[8:])
    files = dec.read_element()
    entire = None
    try:
        entire = dec.read_element()
    except Exception:
        entire = None
    if not isinstance(files, list):
        raise ValueError("huList.bin 不是文件数组")
    return version, files, entire if isinstance(entire, dict) else None


def compress_kind(value) -> str:
    text = "" if value is None else str(value).lower()
    if "lzma" in text:
        return "lzma"
    if text in ("zip", "zlib"):
        return "zlib"
    if text in ("og", "none", "", "null"):
        return "og"
    return text


def unpack_entire(blob: bytes, files: list[dict], dest: Path) -> int:
    print(f"[hu] LZMA 解压 entire.bin ({len(blob)} 字节)...")
    data = lzma_decompress(blob)
    print(f"[hu] 解压后 {len(data)} 字节，切分 {len(files)} 个文件")
    offset = 0
    written = 0
    for item in files:
        size = int(item.get("size") or 0)
        remote = str(item.get("remote") or item.get("huid") or f"file_{written}")
        chunk = data[offset : offset + size]
        if len(chunk) != size:
            raise ValueError(f"entire.bin 在 {remote} 处截断 ({len(chunk)}/{size})")
        out = dest / remote
        out.parent.mkdir(parents=True, exist_ok=True)
        if not (out.exists() and out.stat().st_size == size):
            out.write_bytes(chunk)
        offset += size
        written += 1
    if offset != len(data):
        print(f"[hu] 警告: entire.bin 剩余 {len(data) - offset} 字节未切分")
    return written


def download_single_hu(cdn: str, ver_path: str, item: dict, dest: Path) -> Path:
    remote = str(item["remote"])
    url = f"{cdn}/{ver_path}/{remote}"
    out = dest / remote
    kind = compress_kind(item.get("compress"))
    expected = int(item.get("compressSize") or 0) if kind != "og" else int(item.get("size") or 0)
    if out.exists() and out.stat().st_size == int(item.get("size") or 0):
        return out
    raw_path = CACHE_DIR / "hu_raw" / remote
    http_download(url, raw_path)
    data = raw_path.read_bytes()
    if kind == "lzma":
        data = lzma_decompress(data)
    elif kind == "zlib":
        data = zlib_decompress(data)
    out.parent.mkdir(parents=True, exist_ok=True)
    out.write_bytes(data)
    return out


def unpack_asset_pack(pack_path: Path, files: list[dict], dest: Path) -> int:
    data = pack_path.read_bytes()
    offset = 0
    written = 0
    for item in files:
        size = int(item.get("size") or 0)
        chunk = data[offset : offset + size]
        if len(chunk) != size:
            raise ValueError(f"资源包 {pack_path.name} 在 {item.get('path')} 截断")
        if item.get("compress"):
            chunk = lzma_decompress(chunk)
        rel = str(item.get("path") or item.get("name"))
        out = dest / "asset_apk" / rel
        out.parent.mkdir(parents=True, exist_ok=True)
        if not (out.exists() and out.stat().st_size == len(chunk)):
            out.write_bytes(chunk)
        offset += size
        written += 1
        if offset >= len(data):
            break
    return written


def update_hotupdate(dest: Path | None = None, full: bool = False) -> dict:
    dest = dest or resolve_assets()
    dest.mkdir(parents=True, exist_ok=True)
    CACHE_DIR.mkdir(parents=True, exist_ok=True)
    MASTER_DIR.mkdir(parents=True, exist_ok=True)

    setting = parse_game_setting(dest)
    platform = setting.get("platform", "oc")
    channel = setting.get("channelId", "taptap")
    client_version = parse_client_version(dest)
    print(f"[hu] 客户端 {platform}/{channel}/{client_version}")

    index_text = fetch_index()
    (CACHE_DIR / "index.txt").write_text(index_text, encoding="utf-8")
    row = match_index(parse_index(index_text), platform, channel, client_version)
    server = row["server"]
    cdn = normalize_url(row["static"])
    print(f"[hu] 服务器 {server}")
    print(f"[hu] CDN {cdn}")

    info = fetch_info(server, platform, client_version, channel, client_version)
    (MASTER_DIR / "info.json").write_text(
        json.dumps(info, ensure_ascii=False, indent=2), encoding="utf-8"
    )
    if info.get("static_url"):
        cdn = normalize_url(str(info["static_url"]))
    asset_version = str(info.get("asset_version") or client_version)
    ver_path = asset_version.replace(".", "_")
    print(f"[hu] 热更版本 {asset_version} -> {ver_path}")

    hu_url = f"{cdn}/{ver_path}/huList.bin"
    hu_path = CACHE_DIR / "huList.bin"
    print(f"[hu] 下载 {hu_url}")
    http_download(hu_url, hu_path)
    version, files, entire_meta = parse_hulist(hu_path.read_bytes())
    (MASTER_DIR / "huList.json").write_text(
        json.dumps(
            {"version": version, "entire": amf3_to_jsonable(entire_meta), "files": amf3_to_jsonable(files)},
            ensure_ascii=False,
            indent=2,
        ),
        encoding="utf-8",
    )
    print(f"[hu] HUList {version}，{len(files)} 个文件")

    if entire_meta and entire_meta.get("huid") == "ENTIRE":
        entire_url = f"{cdn}/{ver_path}/entire/entire.bin"
        entire_path = CACHE_DIR / "entire.bin"
        print(f"[hu] 下载 {entire_url} ({entire_meta.get('compressSize')} 字节)")
        http_download(entire_url, entire_path, timeout=300, expected_size=int(entire_meta.get("compressSize") or 0) or None)
        unpack_entire(entire_path.read_bytes(), files, dest)
    else:
        print("[hu] 无 ENTIRE 包，逐文件下载")
        for item in files:
            download_single_hu(cdn, ver_path, item, dest)
            print(f"  {item.get('remote')}")

    result = {
        "cdn": cdn,
        "asset_version": asset_version,
        "hu_files": len(files),
        "full": False,
    }

    if full:
        result["full"] = download_full_assets(cdn, dest)
    return result


def download_full_assets(cdn: str, dest: Path) -> dict:
    """下载可选的 asset_apk 大资源（图片/语音等）。"""
    desc_url = f"{cdn}/asset_apk/gp/desc"
    desc_path = CACHE_DIR / "asset_apk_gp_desc"
    print(f"[apk-asset] 下载目录 {desc_url}")
    try:
        http_download(desc_url, desc_path)
    except Exception as exc:
        print(f"[apk-asset] gp/desc 失败 ({exc})，尝试 image/desc + cv/desc")
        return download_named_descs(cdn, dest, ["image", "cv"])

    data = lzma_decompress(desc_path.read_bytes())
    obj = AMF3Decoder(data).read_element()
    if not isinstance(obj, (list, tuple)) or len(obj) < 2:
        raise ValueError("asset_apk desc 格式异常")
    file_list, archives = obj[0], obj[1]
    (MASTER_DIR / "asset_apk_desc.json").write_text(
        json.dumps(amf3_to_jsonable(obj), ensure_ascii=False),
        encoding="utf-8",
    )
    print(f"[apk-asset] {len(file_list)} 个文件，{len(archives)} 个分包")
    apk_dest = dest
    downloaded = 0
    cursor = 0
    for archive in archives:
        name = archive[0]
        total = int(archive[1])
        pack_path = CACHE_DIR / "asset_apk" / name
        url = f"{cdn}/asset_apk/gp/{name}"
        print(f"[apk-asset] {name} ({total} 字节)")
        http_download(url, pack_path, timeout=600)
        slice_files = []
        acc = 0
        while cursor < len(file_list) and acc < total:
            item = file_list[cursor]
            slice_files.append(item)
            acc += int(item.get("size") or 0)
            cursor += 1
        unpack_asset_pack(pack_path, slice_files, apk_dest)
        downloaded += 1
    return {"archives": downloaded, "files": len(file_list)}


def download_named_descs(cdn: str, dest: Path, names: list[str]) -> dict:
    total_files = 0
    for name in names:
        url = f"{cdn}/asset_apk/{name}/desc"
        path = CACHE_DIR / f"asset_apk_{name}_desc"
        try:
            http_download(url, path)
        except Exception as exc:
            print(f"[apk-asset] {name}/desc 失败: {exc}")
            continue
        data = lzma_decompress(path.read_bytes())
        obj = AMF3Decoder(data).read_element()
        print(f"[apk-asset] {name} desc 解析为 {type(obj).__name__}")
        (MASTER_DIR / f"asset_apk_{name}_desc.json").write_text(
            json.dumps(amf3_to_jsonable(obj), ensure_ascii=False),
            encoding="utf-8",
        )
        if isinstance(obj, list) and obj and isinstance(obj[0], list):
            total_files += len(obj[0])
    return {"archives": len(names), "files": total_files}
