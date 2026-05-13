import os
import sys
import xxtea
import subprocess
import shutil
from pathlib import Path
from concurrent.futures import ThreadPoolExecutor

# 配置常量
SIGN = b"zhaolu"
KEY = b"6410A02327CF59BC"
OUTPUT_ROOT = Path("MasterData")
MAX_WORKERS = os.cpu_count() * 2  # 根据核心数动态设置线程

def process_file(file_path: Path, input_root: Path):
    """
    处理单个文件的核心函数
    """
    try:
        rel_path = file_path.relative_to(input_root)
        out_path = OUTPUT_ROOT / input_root.name / rel_path
        out_path.parent.mkdir(parents=True, exist_ok=True)
        data = file_path.read_bytes()
        is_encrypted = data.startswith(SIGN)
        is_lua_bytecode = data.startswith(b"\x1bLua")
        is_lua_ext = file_path.suffix.lower() == ".lua"

        if is_encrypted or is_lua_bytecode or is_lua_ext:
            if not is_lua_ext:
                out_path = out_path.with_suffix(out_path.suffix + ".lua")

            input_for_unluac = str(file_path)
            temp_file = None

            if is_encrypted:
                decrypted_data = xxtea.decrypt(data[len(SIGN):], KEY, padding=False)
                temp_file = out_path.with_name(f"temp_{file_path.name}")
                temp_file.write_bytes(decrypted_data)
                input_for_unluac = str(temp_file)

            cmd = ["unluac", "--rawstring", input_for_unluac]
            try:
                with open(out_path, "w", encoding="utf-8") as out_f:
                    result = subprocess.run(cmd, stdout=out_f, stderr=subprocess.PIPE, text=True)
                
                if result.returncode == 0:
                    print(f"[成功] 反编译: {rel_path} -> {out_path.name}")
            finally:
                if temp_file and temp_file.exists():
                    temp_file.unlink()
        else:
            shutil.copy2(file_path, out_path)
            print(f"[复制] 资源文件: {rel_path}")
            
    except Exception as e:
        print(f"[错误] 无法处理文件 {file_path}: {e}")

def main():
    input_dirs = [Path(d) for d in sys.argv[1:] if Path(d).is_dir()]
    OUTPUT_ROOT.mkdir(parents=True, exist_ok=True)

    tasks = []
    for input_root in input_dirs:
        for file_path in input_root.rglob("*"):
            if file_path.is_file():
                tasks.append((file_path, input_root))

    with ThreadPoolExecutor(max_workers=MAX_WORKERS) as executor:
        for file_path, input_root in tasks:
            executor.submit(process_file, file_path, input_root)

if __name__ == "__main__":
    main()
