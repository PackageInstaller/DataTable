import os
from io import BytesIO
from pathlib import Path
from re import finditer as reFit
from zlib import decompress as zlibDec
from PIL.Image import frombytes as imgFB
from texture2ddecoder import decode_etc1 as ETC1
from concurrent.futures import ProcessPoolExecutor, as_completed
from typing import Union, Set, List, Dict, Tuple


def ReadFile(file: Union[str, Path]) -> bytes:
    with open(file, 'rb') as f:
        data = f.read()
        return zlibDec(data) if data.startswith(b'\x78\xDA') else data

class IronSaga:
    @classmethod
    def GetTexOrigNames(cls, file: Union[str, Path] = 'all.bin') -> Dict[str, Set[str]]:
        data = ReadFile(file)
        mats = [i.start() - 2 for i in reFit(rb'driverAsset/ex.image.spine.', data)]
        r = BytesIO(data)
        names: Dict[str, Set[str]] = {}
        for i in mats:
            r.seek(i)
            o = r.read(int.from_bytes(r.read(2))).decode(errors='ignore').rsplit('/', 1)[1]
            n = r.read(int.from_bytes(r.read(2))).decode(errors='ignore')
            if not n: continue
            names.setdefault(o, set()).add(n)
        return names
    
    @classmethod
    def GetTexSize(cls, file: Union[str, Path] = 'desc.txt') -> Dict[str, List[int]]:
        names: Dict[str, List[int]] = {}
        try:
            lines = ReadFile(file).decode(errors='ignore').splitlines()
            for i in lines:
                parts = i.split(' ')
                if parts[0] != 'section' or len(parts) != 6: continue
                _, n, cw, ch, ow, oh = parts
                names[n] = [int(j) for j in (cw, ch, ow, oh)]
        except FileNotFoundError:
            print(f"警告: 尺寸描述文件 '{file}' 未找到。尺寸信息将不可用。")
        return names
    
    @classmethod
    def DecodeImage(cls, file: Path, sizes: List[int]):
        cw, ch, ow, oh = sizes
        with open(file, 'rb') as f:
            content = f.read()
        is_compressed = content[:2] in (b'\x78\x01', b'\x78\x9c', b'\x78\xDA', b'\x78\xda')
        stream = BytesIO(zlibDec(content) if is_compressed else content)
        stream.seek(56)
        data_len = int.from_bytes(stream.read(4))
        data = stream.read(data_len)
        height = oh * 2
        imgBytes = ETC1(data, ow, height)
        img = imgFB('RGBA', (ow, height), imgBytes, 'raw', 'BGRA')
        rgb = img.crop((0, 0, ow, oh))
        a = img.crop((0, oh, ow, height)).convert('L')
        rgb.putalpha(a)
        return rgb.crop((0, 0, cw, ch)) if (cw, ch) != (ow, oh) else rgb

    @classmethod
    def CovImg(cls, file: Path, names: Set[str], sizes: List[int]):
        rgba = cls.DecodeImage(file, sizes)
        output_path = file.parent
        if names:
            for name in names:
                rgba.save(output_path.joinpath(f'{name}.png'))
        else:
            rgba.save(output_path.joinpath(f'{file.stem}.png'))

def process_single_file(file_path: Path, names_map: Dict[str, Set[str]], sizes_map: Dict[str, List[int]]) -> Tuple[str, str]:

    item_stem = file_path.stem
    
    size = sizes_map.get(item_stem)
    if size is None:
        return ('not_found', f"没有查找到该贴图的尺寸 --- {file_path.as_posix()}")

    name_set = names_map.get(item_stem)

    try:
        IronSaga.CovImg(file_path, name_set, size)
        if name_set:
            return ('success', f"成功 -> {file_path.name} => {', '.join(name_set)}.png")
        else:
            return ('success_fallback', f"成功 (无原始名) -> {file_path.name} => {item_stem}.png")
    except Exception as e:
        return ('error', f"转换错误 --- {file_path.as_posix()} | 原因: {e}")

def batch(texPath: str = '', allbin: str = 'all.bin', desc: str = 'desc.txt', exts: Tuple[str, ...] = ('.enc', '.cet'), subfolder: bool = False):
    path = Path(texPath) if texPath else Path.cwd()
    glob_pattern = '**/*' if subfolder else '*'
    need = [i for i in path.glob(glob_pattern) if i.is_file() and i.name.endswith(exts)]
    print(f"[*] 发现 {len(need)} 个文件需要处理。")
    names = IronSaga.GetTexOrigNames(allbin)
    sizes = IronSaga.GetTexSize(desc)
    print("[*] 元数据加载完毕。")
    max_workers = os.cpu_count()
    print(f"[*] 启动进程池，核心数: {max_workers}")
    
    processed_count = 0
    total_files = len(need)
    
    with ProcessPoolExecutor(max_workers=max_workers) as executor:
        futures = {executor.submit(process_single_file, i, names, sizes): i for i in need}
        for future in as_completed(futures):
            processed_count += 1
            status, message = future.result()
            
            progress = f"[{processed_count}/{total_files}]"
            
            if status.startswith('success'):
                print(f"{progress} {message}")
            else:
                print(f"{progress} [警告] {message}")

    print("\n[+] 所有任务处理完毕！")

if __name__ == '__main__':
    path = r'bigMapEncEtc' 
    allbin_path = r'all.bin'
    desc_path = r'desc.txt'
    extensions = ('.enc', '.cet')
    search_subfolders = False 
    batch(path, allbin_path, desc_path, extensions, search_subfolders)