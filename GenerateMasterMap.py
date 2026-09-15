from __future__ import annotations

import argparse
import re
import sys
from pathlib import Path
from pprint import pformat
from typing import Dict, List, Optional, Set, Tuple

TABLE_ITEM_RE = re.compile(r'\[TableItem\(\"([^\"]+)\"')
CLASS_RE = re.compile(r'public\s+(?:sealed\s+|partial\s+|abstract\s+)*class\s+(\w+)(?:\s*:\s*([^\r\n\{]+))?')
KEY_RE = re.compile(r'\[(?:MessagePack\.)?Key\((\d+)\)\]')
COL_RE = re.compile(r'\[TableItemColumn\((?:\"([^\"]+)\"|null)')
COMPOSITE_TYPE_NAMES = {
    "tuc": "Quest",
    "ttx": "Item",
    "tue": "Stat",
    "ttz": "ShopItem",
    "tuf": "StatIncrease",
    "ttv": "Card",
    "tty": "ConditionGroup",
    "tuh": "NeedCondition",
    "tud": "NeedItem",
    "tua": "PvpBotStat",
    "ttw": "Drop",
}

PROP_RE = re.compile(r'public\s+([^\s<]+(?:<[^>]+>)?)\s+(\w+)(?:;|\s*\{)')


def parse_cs_dump(file_path: Path, verbose: bool = False) -> Dict[str, Dict[int, str]]:
    if not file_path.exists():
        print(f"[错误] 转储文件不存在: {file_path}", file=sys.stderr)
        return {}

    print(f"[*] 正在解析 C# 转储文件: {file_path} ...")
    with file_path.open("r", encoding="utf-8", errors="ignore") as f:
        lines = f.readlines()

    total_lines = len(lines)
    classes: Dict[str, Dict] = {}

    i = 0
    while i < total_lines:
        line = lines[i]
        cm = CLASS_RE.search(line)
        if cm:
            cls_name = cm.group(1)
            raw_parent = cm.group(2)
            parent = None
            if raw_parent:
                # 过滤泛型和接口
                first_p = raw_parent.split(",")[0].strip().split(" ")[0].split("<")[0]
                if first_p and first_p not in ("object", "TableData", "ITableBaseData"):
                    parent = first_p

            # 向上回溯特性注解
            tbl_name = None
            for prev_idx in range(max(0, i - 10), i):
                tm = TABLE_ITEM_RE.search(lines[prev_idx])
                if tm:
                    tbl_name = tm.group(1)
                    break

            # 扫描类内部花括号范围
            k = i + 1
            while k < total_lines and "{" not in lines[k]:
                k += 1
            brace = lines[k].count("{") - lines[k].count("}") if k < total_lines else 0
            k += 1

            fields: Dict[int, str] = {}
            pending_key: Optional[int] = None
            pending_col: Optional[str] = None

            while k < total_lines and brace > 0:
                cur = lines[k]
                brace += cur.count("{") - cur.count("}")

                km = KEY_RE.search(cur)
                if km:
                    pending_key = int(km.group(1))

                col_m = COL_RE.search(cur)
                if col_m:
                    pending_col = col_m.group(1)  # 可能为 None

                pm = PROP_RE.search(cur)
                if pm and pending_key is not None:
                    ptype = pm.group(1).split("<")[0].strip()
                    pname = pm.group(2)
                    if "_k__BackingField" not in pname:
                        if pending_col:
                            name = pending_col
                        elif ptype in COMPOSITE_TYPE_NAMES:
                            name = COMPOSITE_TYPE_NAMES[ptype]
                        else:
                            name = pname
                        fields[pending_key] = name
                    pending_key = None
                    pending_col = None

                k += 1

            classes[cls_name] = {
                "table_name": tbl_name,
                "parent": parent,
                "fields": fields,
            }
            i = k
            continue
        i += 1

    print(f"[*] 扫描到 {len(classes)} 个类定义。开始展开继承链并复用字段...")

    # 递归展开继承链字段
    def get_all_fields(c_name: str, visited: Optional[Set[str]] = None) -> Dict[int, str]:
        if visited is None:
            visited = set()
        if c_name in visited or c_name not in classes:
            return {}
        visited.add(c_name)

        c_info = classes[c_name]
        res: Dict[int, str] = {}
        # 先合并父类字段（子类可重写或扩充）
        if c_info["parent"]:
            res.update(get_all_fields(c_info["parent"], visited))
        res.update(c_info["fields"])
        return res

    # 扫描 TableData 容器属性，获取完整的 表名 -> 实体类名 映射
    print("[*] 正在扫描 TableData 容器属性以提取全局表名映射...")
    table_to_entity: Dict[str, str] = {}
    table_key_re = re.compile(r'\[Key\(\"([^\"]+)\"\)\]\s*(?:\[[^\]]+\]\s*)*public\s+([^\s<;]+(?:<[^;]+>)?)\s+(\w+)\s*\{')
    full_text = "".join(lines)
    for m in table_key_re.finditer(full_text):
        tbl_name = m.group(1)
        prop_type = m.group(2)
        tokens = re.findall(r"([a-zA-Z0-9_]+)", prop_type)
        if tokens:
            target_cls = tokens[-1]
            table_to_entity[tbl_name] = target_cls

    print(f"[*] 成功从 TableData 提取到 {len(table_to_entity)} 个官方数据表与实体类绑定。")

    # 构建最终注册表
    final_schemas: Dict[str, Dict[int, str]] = {}
    registered_table_count = 0

    # 1. 优先注册 TableData 属性绑定的官方业务表
    for tbl_name, target_cls in table_to_entity.items():
        all_flds = get_all_fields(target_cls)
        if all_flds:
            final_schemas[tbl_name] = all_flds
            final_schemas[f"{tbl_name}Data"] = all_flds
            registered_table_count += 1

    # 2. 注册直接通过 [TableItem] 标注或类名定义的表
    for cls_name, info in classes.items():
        all_flds = get_all_fields(cls_name)
        if not all_flds:
            continue

        keys_to_register = [cls_name]
        if info["table_name"] and info["table_name"] not in final_schemas:
            keys_to_register.append(info["table_name"])
            registered_table_count += 1

        # 检查是否为已知的基础复合类型
        if cls_name in COMPOSITE_TYPE_NAMES:
            alias_semantic = COMPOSITE_TYPE_NAMES[cls_name]
            keys_to_register.extend([
                alias_semantic,
                f"{alias_semantic}Data",
                f"TableBase{alias_semantic}Data",
            ])

        for k in keys_to_register:
            if k not in final_schemas:
                final_schemas[k] = all_flds
            # 双向别名支持：Xxx 与 XxxData
            if k.endswith("Data") and len(k) > 4:
                final_schemas.setdefault(k[:-4], all_flds)
            elif not k.endswith("Data"):
                final_schemas.setdefault(f"{k}Data", all_flds)

        if verbose and info["table_name"]:
            print(f"  [+] 映射表: {info['table_name']} ({cls_name}) -> {len(all_flds)} 字段")

    print(
        f"[*] 解析完成: 成功解析并继承 {registered_table_count} 个业务表，"
        f"生成共 {len(final_schemas)} 个别名与类型映射条目。"
    )
    return final_schemas


def write_master_map(schemas: Dict[str, Dict[int, str]], output_path: Path):
    """
    将 Schema 结构导出到 MasterMap.py。
    """
    print(f"[*] 正在写入 MasterMap: {output_path} (共 {len(schemas)} 个映射项)...")
    output_path.parent.mkdir(parents=True, exist_ok=True)

    sorted_tables = dict(sorted(schemas.items()))

    with output_path.open("w", encoding="utf-8") as f:
        f.write("# -*- coding: utf-8 -*-\n")
        f.write('"""\n')
        f.write("MasterMap.py - Trickcal Revive 数据表结构映射表\n")
        f.write("纯以 cs/il2cpp.cs 为基准由 GenerateMasterMap.py 自动生成，请勿手动修改。\n")
        f.write('"""\n\n')
        f.write("from typing import Dict\n\n")

        f.write("# 数据表字段映射表 (Table Name / Class Name -> {Index: Field Name})\n")
        f.write("TABLE_FIELD_MAPS: Dict[str, Dict[int, str]] = ")
        f.write(pformat(sorted_tables, indent=4, width=120))
        f.write("\n\n")

        f.write("# 兼容别名\n")
        f.write("SCHEMA_REGISTRY = TABLE_FIELD_MAPS\n")

    print(f"[+] 写入完成: {output_path}")


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        prog="GenerateMasterMap.py",
        description="Trickcal 数据表 Schema 生成器 (以 cs/il2cpp.cs 为唯一基准)",
        formatter_class=argparse.RawDescriptionHelpFormatter,
    )
    parser.add_argument(
        "--kr-dump",
        "--dump",
        dest="dump_path",
        type=Path,
        default=Path("cs/il2cpp.cs"),
        help="C# il2cpp dump 路径 (默认: cs/il2cpp.cs)",
    )
    parser.add_argument(
        "-o",
        "--output",
        type=Path,
        default=Path("MasterMap.py"),
        help="输出的 MasterMap.py 路径 (默认: MasterMap.py)",
    )
    parser.add_argument(
        "-v",
        "--verbose",
        action="store_true",
        help="打印详细解析过程",
    )
    return parser


def main(argv=None):
    args = build_parser().parse_args(argv)

    schemas = parse_cs_dump(args.dump_path, verbose=args.verbose)
    if not schemas:
        print("[错误] 未解析到任何表结构！", file=sys.stderr)
        return 1

    write_master_map(schemas, args.output)
    return 0


if __name__ == "__main__":
    sys.exit(main())
