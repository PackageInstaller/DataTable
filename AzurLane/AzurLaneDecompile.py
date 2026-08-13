import argparse
import concurrent.futures
import glob
import os
import shutil
import subprocess
import sys
import tempfile

import UnityPy

from AzurLane2Std import convert
from Scipio import scipio_www


def decompiler_binary():
    return shutil.which("luajit-decompiler")


def detect_bits(data):
    return "x64" if (data[4] & 0x08) else "x86"


def normalize_lua_name(name):
    if name.endswith(".bytes"):
        name = name[: -len(".bytes")]
    while name.endswith(".lua.lua"):
        name = name[: -len(".lua")]
    if not name.endswith(".lua"):
        name += ".lua"
    return name


def container_rel_path(container, fallback_name, bits):
    rel = container.replace("\\", "/").strip("/")
    if not rel:
        rel = f"{bits}/{fallback_name}"
    return normalize_lua_name(rel)


def is_bundle(path):
    raw = open(path, "rb").read(16)
    if raw.startswith(b"UnityFS"):
        return True
    if raw[:3] == b"\x1bLJ":
        return False
    try:
        return scipio_www(open(path, "rb").read()).startswith(b"UnityFS")
    except Exception:
        return False


def extract_scripts(path, out_dir, limit=None):
    raw = open(path, "rb").read()
    if not raw.startswith(b"UnityFS"):
        raw = scipio_www(raw)
    tmp = os.path.join(out_dir, "_dec.ys")
    open(tmp, "wb").write(raw)
    env = UnityPy.load(tmp)
    os.unlink(tmp)
    bits = None
    files = []
    n = 0
    for obj in env.objects:
        if obj.type.name != "TextAsset":
            continue
        d = obj.read()
        s = d.m_Script
        if isinstance(s, str):
            s = s.encode("utf-8", "surrogateescape")
        if bits is None:
            bits = detect_bits(s)
        container = getattr(obj, "container", None) or ""
        out_name = os.path.basename(container.replace("\\", "/"))
        if not out_name:
            out_name = str(getattr(d, "m_Name", None) or obj.path_id)
        std_name = "asset_" + str(abs(obj.path_id))
        dst = os.path.join(out_dir, std_name + ".lua")
        open(dst, "wb").write(s)
        files.append((dst, container_rel_path(container, out_name, bits), container))
        n += 1
        if limit and n >= limit:
            break
    return bits, files


def decompile_bundle(input_path, out_dir, bits="auto", limit=None, keep_std=False, jobs=16):
    dec = decompiler_binary()
    if not dec:
        print("未找到 luajit-decompiler 命令, 请通过 AUR 包安装:")
        print("luajit-decompiler-git")
        return {"ok": 0, "fail": 1, "out": out_dir}

    work = tempfile.mkdtemp(prefix="azl_std_")
    std_dir = os.path.join(work, "std")
    os.makedirs(std_dir)

    files = []
    bits = None
    ys_mode = False
    if os.path.isdir(input_path):
        paths = sorted(
            glob.glob(os.path.join(input_path, "*.lua"))
            + glob.glob(os.path.join(input_path, "*.luac"))
        )
        files = [(p, normalize_lua_name(os.path.basename(p)), "") for p in paths]
        if paths:
            bits = detect_bits(open(paths[0], "rb").read())
    elif input_path.endswith(".ys") or is_bundle(input_path):
        ys_mode = True
        bits, files = extract_scripts(input_path, work, limit)
    else:
        files = [(input_path, normalize_lua_name(os.path.basename(input_path)), "")]
        bits = detect_bits(open(input_path, "rb").read())

    if not ys_mode:
        out_dir = os.path.join(out_dir, bits) if bits else out_dir
    os.makedirs(out_dir, exist_ok=True)

    converted = 0
    meta = []
    for src, out_name, container in files:
        std_name = os.path.basename(src).rsplit(".", 1)[0]
        try:
            data = convert(open(src, "rb").read())
        except Exception as exc:
            print(f"[convert] FAIL {std_name}: {exc}")
            continue
        std_path = os.path.join(std_dir, std_name + ".luac")
        open(std_path, "wb").write(data)
        meta.append((std_path, out_name, container))
        converted += 1
    print(f"[convert] {converted}/{len(files)}")

    def run_one(path):
        return subprocess.run(
            [dec, path, "-o", out_dir, "-f", "-s"],
            capture_output=True,
            text=True,
            timeout=30,
        )

    ok = 0
    fails = {}
    with concurrent.futures.ThreadPoolExecutor(max_workers=jobs) as ex:
        futures = {ex.submit(run_one, p): p for p, _, _ in meta}
        for fut in concurrent.futures.as_completed(futures):
            p = futures[fut]
            try:
                r = fut.result()
            except subprocess.TimeoutExpired:
                fails[os.path.basename(p)] = "timeout"
                continue
            out = r.stdout + r.stderr
            if "Error running" in out or "dumped core" in out or "Aborted" in out:
                fails[os.path.basename(p)] = "error"
            else:
                ok += 1

    for std_path, rel, container in meta:
        std_name = os.path.basename(std_path).rsplit(".", 1)[0]
        src_out = os.path.join(out_dir, std_name + ".luac.lua")
        if not os.path.exists(src_out):
            continue
        dst = os.path.join(out_dir, rel)
        if os.path.exists(dst):
            dst = os.path.join(os.path.dirname(dst), f"{std_name[:10]}_{os.path.basename(dst)}")
        os.makedirs(os.path.dirname(dst) or ".", exist_ok=True)
        os.replace(src_out, dst)

    print(f"[decompile] {ok}/{len(files)} 个脚本已反编译到 {out_dir}")
    if fails:
        print(f"[decompile] 失败 {len(fails)} 个:")
        for name in list(fails)[:10]:
            print(f"  {name}: {fails[name]}")
    if keep_std:
        for f in glob.glob(os.path.join(std_dir, "*.luac")):
            shutil.copy(f, out_dir)
    else:
        shutil.rmtree(work, ignore_errors=True)
    return {"ok": ok, "fail": len(fails), "out": out_dir}


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("input")
    ap.add_argument("-o", "--output", default="decompiled")
    ap.add_argument("-b", "--bits", choices=("x64", "x86", "auto"), default="auto")
    ap.add_argument("-n", "--limit", type=int)
    ap.add_argument("-k", "--keep-std", action="store_true")
    args = ap.parse_args()
    decompile_bundle(args.input, args.output, bits=args.bits, limit=args.limit, keep_std=args.keep_std)
    return 0


if __name__ == "__main__":
    sys.exit(main())
