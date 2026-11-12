local HOST = "localhost"
local PORT = 9966

local function findEmmyCoreDir()
  local home = os.getenv("USERPROFILE") or os.getenv("HOME")
  if not home or home == "" then
    return nil
  end
  local extRoot = home .. "\\.vscode\\extensions"
  local Directory = CS.System.IO.Directory
  if not Directory.Exists(extRoot) then
    return nil
  end
  local dirs = Directory.GetDirectories(extRoot, "tangzx.emmylua-*")
  local best
  for i = 0, dirs.Length - 1 do
    local d = dirs[i]
    if best == nil or best < d then
      best = d
    end
  end
  if not best then
    return nil
  end
  local dllDir = best .. "\\debugger\\emmy\\windows\\x64"
  if not Directory.Exists(dllDir) then
    return nil
  end
  return dllDir
end

local function startEmmyDebugger()
  local dllDir = findEmmyCoreDir()
  if not dllDir then
    print("[EmmyLua] 未找到 tangzx.emmylua 扩展目录,跳过调试器初始化")
    return false
  end
  local dllPath = dllDir .. "\\emmy_core.dll"
  package.cpath = package.cpath .. ";" .. dllDir .. "\\?.dll"
  local loader, err = package.loadlib(dllPath, "luaopen_emmy_core")
  if not loader then
    print("[EmmyLua] loadlib 失败: " .. tostring(err))
    return false
  end
  local ok, dbg = pcall(loader)
  if not ok or dbg == nil then
    print("[EmmyLua] luaopen_emmy_core 调用失败: " .. tostring(dbg))
    return false
  end
  package.loaded.emmy_core = dbg
  local okListen, errListen = pcall(function()
    dbg.tcpListen(HOST, PORT)
  end)
  if not okListen then
    print(string.format("[EmmyLua] tcpListen %s:%d 失败: %s", HOST, PORT, tostring(errListen)))
    return false
  end
  print(string.format("[EmmyLua] 监听 %s:%d,VSCode 可随时 F5 连接(断点可随时增删/断线重连)", HOST, PORT))
  return true
end

startEmmyDebugger()
return {start = startEmmyDebugger}
