_class("StringTable", Singleton)
StringTable = StringTable
local TABLE_CLEAR = table.clear
local STR_LEN = string.len
local STR_GSUB = string.gsub
local STR_GMATCH = string.gmatch
local IS_NULL_OR_EMPTY = string.isnullorempty
local ELanguageType = {
  Unkown = -100,
  ChineseSimplified = 1,
  ChineseTraditional = 2,
  English = 3
}

function StringTable:Constructor()
  self._stringTable = {}
  self._LanguageType = ELanguageType.ChineseSimplified
  self._prefixs = {}
  self.alterStringTable = nil
end

function StringTable.Get(strID, ...)
  local rawStr = StringTable:GetInstance():FindString(strID)
  if GameHelper.IsNull(...) then
    return rawStr
  else
    return StringTable:GetInstance():FindStringWithParams(rawStr, ...)
  end
end

function StringTable.Has(strID)
  local t = StringTable:GetInstance()._stringTable
  if t then
    return t[strID] ~= nil
  end
  return false
end

function StringTable:ClearTable()
  TABLE_CLEAR(self._stringTable)
  if self.alterStringTable then
    TABLE_CLEAR(self.alterStringTable)
  end
  self._prefixs = {}
end

function StringTable:Init()
  local lang_list = Cfg.language_list()
  for key, value in pairs(lang_list) do
    local filename = value.filename
    local keyprefix = value.keyprefix
    if ResourceManager:GetInstance():HasLua(filename) then
      if keyprefix and 0 < #keyprefix then
        Log.debug("language cfg have keyprefix ", filename)
        for i, p in ipairs(keyprefix) do
          if string.len(p) > 1 then
            self._prefixs[p] = {filename = filename, prefixs = keyprefix}
            Log.debug("[stringTable] prefix=", p, " file=", filename)
          end
        end
      else
        local cfgTable = Cfg[filename]()
        for k, v in pairs(cfgTable) do
          self:_AddStringFromConfig(k, v)
        end
      end
    else
      Log.fatal("language cfg missing: ", filename)
    end
  end
end

function StringTable:FindString(strID)
  if IS_NULL_OR_EMPTY(strID) then
    Log.warn("StringTable:FindString, You Should not pass null or empty string to StringTable.Get()")
    return
  end
  local val = self._stringTable[strID]
  if not val then
    local loadtb = {}
    for prefix, tb in pairs(self._prefixs) do
      local filename = tb.filename
      if string.match(strID, prefix .. ".*") then
        Log.debug("StringTable:FindString() strID=", strID, " load file:", filename)
        local cfgTable = Cfg[filename]()
        for k, v in pairs(cfgTable) do
          self:_AddStringFromConfig(k, v)
        end
        loadtb[#loadtb + 1] = tb
      end
    end
    for _, tb in ipairs(loadtb) do
      for i, p in ipairs(tb.prefixs) do
        self._prefixs[p] = nil
      end
    end
    Log.warn("StringTable:FindString, can't find string, id:", strID)
    local err = "ERR:" .. strID
    self:AddString(strID, err, true)
    return self:FindString(strID)
  end
  return val
end

function StringTable:SingularPlurality(rawStr)
  local ttt = {}
  for mstr in STR_GMATCH(rawStr, "({%s*%d+%s*:%s*%a*%s*|%s*%a*%s*})") do
    local digital = string.match(mstr, "{%s*(%d+)")
    local singular = string.match(mstr, ":%s*(%a*)")
    local plurality = string.match(mstr, "|%s*(%a*)")
    ttt[digital] = {
      mstr,
      singular,
      plurality
    }
  end
  return rawStr, ttt
end

local regex = "{%d+}"

function StringTable:FindStringWithParams(rawStr, ...)
  rawStr = STR_GSUB(rawStr, "{{", "{")
  rawStr = STR_GSUB(rawStr, "}}", "}")
  rawStr = STR_GSUB(rawStr, "##", "#")
  local newStr, digTab = self:SingularPlurality(rawStr)
  for match in STR_GMATCH(newStr, regex) do
    local argIndex = string.sub(match, 2, STR_LEN(match) - 1)
    local toReplace = select(argIndex, ...)
    if toReplace then
      if digTab[argIndex] ~= nil then
        if 1 < toReplace then
          newStr = STR_GSUB(newStr, digTab[argIndex][1], digTab[argIndex][3])
        else
          newStr = STR_GSUB(newStr, digTab[argIndex][1], digTab[argIndex][2])
        end
      end
      newStr = STR_GSUB(newStr, match, toReplace)
    else
      Log.fatal("StringTable:FindStringWithParams Error,本地化参数不足:", rawStr)
    end
  end
  return newStr
end

function StringTable:_AddStringFromConfig(key, value, checkDup)
  checkDup = checkDup ~= false
  if checkDup and self._stringTable[key] then
    Log.sys("StringTable:AddStringFromConfig Error, String table conflict,key:", key, ",val:", self._stringTable[key])
  elseif STR_LEN(key) ~= 0 then
    self._stringTable[key] = value
  end
end

function StringTable:_GetLanguageType()
  if self._LanguageType ~= ELanguageType.Unkown then
    return self._LanguageType
  end
  local curLanguage = HelperProxy:GetInstance():GetLanguage()
  if curLanguage == "Chinese" or curLanguage == "ChineseSimplified" then
    self._LanguageType = ELanguageType.ChineseSimplified
  else
    self._LanguageType = ELanguageType.ChineseSimplified
  end
  return self._LanguageType
end

function StringTable:_GetLanguageValue(key, valuesTable)
  local langtype = self:_GetLanguageType()
  if langtype == ELanguageType.ChineseSimplified then
    return valuesTable.des
  elseif langtype == ELanguageType.ChineseTraditional then
    return valuesTable.des_tr
  elseif langtype == ELanguageType.English then
    return valuesTable.des_en
  else
    return valuesTable.des
  end
end

function StringTable:AddString(key, value, checkDup)
  if checkDup and self._stringTable[key] then
    Log.sys("StringTable:AddString Error, String table conflict,key:", key, " val:", self._stringTable[key])
  elseif STR_LEN(key) ~= 0 then
    self._stringTable[key] = value
  end
end

function StringTable.EnumToString(id_str_conf, enum_id, ...)
  local t = type(enum_id)
  local key = enum_id
  if t == "userdata" then
    key = enum_id:ToInt()
  end
  local ret = ""
  if key < 0 and Cfg.str_call_ret[tostring(key)] ~= nil then
    ret = "id:" .. key .. ",des:" .. StringTable:GetInstance():FindStringWithParams(Cfg.str_call_ret[tostring(key)].des, ...)
  elseif id_str_conf[tostring(key)] ~= nil then
    ret = "id:" .. key .. ",des:" .. StringTable:GetInstance():FindStringWithParams(id_str_conf[tostring(key)].des, ...)
  else
    local enum_name = "unknow enum!"
    if id_str_conf.enum_name ~= nil then
      enum_name = id_str_conf.enum_name.des
    end
    local cfg_name = "unknow cfg!"
    if id_str_conf.cfg_name ~= nil then
      cfg_name = id_str_conf.cfg_name.des
    end
    ret = StringTable:GetInstance():FindStringWithParams(Cfg.str_enum2string_common.undefined_id.des, key, enum_name, cfg_name)
  end
  Log.debug("StringTable:EnumToString : ", ret)
  return ret
end
