local lang = {}
local _configCache = {}
local _langName = {}

function lang:_loadConfig(tname)
  local ret = _configCache[tname]
  if nil ~= ret then
    return ret
  end
  ret = require(tname)
  if ret == nil then
    warnf(tag, "dont has this config: " .. tname)
    return nil
  end
  rawset(ret, "name", tname)
  _configCache[tname] = ret
  return ret
end

function lang:_unloadConfig(tname)
  _configCache[tname] = nil
  package.loaded[tname] = nil
end

function lang:_getConfig(tname, id)
  if id == nil then
    return
  end
  if _langName[tname] == nil then
    local str = string.gsub(tname, "lang_", "", 1)
    _langName[tname] = str
  end
  CS.Azur.Gameplay.Core.Table.TableMgr.CheckLangTableLoaded(_langName[tname], true)
  local c = CS.Azur.Gameplay.Core.Table.TableMgr.GetLangValue(_langName[tname], id)
  if c ~= string.empty then
    return c
  end
end

function lang:_translate(langString)
  if langString == nil then
    return ""
  end
  if type(langString) == "string" then
    return langString
  end
  local group = langString.group
  local langKey = langString.langKey
  if group == nil or langKey == nil then
    return ""
  end
  local translated = self:_getConfig(group, langKey)
  if translated == nil then
    return ""
  end
  if (IS_EDITOR or IS_DEV_BUILD) and self.gm_LTextShowTextKeyToolOpen then
    local shifted_result = langString.langKey >> 32
    local id_num = shifted_result & 4294967295
    local tmp = tostring(langString.langKey)
    if C_LTextShowToolWrapper ~= nil then
      C_LTextShowToolWrapper.AddTmpString(translated, tmp)
    end
    translated = tmp
  end
  return translated
end

function lang:clear()
  for i, _ in pairs(_configCache) do
    self:_unloadConfig(i)
  end
end

function lang:get(langString, paramMap)
  local str = self:_translate(langString)
  if paramMap then
    for k, v in pairs(paramMap) do
      local findStr = "{" .. tostring(k) .. "}"
      local targetStr = string.gsub(v, "%%", "%%%%")
      str = string.gsub(str, findStr, targetStr)
    end
  end
  return str
end

function lang:fmt(str, paramMap)
  if not str or not paramMap then
    return ""
  end
  for k, v in pairs(paramMap) do
    local findStr = "{" .. tostring(k) .. "}"
    local targetStr = string.gsub(v, "%%", "%%%%")
    str = string.gsub(str, findStr, targetStr)
  end
  return str
end

function lang:getFormatLangString(langString, ...)
  return {
    group = langString.group,
    langKey = langString.langKey,
    param = {
      ...
    }
  }
end

function lang:replaceConfigText(group, key, replaceText)
  local tname = string.format("lang_%s", group)
  local ret = _configCache[tname]
  if nil ~= ret then
    local originalMeta = getmetatable(ret)
    if originalMeta then
      local originalNewIndex = originalMeta.__newindex
      
      function originalMeta.__newindex(t, k, v)
        rawset(t, k, v)
      end
      
      ret[key] = replaceText
      originalMeta.__newindex = originalNewIndex
    else
      ret[key] = replaceText
    end
  end
end

return lang
