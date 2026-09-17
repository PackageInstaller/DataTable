local configParser = {}
local numberDef = "number"
local stringDef = "string"
local boolDef = "bool"
local langSuffix = "lang_"

function configParser.ParseJson(str)
  if not string.isEmpty(str) then
    L_Json.decode(str)
  end
end

function configParser.ParseConfigStr(data, type, param1, param2)
  local ret = ""
  if type == G_ConfigConst.ParseType.list then
    ret = configParser.parse_list(data, "|", param1)
  elseif type == G_ConfigConst.ParseType.dictionary then
    ret = configParser.parse_dict(data, "|", "#", param1, param2)
  elseif type == G_ConfigConst.ParseType.compositeList then
    ret = configParser.parse_listlist(data, "|", "#", param1)
  elseif type == G_ConfigConst.ParseType.resourceStr then
    ret = configParser.parse_resource_str(data, param1)
  elseif type == G_ConfigConst.ParseType.resourceListStr then
    ret = configParser.parseResouceListStr(data)
  elseif type == G_ConfigConst.ParseType.langstring then
    ret = configParser.parseLangString(data, param1)
  elseif type == G_ConfigConst.ParseType.listLangstring then
    ret = configParser.parseListLangString(data, param1)
  elseif type == G_ConfigConst.ParseType.listCondition then
    ret = configParser.parse_listlist(data, "|", "#", numberDef)
  else
    ret = configParser.autoParse(data)
  end
  return ret
end

local function split(str, sep)
  if not str or str == "" then
    return {}
  end
  if not sep or sep == "" then
    return {str}
  end
  local result = {}
  local pattern = string.format("[^%s]+", sep)
  for match in string.gmatch(str, pattern) do
    table.insert(result, match)
  end
  return result
end

local function getDefaultValue(exceptType)
  if exceptType then
    if exceptType == numberDef then
      return 0
    elseif exceptType == stringDef then
      return ""
    elseif exceptType == boolDef then
      return false
    end
  end
end

local function convert_type(value, exceptType)
  if value == nil then
    return getDefaultValue(exceptType)
  end
  if string.isEmpty(exceptType) then
    return value
  end
  if exceptType == numberDef then
    return tonumber(value) or 0
  elseif exceptType == stringDef then
    return tostring(value) or ""
  elseif exceptType == boolDef then
    local lower = string.lower(value)
    if lower == "true" then
      return true
    end
    if lower == "false" then
      return false
    end
  end
  return value
end

local function splitPathString(str, delimiter, type)
  if not str or str == "" then
    return {}
  end
  delimiter = delimiter or "|"
  local result = {}
  local start = 1
  local delimiterLen = #delimiter
  local strLen = #str
  local defaultVal = getDefaultValue(type)
  if string.match(str, "^" .. delimiter .. "*$") then
    for i = 1, #str + 1 do
      result[i] = defaultVal
    end
    return result
  end
  while true do
    local pos = string.find(str, delimiter, start, true)
    if not pos then
      local lastPart = string.sub(str, start)
      table.insert(result, lastPart == "" and defaultVal or convert_type(lastPart, type))
      break
    end
    local part = string.sub(str, start, pos - 1)
    table.insert(result, part == "" and defaultVal or convert_type(part, type))
    start = pos + delimiterLen
    if strLen < start then
      table.insert(result, defaultVal)
      break
    end
  end
  return result
end

function configParser.parse_resource_str(str, param)
  if string.isEmpty(str) then
    if param then
      if param <= 1 then
        return ""
      else
        local ret = {}
        for i = 1, param do
          ret[i] = ""
        end
        return ret
      end
    else
      return ""
    end
  end
  if not string.find(str, ",") then
    if string.find(str, "|") then
      return configParser.parse_list(str, "|", stringDef)
    end
    return str
  end
  return configParser.parse_list(str, ",", stringDef)
end

function configParser.parse_list(str, sep, type)
  if string.isEmpty(str) then
    return {}
  end
  sep = sep or "|"
  return splitPathString(str, sep, type)
end

function configParser.parse_dict(str, pair_sep, kv_sep, kType, vType)
  if string.isEmpty(str) then
    return {}
  end
  pair_sep = pair_sep or "|"
  kv_sep = kv_sep or "#"
  local pairs = split(str, pair_sep)
  local result = {}
  for _, pair in ipairs(pairs) do
    local kv = split(pair, kv_sep)
    if 1 <= #kv then
      local key = convert_type(kv[1], kType)
      local value = convert_type(kv[2], vType)
      if key ~= "REF!" then
        result[key] = value
      end
    end
  end
  return result
end

function configParser.parse_listlist(str, outer_sep, inner_sep, type)
  if string.isEmpty(str) then
    return {}
  end
  outer_sep = outer_sep or "|"
  inner_sep = inner_sep or "#"
  local outer_items = split(str, outer_sep)
  local result = {}
  for i, outer_item in ipairs(outer_items) do
    local inner_items = split(outer_item, inner_sep)
    local inner_list = {}
    for j, inner_item in ipairs(inner_items) do
      inner_list[j] = convert_type(inner_item, type)
    end
    result[i] = inner_list
  end
  return result
end

function configParser.parseResouceListStr(str)
  if string.isEmpty(str) then
    return {}
  end
  local outer_sep = "|"
  local inner_sep = ","
  local outer_items = splitPathString(str, outer_sep, stringDef)
  local result = {}
  for i, outer_item in ipairs(outer_items) do
    local inner_items = splitPathString(outer_item, inner_sep, stringDef)
    local inner_list = {}
    if #inner_items == 0 then
      inner_list = ""
    elseif #inner_items == 1 then
      inner_list = inner_items[1]
    else
      for j, inner_item in ipairs(inner_items) do
        inner_list[j] = convert_type(inner_item, stringDef)
      end
    end
    result[i] = inner_list
  end
  return result
end

function configParser.parseLangString(langStr, tblName)
  if not L_CommonUtil.isValid(langStr) then
    return tblName
  end
  if string.isEmpty(langStr) then
    return tblName
  end
  return {
    group = langSuffix .. tostring(langStr.group),
    langKey = langStr.langKey
  }
end

function configParser.parseListLangString(strList, tblName)
  if not L_CommonUtil.isValid(strList) then
    return {}
  end
  local ret = {}
  local enumrator = strList:GetEnumerator()
  while enumrator:MoveNext() do
    local langStrItem = enumrator.Current
    if L_CommonUtil.isValid(langStrItem) then
      local ins = {
        group = langSuffix .. tostring(langStrItem.group),
        langKey = langStrItem.langKey
      }
      table.insert(ret, ins)
    end
  end
  return ret
end

function configParser.autoParse(str)
  if string.find(str, "|") then
    if string.find(str, "#") then
      return configParser.parse_listlist(str, options.outer_sep, options.inner_sep)
    else
      return configParser.parse_list(str, options.pair_sep, options.kv_sep, stringDef)
    end
  else
    return str
  end
end

return configParser
