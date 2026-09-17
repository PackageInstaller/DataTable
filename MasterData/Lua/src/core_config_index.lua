local config = {}
local tag = "config"
local _configHash = {}
local _configHashNew = {}
local _langHash = {}
local _input = Unity.Input
local _endfix = "_shell"
local _configRecycleTimeMap = {}
local _unusedConfigCheck = {}
local _const_lowDevice_recycleTime = 60
local _const_highDevice_recycleTime = 300
G_BaseConfig = require("baseConfig")
G_ConfigParser = require("configParser")
G_ConfigConst = require("configConst")
G_TableMgrIns = CS.Azur.Gameplay.Core.Table.TableMgr.Instance
G_Tables = CS.Azur.Gameplay.Table
local base = {}

function base.__index(table, key)
  local keyIndex = rawget(table, key)
  if not keyIndex then
    warnf(tag, " Can't find " .. tostring(key) .. " from " .. rawget(table, "name"))
    return nil
  end
  return keyIndex
end

function base.__newindex(table)
  warnf(tag, "Can't insert value in " .. rawget(table, "name"))
end

base.__metatable = false
local isReviewVersion = CS.Azur.VersionCheck.VersionCheckHelper.GetGamePackageVersionType() == CS.Azur.VersionCheck.EVersionType.LineReview

function config._configCacheManage()
  local recycleConfigs = {}
  for k, v in pairs(_configRecycleTimeMap) do
    if 0 < v then
      _configRecycleTimeMap[k] = v - 1
      if _configRecycleTimeMap[k] <= 0 then
        table.insert(recycleConfigs, k)
      end
    end
  end
  if not table.isEmpty(recycleConfigs) then
    for i = 1, #recycleConfigs do
      local name = recycleConfigs[i]
      local cfg = _configHashNew[name]
      if cfg and cfg.clearCache then
        cfg:clearCache()
      end
      _configRecycleTimeMap[name] = nil
    end
  end
end

local configManageTimer = Timer.repeated(1, config._configCacheManage)

function config:_resetConfigTime(name)
  if string.isEmpty(name) then
    return
  end
  if _configRecycleTimeMap[name] == nil then
    _configRecycleTimeMap[name] = {}
  end
  _configRecycleTimeMap[name] = self:_getConfigRecycleTime()
end

function config:_getConfigRecycleTime()
  if self.recycleTime then
    return self.recycleTime
  end
  local isLow = C_DeviceGradeHelper.IsLowMemoryDevice()
  self.recycleTime = isLow and _const_lowDevice_recycleTime or _const_highDevice_recycleTime
  return self.recycleTime
end

function config:_loadConfig(tname)
  local ret = _configHash[tname]
  if ret then
    return ret
  end
  local success, result = pcall(require, tname)
  if success then
    ret = result
    if ret == nil then
      errorf("return value of this lua is nil: " .. tname)
      return nil
    end
    rawset(ret, "name", tname)
    _configHash[tname] = ret
    return ret
  else
    errorf(tostring(result))
    return nil
  end
end

function config:getConfig(tname, id, key, isLang)
  return self:getConfigNew(tname, id, key, isLang)
end

function config:getConfigNew(tname, id, key, isLang)
  if string.isEmpty(tname) then
    return
  end
  local oriTname = tname
  local normalName = oriTname .. _endfix
  local c = self:_loadConfigNew(normalName)
  if c == nil then
    return nil
  end
  self:_resetConfigTime(tname)
  if id == nil then
    return c
  end
  local tpl = L_GameTpl:getTplByCfgName(tname)
  if tpl == nil or tpl.data == nil then
    return
  end
  local val
  if key == nil then
    val = tpl.data[id]
  else
    local item = tpl.data[id]
    if item == nil then
      val = nil
    else
      val = item[key]
    end
  end
  if val ~= nil and isLang and self.localizationProvider then
    val = self.localizationProvider(val)
  end
  return val
end

function config:getConfigDirectly(tname, id, key, isLang)
  if string.isEmpty(tname) then
    return
  end
  local c = L_GameTpl:_getConfig(tname)
  if c == nil then
    return nil
  end
  self:_resetConfigTime(tname)
  if id == nil then
    return c
  end
  local val
  if key == nil then
    val = c[id]
  else
    local item = c[id]
    if item == nil then
      val = nil
    else
      val = item[key]
    end
  end
  if val ~= nil and isLang and self.localizationProvider then
    val = self.localizationProvider(val)
  end
  return val
end

function config:_loadConfigNew(tname)
  local ret = _configHashNew[tname]
  if ret then
    return ret
  end
  if _unusedConfigCheck == nil then
    _unusedConfigCheck = {}
  end
  if _unusedConfigCheck[tname] then
    return
  end
  local success, result = pcall(require, tname)
  if not success then
    printf("[ConfigError]" .. " <color=yellow>[" .. tostring(tname) .. "]</color> 加载失败")
    _unusedConfigCheck[tname] = true
    return
  end
  result = result.new(tname)
  ret = result
  if ret == nil then
    errorf("return value of this lua is nil: " .. tname)
    return nil
  end
  _configHashNew[tname] = ret
  return ret
end

function config:unloadConfig(tname)
  _configHash[tname] = nil
  unrequire(_folder .. tname)
end

function config:setLocalizationProvider(provider)
  assert(type(provider) == "function", "provider should be a function")
  self.localizationProvider = provider
end

function config:provider(val, paras)
  return self.localizationProvider(val, paras)
end

function config:providerLua(val, paras)
  local paramList = {}
  if type(paras) == "table" then
    local index = 0
    for _, value in ipairs(paras) do
      paramList[index] = value
      index = index + 1
    end
  else
    paramList[0] = paras
  end
  local str = self:provider(val, paramList)
  return str
end

function config:getPathByHash(path)
  return path
end

function config:getPath(tname, id, key, index)
  local hash = self:getConfig(tname, id, key)
  if hash == nil then
    return nil
  end
  if index ~= nil then
    hash = hash[index]
  end
  return self:getPathByHash(hash)
end

function config:unloadAllConfigs()
  for k, v in pairs(_configHash) do
    unrequire(_folder .. k)
  end
  _configHash = {}
end

return config
