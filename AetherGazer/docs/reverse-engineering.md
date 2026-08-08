# 热更 DLL 逆向还原

> 目标：`TextAsset/1cabbf636215d06aa12521cda5daedfb.bytes`
> = `P08.FlipCardGame.dll`（深空之眼 v5.2.1 热更小游戏 DLL）
> 平台：PC（GameAssembly.dll v5.2.1, imagebase 0x180000000, HybridCLR）
> 保护：CDPH 自定义容器 + 壳 VM + 分层加密（流/表/IL/字符串）
> 结果：重建 DLL 可被 ilspycmd 100% 无警告反编译（1025 个 C# 源文件）

## 一、保护架构

```text
TextAsset/*.bytes (CDPH 容器)
├─ [0x000] "CDPH" version=1 flag
├─ [0x010] key[256]（壳 VM 密钥）
├─ [0x110] 8 个 section 程序（长度前缀，各对应一类解密任务）
├─ [0x460] 水印 "Hello, HybridCLR"（~i 程序 + key 校验）
├─ [0x470] 配置: 元数据根 0x10dc14 / 大小 0x12bf78 / 范围表 / 字符串池偏移
├─ [0x538] 明文字符串池（~85KB，类型名/源文件路径）
├─ [0x14f48..0x10dc14] IL 代码区（加密，~1MB）
└─ [0x10dc14] BSJB 元数据根（明文头）+ 5 个流头
     ├─ #~       0x10dc80 (0x891f0)  表流（整段 + TypeDef 逐行加密）
     ├─ #Strings 0x196e70 (0x42778)  字符串堆
     ├─ #US      0x1d95e8 (0x48008)  用户字符串堆
     ├─ #GUID    0x2215f0 (0x10)
     └─ #Blob    0x221600 (0x1858c)  签名/blob 堆
```

### 壳 VM（sub_1806E11F0）

256 opcode 的字节码解释器，程序 = 一字节序列（0..255），对 buffer 逐
opcode 执行：`xor` / `ror` / `add` / `swap` / `decmove` 五类操作，
位置 = key 相关 mod buffer 长度。256 个 case 全部解析
（见 `cdph_vm.py::run_vm`）。

### 解密分层

| 数据                | 程序             | 分块    | 运行时路径                   |
| ------------------- | ---------------- | ------- | ---------------------------- |
| 水印                | ~i（0xFF..0x00） | 0x10    | loader 内校验                |
| #Strings            | section 1        | 0x100   | sub_1804D76B0                |
| #Blob               | section 2        | 0x100   | sub_1804D76B0                |
| #US（整段）         | section 3        | 0x100   | sub_1804D76B0                |
| #~（整段）          | section 5        | 0x100   | sub_1804D76B0                |
| #US（条目）         | section 4        | 0x10    | sub_1804D1E30                |
| TypeDef 表行        | section 6        | 行宽 18 | sub_1804DB2D0                |
| IL 代码（逐方法体） | section 7        | 0x10    | GetMethodBody → vtable+0x28 |

整段解密 ≠ 明文：#US/#~ 还需条目级/行级解密。

### 关键地址（GameAssembly.dll）

| 逻辑                       | 地址                              |
| -------------------------- | --------------------------------- |
| CDPH 容器解析/校验         | `0x1804D73B0`                   |
| 壳 VM                      | `0x1806E11F0`                   |
| 流解密包装（分块喂 VM）    | `0x1804FF5D0`                   |
| #US 懒解密                 | `0x1804D1E30`                   |
| #Blob 懒解密               | `0x1804CDD10`                   |
| 表行懒解密                 | `0x1804DB2D0`                   |
| 行 6 列解码（schema 驱动） | `0x1804DB360`                   |
| 解释器 Execute             | `0x18050F9E0` / `0x180517C80` |

## 二、元数据表（#~）

26 张表，行数（dnfile 权威解析）：

```text
Module 1 | TypeRef 462 | TypeDef 1612 | Field 11482 | MethodDef 10641
Param 8462 | InterfaceImpl 557 | MemberRef 4305 | Constant 1857
CustomAttribute 3653 | ClassLayout 9 | StandAloneSig 1984 | EventMap 3
Event 3 | PropertyMap 306 | Property 965 | MethodSemantics 1193
MethodImpl 656 | TypeSpec 889 | FieldRva 13 | Assembly 1 | AssemblyRef 32
NestedClass 585 | GenericParam 49 | MethodSpec 625 | GenericParamConstraint 22
```

行宽为标准 ECMA-335（heapSizes=0x05），但 **TypeRef 行布局为
scope 在前**：`ResolutionScope(2) @0, Name(4) @2, Namespace(4) @6`。

## 三、DLL 重建

`rebuild_dll.py` 步骤：

1. IL 代码区（0x14f48..0x10dc14）逐方法体解密（section7/chunk0x10，
   仅 IL 码，头明文）；
2. 覆盖四流解密结果（#Strings/#Blob/#US/#~）；
3. TypeDef 表行逐行解密（section6，行宽 18）；
4. MethodDef.Rva += 0x1000（容器偏移 → 文件偏移）；
5. 生成两节 PE 头（.clihdr + .text），CLI 头落在节内满足
   ilspycmd/System.Reflection.Metadata。

## 四、反编译验证

1. **签名 100% 合法**：原始 blob + 原始 #~ 重建后，
   System.Reflection.Metadata 对 MethodDef/Field/Property/MemberRef/
   TypeSpec/MethodSpec/StandAloneSig 全部 30,891 个签名解码 **0 失败**。
   （`fix_blob_signatures.py` 曾试图把压缩整数转 2 字节，该方案
   基于错误前提，已废弃。）
2. **"Unknown result type" 全部为缺引用**：12,274 条警告（303 文件）
   在 ilspycmd 能解析 `dll/` 内全部引用后降为 8 条；
3. `Queue`1/Stack`1` 的 TypeRef 指向 System，但本机 System.dll
   副本缺这两个类型（mscorlib 有完整实现含嵌套 Enumerator）——
   `patch_system_refs.py` 把这两个 TypeRef 改指 mscorlib 后
   **0 警告**（1025 文件全干净）。
4. `0x69 = conv.i4`（非 shl），游戏 IL 合法。

## 五、复现反编译

```bash
cd dll_reverse
python rebuild_dll.py              # P08.FlipCardGame.rebuilt.dll
python patch_system_refs.py        # P08.FlipCardGame.decompile.dll
cp P08.FlipCardGame.decompile.dll <Managed 目录>/
cd <Managed 目录>
ilspycmd P08.FlipCardGame.decompile.dll -p -o decompiled
```
