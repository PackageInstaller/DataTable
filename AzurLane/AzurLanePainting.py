#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
碧蓝航线立绘还原工具

流程:
    Assets/painting/*_tex (Unity AssetBundle)
      -> UnityPy 读取 Texture2D / Mesh / Sprite
      -> 有 Mesh 时按三角形 UV 切割拼回 (内存中完成)
      -> 无 Mesh 时按 Sprite 矩形裁剪
      -> 按 ship_skin_template / ship_data_statistics 数据表重命名

重命名:
    Painting/<船名>/碧蓝航线_<船名>.png                   原始立绘
    Painting/<船名>/碧蓝航线_<船名>_<皮肤名>.png           皮肤立绘
    变体后缀 (_rw / _n / _hx / _n_rw ...) 追加在文件名末尾
    主立绘优先取 _rw (全身人物立绘); 无 _rw 时取无后缀;
    无 Mesh 的半身图保存为 _半身 后缀
    只有 Mesh 的变体包自动配对同名基础贴图还原
    {namecode:N} 占位符按 name_code 表解析为中文名

映射数据来源 (全部本地):
    Lua/.../sharecfg/painting_filte_map.lua       立绘 key -> 资源组
    Assets/sharecfgdata/ship_skin_template        皮肤表 (流式字节码)
    Assets/sharecfgdata/ship_data_statistics      舰船名表 (流式字节码)
    Lua/.../sharecfg/ship_skin_template.lua       皮肤表偏移索引
    Lua/.../sharecfg/ship_data_statistics.lua     舰船名表偏移索引

依赖:
    UnityPy, Pillow, AzurLane2Std, luajit-decompiler (PATH)
"""

import hashlib
import json
import os
import re
import shutil
import struct
import subprocess
import sys
import tempfile
from concurrent.futures import ThreadPoolExecutor, as_completed

import UnityPy

from AzurLane2Std import convert

try:
    from PIL import Image
except ImportError:
    print("需要 Pillow: pip install Pillow")
    sys.exit(1)

try:
    from rich.console import Console
    from rich.progress import (
        BarColumn,
        Progress,
        TextColumn,
        TimeRemainingColumn,
        TransferSpeedColumn,
    )
except ImportError:
    print("需要 rich: pip install rich")
    sys.exit(1)


UNITY_FALLBACK = "2022.3.62f3"
HEADER64 = b"\x1bLJ\x02\x0a"
FOOTER = bytes(
    [24, 3, 0, 3, 0, 0, 1, 4, 75, 255, 0, 0, 44, 254, 0, 1, 37, 254, 1, 3, 50, 255, 1, 3, 0, 0]
)
CACHE_FILE = "painting_skin_map.json"
STATE_VERSION = 4
PAINTING_OUT = "Painting"

console = Console()


# --------------------------------------------------------------------------
# 路径定位
# --------------------------------------------------------------------------


def _find_lua(out_root, name):
    """优先 arm64, 其次 normal。"""
    for arch in ("arm64", "normal"):
        p = os.path.join(
            out_root,
            "Lua",
            "assets",
            "luabuilds",
            "android",
            arch,
            "sharecfg",
            name,
        )
        if os.path.isfile(p):
            return p
    return None


def _find_bin(out_root, name):
    p = os.path.join(out_root, "Assets", "sharecfgdata", name)
    return p if os.path.isfile(p) else None


# --------------------------------------------------------------------------
# Lua 索引 / 分组解析
# --------------------------------------------------------------------------


def parse_painting_groups(lua_path):
    """painting_filte_map.lua -> {key: [res,...]}。"""
    src = open(lua_path, encoding="utf-8").read()
    pat = re.compile(
        r'(?:\.([a-zA-Z0-9_]+)|\["([^"]+)"\]) = \{\s*key = "([^"]+)",\s*res_list = \{(.*?)\s*\}\s*\}',
        re.S,
    )
    groups = {}
    for m in pat.finditer(src):
        key = m.group(3)
        res = re.findall(r'"painting/([^"]+)"', m.group(4))
        groups[key] = res
    return groups


def parse_stream_index(lua_path, table_var="var_0"):
    """取表尾的 {id: (offset, length)} 索引。"""
    src = open(lua_path, encoding="utf-8").read()
    starts = [m.start() for m in re.finditer(rf"^\s*{table_var}\.\w+ = \{{", src, re.M)]
    if not starts:
        return {}
    seg = src[max(starts):]
    return {
        int(i): (int(o), int(l))
        for i, o, l in re.findall(r"\[(\d+)\] = \{\s*(\d+),\s*(\d+)\s*\}", seg)
    }


def _read_uleb(data, pos):
    v = 0
    sh = 0
    n = 0
    while True:
        c = data[pos]
        pos += 1
        n += 1
        v |= (c & 0x7F) << sh
        if c < 0x80:
            return v, n
        sh += 7


def _stream_record_id(rec):
    """解析一条流式记录主原型的第一个整数常量 (即该条目的 id)。"""
    pos = [0]

    def rd():
        r = 0
        sh = 0
        while True:
            c = rec[pos[0]]
            pos[0] += 1
            r |= (c & 0x7F) << sh
            if c < 0x80:
                return r
            sh += 7

    rd()  # 原型长度
    f0, f1, f2, f3 = rec[pos[0]:pos[0] + 4]
    pos[0] += 4
    nkn = rd()
    nkgc = rd()
    nbc = rd() + 1
    pos[0] += (nbc - 1) * 4  # 指令区
    nuv = f3 ^ f2 ^ (f1 ^ f0)
    pos[0] += nuv * 2

    for _ in range(nkn):
        b = rec[pos[0]]
        pos[0] += 1
        v = b >> 1
        if v >= 0x40:
            v &= 0x3F
            sh = -1
            while True:
                c = rec[pos[0]]
                pos[0] += 1
                sh += 7
                v |= (c & 0x7F) << sh
                if c < 0x80:
                    break
        if b & 1:  # number 常量, 取 low 32
            sh = 0
            while True:
                c = rec[pos[0]]
                pos[0] += 1
                if c < 0x80:
                    break
                sh += 7
        return v
    return None


def _build_stream_index(bin_path):
    """直接从 sharecfgdata 二进制扫描重建 {id: (offset, length)}。

    二进制是按记录顺序连续存放的流: 每条记录以 uleb(原型长度) 开头,
    记录字节码主原型的第一个整数常量就是该条目的 id。
    """
    data = open(bin_path, "rb").read()
    idx = {}
    off = 0
    while off < len(data):
        v, nb = _read_uleb(data, off)
        ln = v + nb
        if off + ln > len(data):
            break
        sid = _stream_record_id(data[off:off + ln])
        if sid is None:
            return {}
        idx[sid] = (off, ln)
        off += ln
    return idx


COMMUNITY_BASE = "https://raw.githubusercontent.com/AzurLaneTools/AzurLaneLuaScripts/main/CN/sharecfg"


def _ensure_community_index(out_root, name):
    """下载并缓存社区完整索引 (sharecfg/<name>)。"""
    dst_dir = os.path.join(out_root, PAINTING_OUT, "community")
    os.makedirs(dst_dir, exist_ok=True)
    dst = os.path.join(dst_dir, name)
    if os.path.isfile(dst):
        return dst
    url = f"{COMMUNITY_BASE}/{name}"
    console.print(f"[cyan]下载社区完整索引: {name}[/cyan]")
    tmp = dst + ".tmp"
    try:
        import urllib.request

        urllib.request.urlretrieve(url, tmp)
        os.replace(tmp, dst)
    except Exception as e:
        try:
            os.remove(tmp)
        except OSError:
            pass
        raise RuntimeError(f"社区索引下载失败 {name}: {e}")
    return dst


def _parse_name_code(out_root):
    """name_code.lua -> {id: 中文名}。"""
    p = _find_lua(out_root, "name_code.lua")
    if not p:
        return {}
    src = open(p, encoding="utf-8").read()
    result = {}
    for m in re.finditer(r"\[(\d+)\] = \{(.*?)\n\s*\}", src, re.S):
        body = m.group(2)
        nm = re.search(r'name = "([^"]*)"', body)
        cd = re.search(r'code = "([^"]*)"', body)
        if nm:
            result[int(m.group(1))] = nm.group(1) or (cd.group(1) if cd else "")
    return result


def _resolve_namecodes(text, name_map):
    if not text or "{namecode:" not in text:
        return text

    def rep(m):
        return name_map.get(int(m.group(1)), m.group(0))

    return re.sub(r"\{namecode:(\d+)\}", rep, text)


# --------------------------------------------------------------------------
# 流式字节码记录 -> 字段
# --------------------------------------------------------------------------


def _decompile_record(rec, dec, work_dir, tag):
    """记录 -> (转换+反编译) -> 源码文本。失败返回 None。"""
    try:
        std = convert(HEADER64 + rec + FOOTER)
    except Exception:
        return None
    p = os.path.join(work_dir, f"{tag}.luac")
    with open(p, "wb") as f:
        f.write(std)
    r = subprocess.run(
        [dec, p, "-o", work_dir, "-f", "-s"],
        capture_output=True,
        text=True,
        timeout=15,
    )
    op = os.path.join(work_dir, f"{tag}.luac.lua")
    if not os.path.exists(op):
        return None
    with open(op, encoding="utf-8", errors="replace") as f:
        return f.read()


def _field(txt, name, cast=None):
    m = re.search(rf"^\s*{name} = \"([^\"]*)\"", txt, re.M)
    if m:
        return m.group(1)
    m = re.search(rf"^\s*{name} = (-?\d+)", txt, re.M)
    if m:
        v = int(m.group(1))
        return v
    return None


def _build_skin_map(out_root, jobs=8, cache_path=None):
    """从本地 sharecfgdata 构建 skin_by_painting 与 ship_names_by_group。"""
    skin_lua = _find_lua(out_root, "ship_skin_template.lua")
    stats_lua = _find_lua(out_root, "ship_data_statistics.lua")
    pfm_lua = _find_lua(out_root, "painting_filte_map.lua")
    nc_lua = _find_lua(out_root, "name_code.lua")
    skin_bin = _find_bin(out_root, "ship_skin_template")
    stats_bin = _find_bin(out_root, "ship_data_statistics")
    missing = [
        p
        for p in (skin_lua, stats_lua, pfm_lua, skin_bin, stats_bin)
        if not p
    ]
    if missing:
        raise RuntimeError(f"缺少数据表: {missing}; 请先运行更新器下载 Assets 与 Lua")

    def md5(p):
        with open(p, "rb") as f:
            return hashlib.md5(f.read()).hexdigest()

    # 二进制是按记录顺序连续存放的流, 可直接扫描重建完整索引;
    # 本地 Lua 索引可能不完整 (ship_skin_template 只有 2130 条, 二进制 2827 条)
    skin_idx = _build_stream_index(skin_bin)
    stats_idx = _build_stream_index(stats_bin)
    skin_lua_used = skin_lua if len(skin_idx) < 2500 else None
    stats_lua_used = stats_lua if len(stats_idx) < 3500 else None
    skin_idx_mode = "stream" if len(skin_idx) >= 2500 else "lua"
    stats_idx_mode = "stream" if len(stats_idx) >= 3500 else "lua"
    if len(skin_idx) < 2500:
        skin_idx = parse_stream_index(skin_lua)
        console.print(
            "[yellow]二进制流扫描未得到完整索引, 退回 Lua 索引[/yellow]"
        )
        try:
            ci = _ensure_community_index(out_root, "ship_skin_template.lua")
            cidx = parse_stream_index(ci, table_var="cs")
            if len(cidx) > len(skin_idx):
                skin_lua_used = ci
                skin_idx = cidx
                skin_idx_mode = "community"
                console.print(
                    "[cyan]使用社区完整索引: ship_skin_template[/cyan]"
                )
        except Exception as e:
            console.print(f"[yellow]ship_skin_template 社区索引不可用: {e}[/yellow]")
    if len(stats_idx) < 3500:
        stats_idx = parse_stream_index(stats_lua)
        console.print(
            "[yellow]二进制流扫描未得到完整索引, 退回 Lua 索引[/yellow]"
        )
        try:
            ci = _ensure_community_index(out_root, "ship_data_statistics.lua")
            cidx = parse_stream_index(ci, table_var="cs")
            if len(cidx) > len(stats_idx):
                stats_lua_used = ci
                stats_idx = cidx
                stats_idx_mode = "community"
                console.print(
                    "[cyan]使用社区完整索引: ship_data_statistics[/cyan]"
                )
        except Exception as e:
            console.print(f"[yellow]ship_data_statistics 社区索引不可用: {e}[/yellow]")

    src = {
        "skin_lua": md5(skin_lua_used) if skin_lua_used else None,
        "stats_lua": md5(stats_lua_used) if stats_lua_used else None,
        "pfm_lua": md5(pfm_lua),
        "nc_lua": md5(nc_lua) if nc_lua else None,
        "skin_bin": md5(skin_bin),
        "stats_bin": md5(stats_bin),
        "skin_idx_mode": skin_idx_mode,
        "stats_idx_mode": stats_idx_mode,
    }
    name_map = _parse_name_code(out_root)

    cache_path = cache_path or os.path.join(out_root, PAINTING_OUT, CACHE_FILE)
    if os.path.isfile(cache_path):
        try:
            cache = json.load(open(cache_path, encoding="utf-8"))
            if cache.get("version") == STATE_VERSION and cache.get("source") == src:
                return (
                    cache["skins"],
                    cache["ship_names"],
                    cache.get("name_map", name_map),
                )
        except Exception:
            pass

    dec = shutil.which("luajit-decompiler")
    if not dec:
        raise RuntimeError("未找到 luajit-decompiler 命令, 请通过 AUR 包安装")

    work = tempfile.mkdtemp(prefix="azl_paint_map_")

    def process(index, bin_path, tag, fields):
        data = open(bin_path, "rb").read()
        out = {}

        def one(item):
            sid, (off, ln) = item
            rec = data[off:off + ln]
            txt = _decompile_record(rec, dec, work, f"{tag}{sid}")
            if not txt:
                return sid, None
            row = {}
            for name, cast in fields.items():
                v = _field(txt, name)
                if v is not None and cast:
                    v = cast(v)
                row[name] = v
            row["id"] = sid
            return sid, row

        with ThreadPoolExecutor(max_workers=jobs) as ex:
            for sid, row in ex.map(one, index.items()):
                if row:
                    out[sid] = row
        return out

    skins = process(
        skin_idx,
        skin_bin,
        "s",
        {
            "name": str,
            "painting": str,
            "ship_group": int,
            "group_index": int,
            "skin_type": int,
        },
    )
    stats = process(
        stats_idx,
        stats_bin,
        "d",
        {"name": str, "skin_id": int},
    )
    shutil.rmtree(work, ignore_errors=True)

    skin_by_painting = {}
    for v in skins.values():
        if v.get("painting"):
            v["name"] = _resolve_namecodes(v.get("name"), name_map)
            skin_by_painting.setdefault(v["painting"].lower(), v)

    # 舰船名: 优先 ship_data_statistics 的明文 name, 按 skin_id 关联
    name_by_skin_id = {}
    for v in stats.values():
        if v.get("skin_id") is not None and v.get("name"):
            name_by_skin_id.setdefault(v["skin_id"], v["name"])

    ship_names = {}
    for v in skins.values():
        g = v.get("ship_group")
        if g is None:
            continue
        name = name_by_skin_id.get(v["id"]) or v.get("name")
        name = _resolve_namecodes(name, name_map)
        if name:
            old = ship_names.get(str(g))
            if old is None or v.get("group_index", 0) < old[0]:
                ship_names[str(g)] = (v.get("group_index", 0), name)
    ship_names = {g: name for g, (_, name) in ship_names.items()}

    os.makedirs(os.path.dirname(cache_path), exist_ok=True)
    cache = {
        "version": STATE_VERSION,
        "source": src,
        "skins": skin_by_painting,
        "ship_names": ship_names,
        "name_map": name_map,
    }
    with open(cache_path, "w", encoding="utf-8") as f:
        json.dump(cache, f, ensure_ascii=False, indent=1)
    return skin_by_painting, ship_names, name_map


# --------------------------------------------------------------------------
# Mesh 还原
# --------------------------------------------------------------------------


def _chan(c, key):
    return c[key] if isinstance(c, dict) else getattr(c, key)


def _decode_vertices(vd):
    """通用顶点解码, 支持多 stream 布局 (Mesh / Sprite.m_RD 通用)。"""
    channels = list(_chan(vd, "m_Channels") or [])
    n = _chan(vd, "m_VertexCount")
    actives = [c for c in channels if _chan(c, "dimension")]
    for c in actives:
        if _chan(c, "format") != 0:  # 仅支持 Float32
            raise RuntimeError(f"不支持的顶点格式 {_chan(c, 'format')}")

    # 每个 stream 独立连续存储: stream 块按顺序拼接在 m_DataSize 里
    by_stream = {}
    for c in actives:
        by_stream.setdefault(_chan(c, "stream"), []).append(c)
    stream_base = {}
    base = 0
    for s in sorted(by_stream):
        stride = max(_chan(c, "offset") + _chan(c, "dimension") * 4 for c in by_stream[s])
        stream_base[s] = (base, stride)
        base += stride * n

    data = bytes(_chan(vd, "m_DataSize"))
    pos_idx = next(
        (i for i, c in enumerate(channels) if _chan(c, "dimension") >= 3), None
    )
    uv_idx = next(
        (i for i, c in enumerate(channels) if i == 4 and _chan(c, "dimension") >= 2),
        None,
    )
    if pos_idx is None:
        raise RuntimeError("顶点数据缺少位置通道")

    def read(i, c):
        sbase, stride = stream_base[_chan(c, "stream")]
        off = sbase + i * stride + _chan(c, "offset")
        dim = _chan(c, "dimension")
        return struct.unpack_from(f"<{dim}f", data, off)

    verts = []
    for i in range(n):
        x, y, z = read(i, channels[pos_idx])[:3]
        if uv_idx is not None:
            u, v = read(i, channels[uv_idx])[:2]
        else:
            u = v = 0.0
        verts.append((x, y, z, u, v))
    return verts


def _decode_mesh(mesh):
    verts = _decode_vertices(mesh.m_VertexData)
    buf = list(mesh.m_IndexBuffer)
    if mesh.m_IndexFormat == 0:  # UInt16
        idx = [buf[i] | (buf[i + 1] << 8) for i in range(0, len(buf) - 1, 2)]
    else:  # UInt32
        idx = [
            buf[i] | (buf[i + 1] << 8) | (buf[i + 2] << 16) | (buf[i + 3] << 24)
            for i in range(0, len(buf) - 3, 4)
        ]
    return verts, idx


def _decode_sprite_mesh(sprite):
    """Sprite 自带网格 (SpriteRenderData.m_VertexData / m_IndexBuffer)。"""
    tt = sprite.read_typetree()
    rd = tt.get("m_RD") or {}
    verts = _decode_vertices(rd["m_VertexData"])
    buf = list(rd.get("m_IndexBuffer") or [])
    idx = [buf[i] | (buf[i + 1] << 8) for i in range(0, len(buf) - 1, 2)]
    return verts, idx


def _sprite_internal_vertex_count(sprite):
    try:
        rd = (sprite.read_typetree() or {}).get("m_RD") or {}
        return (rd.get("m_VertexData") or {}).get("m_VertexCount") or 0
    except Exception:
        return 0


def _stitch(mesh, tex_img, canvas_size=None):
    verts, idx = _decode_mesh(mesh)
    w, h = tex_img.size
    # 与原版 image_deal.py 一致:
    # v 顶点取整作为绘制坐标, 画布 y 翻转; vt 按像素取整作为裁剪坐标
    draw_raw = [(int(round(x)), int(round(y))) for x, y, z, u, v in verts]
    uv = [(round(u * w), round((1.0 - v) * h)) for x, y, z, u, v in verts]
    if canvas_size:
        x_pic, y_pic = int(canvas_size[0]), int(canvas_size[1])
    else:
        x_pic = max(x for x, y in draw_raw)
        y_pic = max(y for x, y in draw_raw)
    pic = Image.new("RGBA", (x_pic, y_pic), (255, 255, 255, 0))
    for i in range(0, len(idx) - 2, 3):
        a, b, c = idx[i], idx[i + 1], idx[i + 2]
        pts = [
            (draw_raw[a][0], y_pic - draw_raw[a][1]),
            (draw_raw[b][0], y_pic - draw_raw[b][1]),
            (draw_raw[c][0], y_pic - draw_raw[c][1]),
        ]
        cuts = [uv[a], uv[b], uv[c]]
        pa = (
            min(p[0] for p in pts),
            min(p[1] for p in pts),
        )
        cx = min(p[0] for p in cuts)
        cy = min(p[1] for p in cuts)
        ex = max(p[0] for p in cuts)
        ey = max(p[1] for p in cuts)
        if ex <= cx or ey <= cy:
            continue
        crop = tex_img.crop((cx, cy, ex, ey))
        pic.paste(crop, pa)
    return pic


def _crop_sprite(tex_img, sprite):
    if sprite is None:
        return tex_img
    try:
        rect = sprite.read_typetree().get("m_Rect") or {}
        x = round(rect.get("x", 0))
        y = round(rect.get("y", 0))
        w = round(rect.get("width", tex_img.width))
        h = round(rect.get("height", tex_img.height))
        if (x, y, w, h) == (0, 0, tex_img.width, tex_img.height):
            return tex_img
        top = tex_img.height - y - h
        return tex_img.crop((x, top, x + w, top + h))
    except Exception:
        return tex_img


def _bust_uses_mesh(out_root, key):
    """半身节点是否引用外部 Mesh: 由 painting/<key> prefab 决定。

    部分皮肤的半身层是 MeshImage + 外部 Mesh (如 huangjiacaifu),
    部分是纯 Sprite (如 aierbin_3, mMesh=0)。
    """
    prefab = os.path.join(out_root, "Assets", "painting", key)
    if not os.path.isfile(prefab):
        return False
    try:
        UnityPy.config.FALLBACK_UNITY_VERSION = UNITY_FALLBACK
        env = UnityPy.load(prefab)
        name = {}
        for obj in env.objects:
            if obj.type.name == "GameObject":
                try:
                    name[obj.path_id] = obj.read().m_Name
                except Exception:
                    pass
        for obj in env.objects:
            if obj.type.name != "MonoBehaviour":
                continue
            tt = obj.read_typetree()
            go = tt.get("m_GameObject", {}).get("m_PathID")
            if (name.get(go) or "").lower() != key.lower():
                continue
            mesh = tt.get("mMesh") or {}
            if mesh.get("m_PathID") and mesh.get("m_FileID"):
                return True
    except Exception:
        pass
    return False


def _layer_raw_size(out_root, key):
    """prefab 中 key 层 MeshImage 的 mRawSpriteSize。"""
    prefab = os.path.join(out_root, "Assets", "painting", key)
    if not os.path.isfile(prefab):
        return None
    try:
        UnityPy.config.FALLBACK_UNITY_VERSION = UNITY_FALLBACK
        env = UnityPy.load(prefab)
        name = {}
        for obj in env.objects:
            if obj.type.name == "GameObject":
                try:
                    name[obj.path_id] = obj.read().m_Name
                except Exception:
                    pass
        for obj in env.objects:
            if obj.type.name != "MonoBehaviour":
                continue
            tt = obj.read_typetree()
            go = tt.get("m_GameObject", {}).get("m_PathID")
            if (name.get(go) or "").lower() != key.lower():
                continue
            raw = tt.get("mRawSpriteSize")
            if raw and raw.get("x") and raw.get("y"):
                return (raw["x"], raw["y"])
    except Exception:
        return None
    return None


def _parse_expression_defaults(out_root):
    """ship_skin_expression.lua -> {painting: 默认表情编号}。

    只取 `default` 槽位: 这是静态展示用的表情; main_1/home 等是
    事件表情, 不合成进静态立绘。
    """
    p = _find_lua(out_root, "ship_skin_expression.lua")
    if not p:
        return {}
    src = open(p, encoding="utf-8").read()
    pat = re.compile(
        r'(?:\.([a-zA-Z0-9_]+)|\["([^"]+)"\]) = \{(.*?)\n\s*\}',
        re.S,
    )
    result = {}
    for m in pat.finditer(src):
        body = m.group(3)
        painting = re.search(r'painting = "([^"]*)"', body)
        default = re.search(r'default = "([^"]*)"', body)
        if not painting or not default or not default.group(1):
            continue
        result[painting.group(1)] = default.group(1)
    return result


def _load_face_image(out_root, key, expr):
    """从 paintingface/<key> 取编号 expr 的表情图。"""
    path = os.path.join(out_root, "Assets", "paintingface", key)
    if not os.path.isfile(path):
        return None
    try:
        env = UnityPy.load(path)
        for obj in env.objects:
            if obj.type.name != "Texture2D":
                continue
            d = obj.read()
            c = str(getattr(obj, "container", "") or "")
            if d.m_Name == expr or c.endswith(f"/{expr}.png"):
                return d.image
    except Exception:
        return None
    return None


def _list_face_exprs(out_root, key):
    """paintingface/<key> 里全部表情编号。"""
    path = os.path.join(out_root, "Assets", "paintingface", key)
    if not os.path.isfile(path):
        return []
    names = set()
    try:
        env = UnityPy.load(path)
        for obj in env.objects:
            if obj.type.name != "Texture2D":
                continue
            d = obj.read()
            c = str(getattr(obj, "container", "") or "")
            if "/PaintingFace/" in c:
                names.add(c.rsplit("/", 1)[-1].removesuffix(".png"))
            elif d.m_Name:
                names.add(d.m_Name)
    except Exception:
        return []
    return sorted(names, key=lambda x: (len(x), x))


def _face_placement(out_root, key, canvas_size, target_layer="key"):
    """由 prefab 计算 face 节点在指定主立绘画布上的位置与尺寸 (像素)。

    key 层: 按 MeshImage.OnPopulateMesh 的精确公式
    (meshVertex + (-pivot*rawSize + delta)) * (rect/rawSize) 反算,
    返回 rawSize 画布坐标。
    rw 层: 保留旧的世界坐标换算 (近似)。
    """
    prefab = os.path.join(out_root, "Assets", "painting", key)
    if not os.path.isfile(prefab):
        return None
    try:
        UnityPy.config.FALLBACK_UNITY_VERSION = UNITY_FALLBACK
        env = UnityPy.load(prefab)
        gname = {}
        for obj in env.objects:
            if obj.type.name == "GameObject":
                try:
                    gname[obj.path_id] = obj.read().m_Name
                except Exception:
                    pass
        layer_rt = {}
        layer_raw = {}
        layer_delta = {}
        face_rt = None
        for obj in env.objects:
            tt = obj.read_typetree()
            go = tt.get("m_GameObject", {}).get("m_PathID")
            nm = gname.get(go)
            if obj.type.name == "RectTransform":
                if nm == key:
                    layer_rt["key"] = tt
                elif nm == f"{key}_rw":
                    layer_rt["rw"] = tt
                elif nm == "face":
                    face_rt = tt
            elif obj.type.name == "MonoBehaviour" and "mRawSpriteSize" in tt:
                if nm == key:
                    layer_raw["key"] = tt.get("mRawSpriteSize")
                    layer_delta["key"] = (
                        tt.get("delta_offset_x", 0.0),
                        tt.get("delta_offset_y", 0.0),
                    )
                elif nm == f"{key}_rw":
                    layer_raw["rw"] = tt.get("mRawSpriteSize")
                    layer_delta["rw"] = (
                        tt.get("delta_offset_x", 0.0),
                        tt.get("delta_offset_y", 0.0),
                    )
        if "key" not in layer_rt or face_rt is None:
            return None
        if target_layer == "rw" and "rw" not in layer_rt:
            target_layer = "key"

        def rt_info(tt):
            return {
                "pos": tt.get("m_AnchoredPosition"),
                "size": tt.get("m_SizeDelta"),
                "scale": tt.get("m_LocalScale"),
                "pivot": tt.get("m_Pivot"),
            }

        src = rt_info(layer_rt["key"])

        # face 相对 key 层 pivot 的局部坐标 (锚点 0.5)
        src_cx = (0.5 - src["pivot"]["x"]) * src["size"]["x"]
        src_cy = (0.5 - src["pivot"]["y"]) * src["size"]["y"]
        if target_layer == "key":
            raw = layer_raw.get("key")
            if not raw or not raw.get("x") or not raw.get("y"):
                return None
            rx, ry = raw["x"], raw["y"]
            # MeshImage.OnPopulateMesh:
            #   screenLocal = (meshVertex + (-pivot*raw + delta)) * (rect/raw)
            # => meshVertex = screenLocal / (rect/raw) - (-pivot*raw + delta)
            face_local = (
                src_cx + face_rt.get("m_AnchoredPosition")["x"],
                src_cy + face_rt.get("m_AnchoredPosition")["y"],
            )
            rect_w = src["size"]["x"]
            rect_h = src["size"]["y"]
            val_x = rect_w / rx
            val_y = rect_h / ry
            dx, dy = layer_delta.get("key", (0.0, 0.0))
            num_x = -src["pivot"]["x"] * rx + dx
            num_y = -src["pivot"]["y"] * ry + dy
            mx = face_local[0] / val_x - num_x
            my = face_local[1] / val_y - num_y
            py = canvas_size[1] - my  # canvas == rawSize
            fw = face_rt.get("m_SizeDelta")["x"] / val_x
            fh = face_rt.get("m_SizeDelta")["y"] / val_y
            return (round(mx - fw / 2), round(py - fh / 2)), (round(fw), round(fh))
        else:
            # rw: 近似世界坐标换算 (保留旧逻辑)
            tgt = rt_info(layer_rt["rw"])
            face_local = (
                src_cx + face_rt.get("m_AnchoredPosition")["x"],
                src_cy + face_rt.get("m_AnchoredPosition")["y"],
            )
            face_size = (
                face_rt.get("m_SizeDelta")["x"],
                face_rt.get("m_SizeDelta")["y"],
            )
            # 世界坐标: 根级 sibling, anchoredPosition 相对同一根中心
            world = (
                src["pos"]["x"] + face_local[0] * src["scale"]["x"],
                src["pos"]["y"] + face_local[1] * src["scale"]["y"],
            )
            tgt_local = (
                (world[0] - tgt["pos"]["x"]) / tgt["scale"]["x"],
                (world[1] - tgt["pos"]["y"]) / tgt["scale"]["y"],
            )
            tgt_scale = tgt["scale"]
            tgt_size = tgt["size"]
            tgt_pivot = tgt["pivot"]
            face_world_size = (
                face_size[0] * src["scale"]["x"],
                face_size[1] * src["scale"]["y"],
            )

            rect_min = (
                -tgt_pivot["x"] * tgt_size["x"],
                -tgt_pivot["y"] * tgt_size["y"],
            )
            sx = tgt_size["x"] / canvas_size[0]
            sy = tgt_size["y"] / canvas_size[1]
            px = (tgt_local[0] - rect_min[0]) / sx
            py_up = (tgt_local[1] - rect_min[1]) / sy
            py = canvas_size[1] - py_up
            fw = face_world_size[0] / tgt_scale["x"] / sx
            fh = face_world_size[1] / tgt_scale["y"] / sy
            return (round(px - fw / 2), round(py - fh / 2)), (round(fw), round(fh))
    except Exception:
        return None


def _paste_face(target, face, pos):
    """透明混合粘贴表情 (alpha blend)。"""
    try:
        import numpy
        from PIL import Image, ImageChops
    except ImportError:
        target.paste(face, (int(pos[0]), int(pos[1])), face)
        return target
    x, y = int(pos[0]), int(pos[1])
    w, h = face.size
    region = target.crop((x, y, x + w, y + h))
    alpha = face.getchannel("A")
    a_f = ImageChops.lighter(alpha, region.getchannel("A"))
    scale = numpy.array(alpha, dtype=float) / 255.0
    fa = numpy.array(face)
    ba = numpy.array(region)
    for i in range(3):
        ba[:, :, i] = ba[:, :, i] * (1 - scale)
        fa[:, :, i] = fa[:, :, i] * scale
    out = ba + fa
    out[:, :, 3] = numpy.array(a_f)
    target.paste(Image.fromarray(out), (x, y))
    return target


def restore_bundle(path, bust=False, raw_size=None):
    UnityPy.config.FALLBACK_UNITY_VERSION = UNITY_FALLBACK
    env = UnityPy.load(path)
    tex = mesh = sprite = None
    for obj in env.objects:
        t = obj.type.name
        try:
            if t == "Texture2D" and tex is None:
                tex = obj.read().image
            elif t == "Mesh" and mesh is None:
                mesh = obj.read()
            elif t == "Sprite" and sprite is None:
                sprite = obj.read()
        except Exception:
            continue
    if tex is None and mesh is not None and not bust:
        # 只有 Mesh 的包: 从同名基础贴图包找 Texture2D 配对
        base = os.path.basename(path)
        if base.endswith("_tex"):
            base = base[: -len("_tex")]
        parts = base.split("_")
        for i in range(len(parts) - 1, 0, -1):
            cand = os.path.join(
                os.path.dirname(path), "_".join(parts[:i]) + "_tex"
            )
            if not os.path.isfile(cand):
                continue
            try:
                tenv = UnityPy.load(cand)
                for tobj in tenv.objects:
                    if tobj.type.name == "Texture2D":
                        tex = tobj.read().image
                        break
            except Exception:
                continue
            if tex is not None:
                break
    if tex is None:
        return None
    if bust:
        # 半身像: 直接用 Sprite 原图, 不使用包里的外部 Mesh
        # (外部 Mesh 是全屏/立绘层用的, 拼出来会碎)
        return _crop_sprite(tex, sprite)
    if mesh is not None:
        return _stitch(mesh, tex, canvas_size=raw_size)
    if sprite is not None and _sprite_internal_vertex_count(sprite) > 4:
        return _stitch(*_decode_sprite_mesh(sprite), tex)
    return _crop_sprite(tex, sprite)


# --------------------------------------------------------------------------
# 命名
# --------------------------------------------------------------------------


def _safe(name):
    name = re.sub(r'[\\/:*?"<>|]', "_", name)
    name = name.rstrip(" .")
    return name or "_"


def output_name(key, basename, skins, ship_names, name_map=None):
    v = skins.get(key.lower())
    if v:
        ship = ship_names.get(str(v.get("ship_group")))
        if not ship:
            ship = v.get("name") if v.get("group_index", 0) == 0 else key
        skin_name = v.get("name")
    else:
        ship = key
        skin_name = None
    ship = _resolve_namecodes(ship, name_map)
    skin_name = _resolve_namecodes(skin_name, name_map)
    if skin_name and skin_name != ship:
        fname = f"{ship}_{skin_name}"
    else:
        fname = ship
    return _safe(ship), _safe(fname)


# --------------------------------------------------------------------------
# 主流程
# --------------------------------------------------------------------------


def run(out_root, jobs=8, limit=None):
    """还原 Assets/painting 下全部立绘到 Painting/。"""
    UnityPy.config.FALLBACK_UNITY_VERSION = UNITY_FALLBACK

    pfm_lua = _find_lua(out_root, "painting_filte_map.lua")
    if not pfm_lua:
        raise RuntimeError("缺少 painting_filte_map.lua, 请先下载并反编译数据表")
    groups = parse_painting_groups(pfm_lua)
    res2key = {}
    for key, res in groups.items():
        for r in res:
            if r.endswith("_tex"):
                res2key[r] = key

    console.print("[cyan]构建皮肤/舰船名映射 ...[/cyan]")
    skins, ship_names, name_map = _build_skin_map(out_root, jobs=jobs)
    matched = sum(1 for k in groups if k in skins)
    console.print(
        f"[green]映射完成: {len(skins)} 个皮肤 key, 覆盖 {matched}/{len(groups)} 个立绘组[/green]"
    )
    if matched < len(groups) * 0.5:
        console.print(
            "[yellow]覆盖偏低, 本地数据表可能过期; 建议先完整更新 Assets 与 Lua[/yellow]"
        )

    painting_dir = os.path.join(out_root, "Assets", "painting")
    if not os.path.isdir(painting_dir):
        raise RuntimeError(f"缺少立绘目录: {painting_dir}")
    files = sorted(
        f
        for f in os.listdir(painting_dir)
        if f.endswith("_tex") and f in res2key and "shadow" not in f
    )
    if limit:
        files = files[:limit]

    # 每个 key 的主立绘: 有 _rw 时优先取 _rw (全身人物立绘)
    files_by_key = {}
    for f in files:
        key = res2key[f]
        files_by_key.setdefault(key, []).append(f[: -len("_tex")])
    main_src = {}
    for key, names in files_by_key.items():
        main_src[key] = f"{key}_rw" if f"{key}_rw" in names else key

    # 同一 船名+皮肤名 的主 key (最短/无替代后缀): 重名时保留无后缀名
    main_groups = {}
    for f in files:
        key = res2key[f]
        main = main_src.get(key, key)
        ship, name = output_name(key, main, skins, ship_names, name_map)
        main_groups.setdefault((ship, name), []).append(key)
    canonical_key = {
        grp: min(keys, key=lambda k: (len(k), k))
        for grp, keys in main_groups.items()
    }
    key_canonical = {}
    for grp, keys in main_groups.items():
        ck = canonical_key[grp]
        for k in keys:
            key_canonical[k] = ck

    # 预计算输出路径; 不同 key 解析出相同 船名+皮肤名 时追加 key 区分
    planned = {}
    dup_count = {}
    for f in files:
        base = f[: -len("_tex")]
        key = res2key[f]
        main = main_src.get(key, key)
        ship, name = output_name(key, base, skins, ship_names, name_map)
        if base == key and main != key:
            variant = "半身"
        elif base == main:
            variant = ""
        else:
            variant = (
                base[len(key):].lstrip("_")
                if base.lower().startswith(key.lower())
                else base
            )
        if variant:
            name = f"{name}_{variant}"
        rel = os.path.join(ship, f"碧蓝航线_{name}.png")
        planned[f] = rel
        dup_count[rel] = dup_count.get(rel, 0) + 1
    used = set()
    for f in files:
        rel = planned[f]
        if dup_count[rel] > 1:
            key = res2key[f]
            if key_canonical.get(key) != key:
                stem, ext = os.path.splitext(rel)
                cand = f"{stem}_{key}{ext}"
                n = 2
                while cand in used:
                    cand = f"{stem}_{key}_{n}{ext}"
                    n += 1
                planned[f] = cand
        used.add(planned[f])

    out_dir = os.path.join(out_root, PAINTING_OUT)
    os.makedirs(out_dir, exist_ok=True)
    console.print(f"[cyan]待还原 {len(files)} 个立绘 -> {out_dir}[/cyan]")
    expr_defaults = _parse_expression_defaults(out_root)

    ok = fail = skip = 0
    errors = {}
    skipped = []

    def one(fname):
        base = fname[: -len("_tex")]
        key = res2key[fname]
        ship, name = output_name(key, base, skins, ship_names, name_map)
        main = main_src.get(key, key)
        bust = False
        if base == key and main != key:
            # 主立绘用 _rw, 无后缀的基础包是半身像, 单独输出 _半身
            variant = "半身"
            bust = True
        elif base == main:
            variant = ""
        else:
            variant = (
                base[len(key):].lstrip("_")
                if base.lower().startswith(key.lower())
                else base
            )
        if variant:
            name = f"{name}_{variant}"
        rel = planned[fname]
        dst = os.path.join(out_dir, rel)
        try:
            img = restore_bundle(
                os.path.join(painting_dir, fname),
                bust=bust and not _bust_uses_mesh(out_root, key),
            )
            if img is None:
                return fname, None, "SKIP"
            if variant == "" and expr_defaults.get(key) and not main.endswith("_rw"):
                # key 层按 MeshImage 公式贴脸: 画布必须用 mRawSpriteSize,
                # 否则裁掉顶部留白会导致脸错位 (如 xipeier_idolns)
                raw = _layer_raw_size(out_root, key)
                if raw:
                    img = restore_bundle(
                        os.path.join(painting_dir, fname),
                        raw_size=raw,
                    )
            os.makedirs(os.path.dirname(dst), exist_ok=True)
            img.save(dst)
            if variant == "":
                default = expr_defaults.get(key)
                if default:
                    exprs = _list_face_exprs(out_root, key)
                else:
                    exprs = []
                if exprs:
                    target_layer = "rw" if main.endswith("_rw") else "key"
                    place = _face_placement(out_root, key, img.size, target_layer)
                    if place:
                        pos, fsize = place
                        for ex in exprs:
                            face = _load_face_image(out_root, key, ex)
                            if face is None:
                                continue
                            fimg = face.resize(fsize) if face.size != fsize else face
                            comp = img.copy()
                            _paste_face(comp, fimg, pos)
                            if default and ex == default:
                                comp.save(dst)  # 主立绘合成默认表情
                            else:
                                comp.save(dst[: -len(".png")] + f"_表情{ex}.png")
            return fname, rel, None
        except Exception as e:
            return fname, None, f"{type(e).__name__}: {e}"

    with Progress(
        TextColumn("[progress.description]{task.description}"),
        BarColumn(),
        "[progress.percentage]{task.percentage:>3.0f}%",
        TransferSpeedColumn(),
        TimeRemainingColumn(),
        console=console,
    ) as progress:
        task = progress.add_task("还原立绘", total=len(files))
        with ThreadPoolExecutor(max_workers=jobs) as ex:
            futs = [ex.submit(one, f) for f in files]
            for fut in as_completed(futs):
                fname, rel, err = fut.result()
                progress.advance(task)
                if err:
                    if err == "SKIP":
                        skip += 1
                        skipped.append(fname)
                    else:
                        fail += 1
                        errors[fname] = err
                        console.print(f"[red]失败 {fname}: {err}[/red]")
                else:
                    ok += 1

    summary = {
        "total": len(files),
        "ok": ok,
        "fail": fail,
        "skip": skip,
        "time": __import__("time").strftime("%Y-%m-%d %H:%M:%S"),
        "errors": errors,
        "skipped": skipped,
    }
    with open(os.path.join(out_dir, "painting_result.json"), "w", encoding="utf-8") as f:
        json.dump(summary, f, ensure_ascii=False, indent=2)

    console.print(f"[green]立绘还原完成: 成功 {ok}, 跳过 {skip}, 失败 {fail}[/green]")
    if skipped:
        console.print(f"[yellow]跳过 {len(skipped)} 个无贴图/动画包:[/yellow]")
        for fname in skipped[:20]:
            console.print(f"[yellow]  {fname}[/yellow]")
    if errors:
        for fname in list(errors)[:10]:
            console.print(f"[red]  {fname}: {errors[fname]}[/red]")
    return summary


if __name__ == "__main__":
    import argparse

    ap = argparse.ArgumentParser(description="碧蓝航线立绘还原")
    ap.add_argument("--out", default=os.getcwd(), help="游戏根目录")
    ap.add_argument("--jobs", type=int, default=8)
    ap.add_argument("--limit", type=int, default=None, help="只处理前 N 个 (调试)")
    args = ap.parse_args()
    run(args.out, jobs=args.jobs, limit=args.limit)
