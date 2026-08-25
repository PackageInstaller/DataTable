local _xpcall = xpcall
local isEditor = CS.UnityEngine.Application.platform == CS.UnityEngine.RuntimePlatform.WindowsEditor

local function __TRACKBACK__(msg)
  Logger.Error(msg .. "\n" .. debug.traceback())
  return msg
end

function Trycall(func, ...)
  local args = (...)
  if nil ~= args then
    args = {
      ...
    }
    do return _xpcall, function()
      func(unpack(args))
    end end
    return _xpcall, function()
      func(unpack(args))
    end, __TRACKBACK__
  else
    do return _xpcall, func end
    return _xpcall, func, __TRACKBACK__
  end
end

local module_paths = {}
local module_tables = {}

function SetGlobal(key, value)
  rawset(_ENV, key, value)
end

function GetGlobal(key)
  do return rawget, _ENV end
  return rawget, _ENV, key
end

function GetModule(name)
  return module_tables[name]
end

function GetModulePaths()
  return module_paths
end

function GetModuleTables()
  return module_tables
end

function UsingNow(modulepath, modulename)
  local t = require(modulepath)
  if modulename and not module_tables[modulename] then
    if type(t) ~= "table" then
      module_tables[modulename] = true
      error("can not find module for path=" .. modulepath)
    else
      module_tables[modulename] = t
      SetGlobal(modulename, t)
    end
  end
  return t
end

function Using(modulepath, modulename)
  if modulename then
    if isEditor and module_paths[modulename] and module_paths[modulename] ~= modulepath then
      error("模块重名，modulename=" .. modulename .. "  modulepath=" .. modulepath)
      return false
    end
    module_paths[modulename] = modulepath
  end
  return true
end

function ReloadModule(module)
  local module_paths = GetModulePaths()
  local module_tables = GetModuleTables()
  local moduleName, modulePath
  if type(module) == "string" then
    moduleName = module
    modulePath = module_paths[moduleName]
    if not modulePath then
      print("ReloadModule failed no module path for global name", moduleName)
      return
    end
  else
    moduleName = module and module.__name
    if not moduleName then
      print("ReloadModule failed no module name (若为重工具表请传全局名字符串，如 ReloadModule(\"ItemDataUtils\"))", module or "nil")
      return
    end
    modulePath = module_paths[moduleName]
    if not modulePath then
      print("ReloadModule failed no module path", moduleName)
      return
    end
  end
  module_tables[moduleName] = nil
  package.loaded[modulePath] = nil
  rawset(_ENV, moduleName, nil)
end

function ReloadRequirePath(modulePath, quiet)
  if not modulePath or type(modulePath) ~= "string" then
    print("ReloadRequirePath invalid", modulePath)
    return
  end
  local module_paths = GetModulePaths()
  local module_tables = GetModuleTables()
  package.loaded[modulePath] = nil
  for name, path in pairs(module_paths) do
    if path == modulePath then
      module_tables[name] = nil
      rawset(_ENV, name, nil)
      if not quiet then
        print("ReloadRequirePath", modulePath, "global", name)
      end
      return
    end
  end
  if not quiet then
    print("ReloadRequirePath", modulePath, "(no matching global in module_paths)")
  end
end

function ReloadRequirePathMerge(modulePath, quiet)
  if not modulePath or type(modulePath) ~= "string" then
    print("ReloadRequirePathMerge invalid", modulePath)
    return false
  end
  local module_paths = GetModulePaths()
  local module_tables = GetModuleTables()
  local globalName
  for name, path in pairs(module_paths) do
    if path == modulePath then
      globalName = name
      break
    end
  end
  if not globalName then
    ReloadRequirePath(modulePath, quiet)
    return false
  end
  local oldT = module_tables[globalName]
  if type(oldT) ~= "table" then
    ReloadRequirePath(modulePath, quiet)
    return false
  end
  package.loaded[modulePath] = nil
  module_tables[globalName] = nil
  rawset(_ENV, globalName, nil)
  local ok, newM = pcall(require, modulePath)
  if not ok or type(newM) ~= "table" then
    module_tables[globalName] = oldT
    rawset(_ENV, globalName, oldT)
    package.loaded[modulePath] = oldT
    if not quiet then
      print("ReloadRequirePathMerge 失败，已恢复旧模块", modulePath, tostring(newM))
    end
    return false
  end
  for k, v in pairs(newM) do
    if nil ~= v then
      oldT[k] = v
    end
  end
  module_tables[globalName] = oldT
  rawset(_ENV, globalName, oldT)
  package.loaded[modulePath] = oldT
  if type(oldT.InitConfig) == "function" then
    local initOk, initErr = pcall(oldT.InitConfig)
    if not quiet then
      if initOk then
        print("ReloadRequirePathMerge", modulePath, globalName, "(InitConfig called)")
      else
        print("ReloadRequirePathMerge", modulePath, globalName, "(InitConfig failed:", tostring(initErr), ")")
      end
    end
  elseif not quiet then
    print("ReloadRequirePathMerge", modulePath, globalName)
  end
  return true
end

local HotReloadBlacklistPrefixes = {"Managers/"}

local function IsInHotReloadBlacklist(relPath)
  for _, prefix in ipairs(HotReloadBlacklistPrefixes) do
    if relPath:find(prefix, 1, true) then
      return true
    end
  end
  return false
end

function ReloadGameScriptLuaFile(rel, quiet, fullReplace)
  if not rel or type(rel) ~= "string" then
    print("ReloadGameScriptLuaFile invalid", rel)
    return
  end
  local p = rel:gsub("\\", "/")
  p = p:gsub("^LuaClientGit/", "")
  p = p:gsub("^GameScript/", "")
  if IsInHotReloadBlacklist(p) then
    if not quiet then
      print("ReloadGameScriptLuaFile skipped (blacklist):", p)
    end
    return
  end
  p = p:gsub("%.lua$", "")
  local modulePath = "GameScript." .. p:gsub("/", ".")
  if fullReplace then
    ReloadRequirePath(modulePath, quiet)
  else
    ReloadRequirePathMerge(modulePath, quiet)
  end
end

local function GitHotReload_pickGitCwd(projectRoot)
  local Path = CS.System.IO.Path
  local Directory = CS.System.IO.Directory
  local File = CS.System.IO.File
  
  local function hasGit(dir)
    local g = Path.Combine(dir, ".git")
    return Directory.Exists(g) or File.Exists(g)
  end
  
  local luaGit = Path.Combine(projectRoot, "LuaClientGit")
  if hasGit(luaGit) then
    do return tostring end
    return tostring, luaGit
  end
  if hasGit(projectRoot) then
    do return tostring end
    return tostring, projectRoot
  end
  do return tostring end
  return tostring, projectRoot
end

function ReloadGameScriptFilesFromGitSinceHead()
  if not CS.UnityEngine.Application.isEditor then
    return
  end
  local Debug = CS.UnityEngine.Debug
  
  local function gitLog(msg)
    Debug.Log("[GitHotReload] " .. tostring(msg))
  end
  
  local ok, err = xpcall(function()
    local Application = CS.UnityEngine.Application
    local dataPath = tostring(Application.dataPath or "")
    local root = dataPath:gsub("/Assets$", ""):gsub("\\Assets$", "")
    if "" == root or root == dataPath then
      gitLog("无法解析工程根目录 dataPath=" .. dataPath)
      return
    end
    local gitCwd = GitHotReload_pickGitCwd(root)
    local cmd = string.format("git -C \"%s\" diff --name-only HEAD", gitCwd)
    local pipe = io.popen(cmd)
    if not pipe then
      gitLog("io.popen 失败，请确认 git 在 PATH 且可执行: " .. cmd)
      return
    end
    local seen = {}
    local okNames = {}
    local failedNames = {}
    for line in pipe:lines() do
      line = line:gsub("\r", ""):gsub("\\", "/")
      if "" ~= line and line:match("%.lua$") and line:find("GameScript/", 1, true) and not seen[line] then
        seen[line] = true
        local short = line:match("GameScript/(.+)$") or line
        local okOne, errOne = pcall(function()
          ReloadGameScriptLuaFile(line, true)
        end)
        if okOne then
          table.insert(okNames, short)
        else
          table.insert(failedNames, short)
          Debug.LogWarning("[GitHotReload] 跳过热更 " .. short .. ": " .. tostring(errOne))
        end
      end
    end
    pipe:close()
    if 0 == #okNames and 0 == #failedNames then
      gitLog("无 GameScript .lua 变更 (git -C " .. gitCwd .. ")")
    else
      local msg = "已热更 " .. #okNames .. " 个: " .. table.concat(okNames, ", ")
      if #failedNames > 0 then
        msg = msg .. " | 失败 " .. #failedNames .. " 个: " .. table.concat(failedNames, ", ")
      end
      gitLog(msg)
    end
  end, debug.traceback)
  if not ok then
    Debug.LogWarning("[GitHotReload] 执行异常:\n" .. tostring(err))
  end
end

local GetUIResObj = _ENV.GetUIResObj
local gmetatable = {}

function gmetatable.__index(_, key)
  local t = module_tables[key]
  if not t then
    local path = module_paths[key]
    if path then
      t = require(path)
      local tType = type(t)
      if "table" ~= tType and "function" ~= tType then
        module_tables[key] = true
        error("can not find module for path=" .. path)
      else
        module_tables[key] = t
        SetGlobal(key, t)
      end
    else
      local uiRes = GetUIResObj(key)
      if uiRes then
        module_tables[key] = uiRes
        return uiRes
      end
    end
  end
  return t
end

setmetatable(_ENV, gmetatable)
local CodeManager = {}

function CodeManager.Instance()
  if CodeManager.__instance then
    return CodeManager.__instance
  end
  local obj = {}
  setmetatable(obj, {__index = CodeManager})
  obj:ctor()
  CodeManager.__instance = obj
  return obj
end

function CodeManager:ctor()
end

function CodeManager:Enable()
  if CS.UnityEngine.Application.platform ~= CS.UnityEngine.RuntimePlatform.WindowsEditor then
    return
  end
  self:ForbidGlobals(_ENV)
  self:RedirectXPcall()
end

function CodeManager:UpdateLoadLua()
end

local GlobalNamesWhiteList = {
  "GameScript",
  "Share",
  "RecordCsharpError",
  "__reload_all",
  "LuaPanda",
  "cur_node",
  "select_code",
  "_ejoysdk",
  "_ejoysdk_crypt",
  "_ejoysdk_lsocket",
  "raw_require",
  "require",
  "ReloadModule",
  "ReloadRequirePath",
  "ReloadRequirePathMerge",
  "ReloadGameScriptLuaFile",
  "ReloadGameScriptFilesFromGitSinceHead"
}

function CodeManager:ForbidGlobals(env)
  if not getmetatable(env) then
    setmetatable(env, {})
  end
  local envMetaTbl = getmetatable(env)
  
  function envMetaTbl.__newindex(tbl, varName, newValue)
    if table.findvalue(GlobalNamesWhiteList, varName) then
      rawset(tbl, varName, newValue)
      return
    end
    local msg = string.format("ERROR: 不允许新建全局变量 %s = %s", varName, newValue)
    error(msg)
  end
end

function CodeManager:RedirectXPcall()
  local oldXpcall = xpcall
  
  function xpcall(f, msgh, arg1, ...)
    local errorTraceback
    
    local function msgHandle(msg)
      errorTraceback = "[xpcall error]" .. debug.traceback(msg)
      msgh(msg)
    end
    
    local ret = table.pack(oldXpcall(f, msgHandle, arg1, ...))
    if not ret[1] then
      Logger.Error(errorTraceback)
    end
    do return table.unpack end
    return table.unpack, ret, oldXpcall(f, msgHandle, arg1, ...)
  end
  
  local oldResume = coroutine.resume
  
  function coroutine.resume(co, val1, ...)
    local success, msg = oldResume(co, val1, ...)
    if not success then
      local errorTraceback = "[coroutine error]" .. msg
      Logger.Error(errorTraceback)
    end
    return success, msg
  end
end

return CodeManager
