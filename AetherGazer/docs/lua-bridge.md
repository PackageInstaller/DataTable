# Lua 脚本桥（ToLua）与脚本分发链路

更新器筛选（只下载 Lua bundle + tolua 运行时）：

```bash
python updater/aethergazer_updater.py --output ./aethergazer --only lua
```

一键下载并提取全部 Lua（输出到 `Lua/`，按内部路径还原）：

```bash
python scripts/fetch_lua.py
python scripts/fetch_lua.py --output ./Lua --arch 64
```

## 1.LuaJIT 字节码反编译（luajit-decompiler）

反编译工具为 Linux 原生版（C++23 + CMake），已安装为系统命令
`luajit-decompiler`。源码与变更记录见 fork：
[PackageInstaller/luajit-decompiler](https://github.com/PackageInstaller/luajit-decompiler)

直接反编译（输入可以是单个 `.lua.bytes` 或目录，`-o` 指定输出目录）：

```bash
luajit-decompiler Lua/x64 -o LuaDecomp/x64 -s
```

或者一键：下载两个架构的 bundle、拆出字节码、再调用系统命令反编译：

```bash
python scripts/fetch_lua.py --decompile
# 输出：Lua/x64、Lua/x86（字节码），LuaDecomp/x64、LuaDecomp/x86（反编译结果）
```
