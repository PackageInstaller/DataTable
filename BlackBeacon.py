from concurrent.futures import ThreadPoolExecutor
import lzma
import sys
import os
import io
import uuid
import subprocess

KEY = (
    "8974EA6638CFDBE0F3ED0B283621D6BC31296082D9CCF432B107A03450171E7A"
    "0338C54D7354A3ABBA68632FC9F2290A89241C2AA427A7F65F4739C65C309285"
    "C11E5B9DA9411DA6321750DD2A0D9FFEBB240C6DF4EF1D55A3AAB9A85EB1E4A4"
    "3324EFC4D0F95DCBA5520BCECC4CE1DE371B9A4E02BBCF1B4DFDFD87912FA37"
    "1C732145A644943BF6D5A12C0B0F4619974E179F78D8B02BF38F32A38B69E22"
    "2EFC149B1C696275CDE3562E9D5BB456C2F23DA1BBDDC5C063442AA9B51A637"
    "DC35581A5F06AE064E870576E75DB9FC19938D35515C539DCCD5C2431268D45"
    "9AC45C1796E67DC745AE7E552B81C7346C02D53A1FA69B1DF16E6F4EBBD46A752769"
)


def rc4(key: bytes, data: bytes) -> bytes:
    b = list(range(256))
    j = 0
    for i in range(256):
        j = (j + b[i] + key[i % len(key)]) % 256
        b[i], b[j] = b[j], b[i]
    i = j = 0
    r = bytearray()
    for c in data:
        i = (i + 1) % 256
        j = (j + b[i]) % 256
        b[i], b[j] = b[j], b[i]
        r.append(c ^ (b[(b[i] + b[j]) % 256]))
    return bytes(r)


def process_file(fn: str, fd: bytes, od: str):
    """
    单个文件的写入与反编译任务（运行在线程池中）
    """
    # 统一路径分隔符并拆分，判断是否属于归档包内名为 "xls" 的文件夹
    path_parts = fn.replace("\\", "/").split("/")
    is_xls = "xls" in path_parts

    op = os.path.join(od, fn)
    
    # 如果属于 xls 文件夹下且后缀为 .txt，则将其输出名称修改为 .lua
    if is_xls and op.endswith(".txt"):
        op = os.path.splitext(op)[0] + ".lua"

    of = os.path.dirname(op)
    os.makedirs(of, exist_ok=True)

    # 只有当文件以 .lua 结尾，且【不属于】xls 文件夹时，才进行反编译
    if fn.endswith(".lua") and not is_xls:
        if not fd.startswith(b"\x1b"):
            with open(op, "wb") as f:
                f.write(fd)
        else:
            # 使用 UUID 产生唯一的临时文件名，防止多线程在同目录下发生冲突
            tmp = os.path.join(of, f"_tmp_{uuid.uuid4().hex}.lua")
            with open(tmp, "wb") as f:
                f.write(fd)
            
            cmd = ["unluac", "--rawstring", tmp, "--output", op]
            try:
                subprocess.run(
                    cmd, check=True, capture_output=True, text=True, encoding="utf-8"
                )
            except subprocess.CalledProcessError as e:
                print(f"Warning: Failed to decompile {fn}. Keeping raw bytes.")
                print(f"unluac error: {e.stderr.strip() if e.stderr else 'No stderr'}")
                with open(op, "wb") as f:
                    f.write(fd)
            finally:
                if os.path.exists(tmp):
                    try:
                        os.remove(tmp)
                    except OSError:
                        pass
    else:
        # xls 文件夹内的所有文件（以及原本为 .txt 并更名为 .lua 的文件）均视为明文直接写入
        with open(op, "wb") as f:
            f.write(fd)


def unpack(data: bytes, od: str):
    s = io.BytesIO(data)
    tasks = []

    # 第一步：单线程顺序解析文件流，收集所有文件元数据
    while s.tell() < len(data):
        eb = s.read(4)
        if len(eb) < 4:
            break
        es = int.from_bytes(eb, "big")

        fb = bytearray()
        while (c := s.read(1)) != b"\x00":
            if not c:
                break
            fb.extend(c)
        if not fb:
            continue
        fn = fb.decode("utf-8")
        fd = s.read(es - (len(fb) + 1))
        
        tasks.append((fn, fd))

    # 第二步：使用线程池并发处理文件写入与反编译
    with ThreadPoolExecutor() as executor:
        futures = [executor.submit(process_file, fn, fd, od) for fn, fd in tasks]
        for future in futures:
            future.result()

    print(f"当前归档解包完成，共处理文件数: {len(tasks)}")


def process_archive(file_path: str):
    """
    处理单个归档文件（解密、解压并启动解包）
    """
    print(f"正在处理归档文件: {file_path}")
    try:
        with open(file_path, "rb") as f:
            enc = f.read()
        
        com = rc4(bytes.fromhex(KEY), enc)
        s = com[0:4]
        
        eval_b = (s[0] << 24) | (s[2] << 16) | (s[1] << 8) | s[3]
        print(f"[{os.path.basename(file_path)}] Eval_b: {eval_b}")
        
        props = com[4:9]
        filters = [
            {
                "id": lzma.FILTER_LZMA1,
                "lc": props[0] % 9,
                "lp": (props[0] // 9) % 5,
                "pb": props[0] // 45,
                "dict_size": int.from_bytes(props[1:5], "little"),
            }
        ]
        
        file_basename = os.path.splitext(os.path.basename(file_path))[0]
        od = os.path.join("MasterData", file_basename)
        if not os.path.exists(od):
            os.makedirs(od)
            
        decompressed = lzma.LZMADecompressor(format=lzma.FORMAT_RAW, filters=filters).decompress(com[9:])
        unpack(decompressed, od)
    except Exception as e:
        print(f"处理文件 {file_path} 时遇到错误: {e}")


if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python BlackBeacon.py [folder_or_file_path]")
        sys.exit(1)

    input_path = sys.argv[1]
    
    # 自动识别传入路径是文件还是文件夹
    if os.path.isdir(input_path):
        files_to_process = []
        for root, dirs, files in os.walk(input_path):
            for file in files:
                # 排除一些常见的系统隐藏文件
                if not file.startswith("."):
                    files_to_process.append(os.path.join(root, file))
        files_to_process.sort()  # 有序处理
    else:
        files_to_process = [input_path]

    print(f"共检测到 {len(files_to_process)} 个文件。")
    for file_path in files_to_process:
        # 判断当前这个磁盘物理文件是否位于 "xls" 目录下
        disk_parts = file_path.replace("\\", "/").split("/")
        is_disk_xls = "xls" in disk_parts
        
        if is_disk_xls:
            # 如果磁盘文件路径本身包含 xls，说明它本就是明文配置文件，直接复制并转换后缀
            try:
                xls_idx = disk_parts.index("xls")
                sub_path = os.path.join(*disk_parts[xls_idx:])
                op = os.path.join("MasterData", sub_path)
            except ValueError:
                rel_path = os.path.relpath(file_path, input_path)
                op = os.path.join("MasterData", rel_path)
                
            if op.endswith(".txt"):
                op = os.path.splitext(op)[0] + ".lua"
                
            of = os.path.dirname(op)
            os.makedirs(of, exist_ok=True)
            
            try:
                with open(file_path, "rb") as f_in:
                    fd = f_in.read()
                with open(op, "wb") as f_out:
                    f_out.write(fd)
                print(f"复制明文配置文件: {file_path} -> {op}")
            except Exception as e:
                print(f"复制文件 {file_path} 时遇到错误: {e}")
        else:
            # 只有不在 xls 路径下的文件才会被当成加密归档执行解包
            process_archive(file_path)