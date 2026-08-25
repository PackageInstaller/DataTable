local isUseLuaBundle = CS.Z1Client.LuaBehaviour.UseBundleLua()
local isEditor = CS.UnityEngine.Application.isEditor
local M = {}
local mt = {}

local function GetConfigModulePath(key)
  local path
  if not isUseLuaBundle or isEditor then
    path = "Config.Config." .. key
  elseif "KeyShortName" == key then
    path = "Config_Debug." .. key
  else
    path = "Config." .. key
  end
  return path
end

local caseInsensitiveConfigs = {WordsEffectConfig = true}

local function ApplyCaseInsensitiveIndex(config)
  local lowerKeyMap = {}
  for k in pairs(config) do
    if type(k) == "string" then
      lowerKeyMap[string.lower(k)] = k
    end
  end
  local cfgMt = getmetatable(config)
  local oldIndex = cfgMt and cfgMt.__index
  
  function cfgMt.__index(t, k)
    local v
    if type(oldIndex) == "function" then
      v = oldIndex(t, k)
    elseif oldIndex then
      v = oldIndex[k]
    end
    if nil == v and type(k) == "string" then
      local originalKey = lowerKeyMap[string.lower(k)]
      if originalKey and originalKey ~= k then
        if type(oldIndex) == "function" then
          v = oldIndex(t, originalKey)
        elseif oldIndex then
          v = oldIndex[originalKey]
        end
      end
    end
    return v
  end
end

function mt.__index(t, k)
  if mt[k] then
    return mt[k]
  end
  local configPath = GetConfigModulePath(k)
  local config = require(configPath)
  assert(config, "Cant Find Configt " .. k)
  rawset(t, k, config)
  local mkt = getmetatable(config)
  if mkt then
    mkt.__name = k
  end
  if caseInsensitiveConfigs[k] then
    ApplyCaseInsensitiveIndex(config)
  end
  return config
end

setmetatable(M, mt)

function mt.IsLoaded(key)
  local path = GetConfigModulePath(key)
  return package.loaded[path] ~= nil
end

function mt.GetConstant(key, defaultVal)
  local cfg = M.Constant[key]
  local v
  if cfg then
    v = cfg.Data and cfg.Data[1]
  end
  if nil == v then
    return defaultVal
  else
    return v
  end
end

function mt.GetOriginalConstant(key, defaultVal)
  local cfg = M.Constant[key]
  if not cfg then
    return defaultVal
  end
  local data = cfg.Data
  if nil ~= data then
    return data
  end
  return defaultVal
end

function mt.clear()
  table.clear(M)
end

function mt.ReloadConfig()
  for key, _ in pairs(M) do
    local path = GetConfigModulePath(key)
    if package.loaded[path] then
      package.loaded[path] = nil
      rawset(M, key, nil)
    end
  end
end

function mt.GetPortraitCenter(key)
  if not key then
    return nil
  end
  local data = M.PortraitCenter[key]
  if data then
    return data
  end
  if ApplicationUtils.is_debug_mode() then
    return M.PortraitCenterTest[key]
  end
  return nil
end

return M
