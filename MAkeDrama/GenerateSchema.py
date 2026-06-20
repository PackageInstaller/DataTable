import re
import os


def main():
    cs_file = "cs/il2cpp.cs"
    output_file = "MAkeDramaSchema.py"

    if not os.path.exists(cs_file):
        print(f"错误: 找不到 C# 文件 {cs_file}")
        return

    print(f"正在读取 {cs_file} 并提取 Class 与 Enum 结构...")
    with open(cs_file, "r", encoding="utf-8", errors="ignore") as f:
        content = f.read()

    type_definition_pattern = re.compile(
        r"^\s*(?:public|internal|private)\s+(?:(?:sealed|abstract|static|partial|readonly|unsafe)\s+)*(?:class|enum|struct)\s+\w+",
        re.MULTILINE,
    )
    type_starts = [tm.start() for tm in type_definition_pattern.finditer(content)]

    class_header_pattern = re.compile(
        r"\[MemoryPackable(?:[^{]*)\]\s*(?:public|internal)\s+class\s+(\w+)",
        re.MULTILINE,
    )
    class_matches = list(class_header_pattern.finditer(content))
    print(f"找到 {len(class_matches)} 个 MemoryPack 类结构。")

    database_schema = {}
    table_names = []

    def clean_field_name(name):
        match = re.match(r"^_(.*)_k__BackingField$", name)
        if match:
            return match.group(1)
        if name.startswith("_"):
            return name[1:]
        return name

    for i, match in enumerate(class_matches):
        class_name = match.group(1)
        if class_name.endswith("Array"):
            continue

        start_pos = match.start()
        end_pos = len(content)
        for ts in type_starts:
            if ts > match.end():
                end_pos = ts
                break

        class_block = content[start_pos:end_pos]

        field_pattern = re.compile(
            r"^\s*(?:public|private|protected|internal)\s+([\w_.<>\[\]]+)\s+(_[\w_]+_k__BackingField);",
            re.MULTILINE,
        )
        fields_found = field_pattern.findall(class_block)

        if not fields_found:
            continue

        table_names.append(class_name)
        database_schema[class_name] = [
            (clean_field_name(field_name), field_type)
            for field_type, field_name in fields_found
        ]

    print("开始扫描枚举结构...")
    enum_pattern = re.compile(
        r"public\s+enum\s+(\w+)(?:\s*:\s*(\w+))?[^{]*\{([\s\S]*?)\}", re.MULTILINE
    )
    enum_matches = enum_pattern.finditer(content)

    enum_schema = {}
    for match in enum_matches:
        enum_name = match.group(1)
        underlying_type = match.group(2) or "int"
        enum_body = match.group(3)

        member_pattern = re.compile(r"^\s*(\w+)\s*=\s*(-?\d+)", re.MULTILINE)
        members = member_pattern.findall(enum_body)

        if members:
            enum_dict = {"__underlying_type": underlying_type}
            for name, val in members:
                enum_dict[int(val)] = name
            enum_schema[enum_name] = enum_dict

    print(f"成功提取 {len(enum_schema)} 个枚举映射。")

    with open(output_file, "w", encoding="utf-8") as out_f:
        out_f.write("# 由 GenerateSchema.py 自动生成的数据库结构定义\n\n")

        out_f.write("TABLE_NAMES = [\n")
        for table in table_names:
            out_f.write(f"    {repr(table)},\n")
        out_f.write("]\n\n")

        out_f.write("DATABASE_SCHEMA = {\n")
        for table_key, fields in sorted(database_schema.items()):
            out_f.write(f"    {repr(table_key)}: [\n")
            for prop_name, prop_type in fields:
                out_f.write(f"        ({repr(prop_name)}, {repr(prop_type)}),\n")
            out_f.write("    ],\n")
        out_f.write("}\n\n")

        out_f.write("ENUM_SCHEMA = {\n")
        for enum_name, mapping in sorted(enum_schema.items()):
            out_f.write(f"    {repr(enum_name)}: {{\n")

            if "__underlying_type" in mapping:
                out_f.write(
                    f"        '__underlying_type': {repr(mapping['__underlying_type'])},\n"
                )

            numeric_keys = sorted([k for k in mapping.keys() if isinstance(k, int)])
            for val in numeric_keys:
                out_f.write(f"        {val}: {repr(mapping[val])},\n")

            out_f.write("    },\n")
        out_f.write("}\n")


if __name__ == "__main__":
    main()
