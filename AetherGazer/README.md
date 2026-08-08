# Aether Gazer PC Resource Tools

深空之眼（Aether Gazer）PC 版资源研究与数据表解析工具集。

> **免责声明**：本项目仅用于个人学习与逆向研究。所有资源版权归
> 发行方（Yostar / 勇仕网络）所有。请勿将本工具用于任何商业用途或
> 违反游戏服务条款的行为。

---

## 目录结构

```text
AetherGazer/
├── README.md
├── LICENSE
├── docs/
│   ├── updater.md              # 下载更新器使用文档
│   ├── masterdata.md           # 数据表解析文档
│   ├── config-format.md        # Config 容器/行/字段格式说明
│   └── reverse-engineering.md  # 热更 DLL 逆向还原全记录
├── updater/
│   └── aethergazer_updater.py  # 资源下载/增量更新器
├── masterdata/
│   ├── extract_config.py       # config.ys -> Config TextAsset
│   ├── config_parser.py        # Config -> MasterData/*.json
│   ├── extract_schema.py       # il2cpp.cs -> config_schema.json
│   └── config_schema.json      # 180 个 protobuf 消息字段映射
├── scripts/
│   └── fetch_masterdata.py     # 一键下载+提取+解析数据表
└── dll_reverse/
    ├── cdph_vm.py              # CDPH 壳 VM 解释器
    ├── decrypt_il.py           # IL 方法体解密
    ├── rebuild_dll.py          # 完整 DLL 重建
    ├── rebuild_all_dlls.py     # 批量重建 TextAsset/ 下全部热更 DLL
    ├── build_all.py            # 一站式：重建 + 反编译全部热更 DLL
    └── patch_system_refs.py    # 引用修补（ilspycmd 0 警告用）
```

## 快速开始

### 1. 下载全部资源（约 59 GiB，含中日语音）

```bash
python updater/aethergazer_updater.py --output ./aethergazer --jobs 8
```

首次运行全量下载到 `Assets/`；之后再次运行只下载差异到 `Updates/`。
常用参数：

```bash
# 只下载数据表与配置
python updater/aethergazer_updater.py --output ./aethergazer --only all --voice-lang ''

# 只下载立绘（portrait / portraitdlc）
python updater/aethergazer_updater.py --output ./aethergazer --illustration

# 只生成清单与下载链接，不下载
python updater/aethergazer_updater.py --output ./aethergazer --list-only

# 下载完成后自动解析数据表
python updater/aethergazer_updater.py --output ./aethergazer --masterdata
```

### 2. 一键解析数据表

```bash
python scripts/fetch_masterdata.py
```

脚本会自动下载 `config.ys`、提取 Config TextAsset、按字段映射反序列化
全部 89 张表到 `MasterData/`（每表一个 JSON 文件）。

### 3. 反编译HybridCLR DLL

```bash
cd dll_reverse
python rebuild_dll.py                       # 重建 P08.FlipCardGame.rebuilt.dll
python patch_system_refs.py                 # 生成引用修补版
cp P08.FlipCardGame.decompile.dll <游戏 Managed 目录>/   # 与引用程序集同目录
cd <游戏 Managed 目录>
ilspycmd P08.FlipCardGame.decompile.dll -p -o DLL   # 1025 个 .cs，0 警告
```

### 4. 批量重建并反编译全部HybridCLR DLL

```bash
cd dll_reverse
python build_all.py
```

## 文档

- [docs/updater.md](docs/updater.md) —— 下载更新器原理与参数
- [docs/masterdata.md](docs/masterdata.md) —— 数据表提取/解析/字段映射
- [docs/config-format.md](docs/config-format.md) —— Config 二进制格式
- [docs/reverse-engineering.md](docs/reverse-engineering.md) —— CDPH 容器、
  壳 VM、四流解密、DLL 重建与反编译全过程
