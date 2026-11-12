local warn_color_tag = "<color=#FFFF00>"
local error_color_tag = "<color=#FF0000>"
local end_color_tag = "</color>"
local table_tag = "<color=#00FF00><b>☀️策划数据表☀️</b></color>"
local cache = {}

local function ClearCache()
  cache = {}
end

local function ClearTableCache(name)
  if name == nil then
    traceback("获取策划数据表数据时, name 参数不能为空！！！")
    return
  end
  cache[name] = {}
end

local function GetTable(name, post_warn)
  if name == nil then
    traceback("获取策划数据表数据时, name 参数不能为空！！！")
    return
  end
  local tb = _G.DataTable[name]
  if tb == nil then
    if post_warn == true then
      printWarn(table_tag .. " [" .. warn_color_tag .. name .. end_color_tag .. "] 不存在！！！")
    else
      traceback(table_tag .. " [" .. error_color_tag .. name .. end_color_tag .. "] 不存在！！！")
    end
    return
  end
  if cache[name] == nil then
    cache[name] = {}
  end
  return tb
end

local function GetTableData(name, key, post_warn)
  if key == nil then
    traceback("获取策划数据表数据时, key 参数不能为空！！！")
    return
  end
  local tb = GetTable(name, post_warn)
  if tb == nil then
    return
  end
  local cacheTb = cache[name]
  local line = cacheTb[key]
  if line ~= nil then
    return line
  end
  line = tb[key]
  if line == nil then
    if post_warn == true then
      printWarn(table_tag .. " [" .. warn_color_tag .. name .. end_color_tag .. "] 中没找到 Id = [" .. warn_color_tag .. key .. end_color_tag .. "] 的数据行！！！")
    else
      traceback(table_tag .. " [" .. error_color_tag .. name .. end_color_tag .. "] 中没找到 Id = [" .. error_color_tag .. key .. end_color_tag .. "] 的数据行！！！")
    end
    return
  end
  cacheTb[key] = line
  return line
end

local function GetTableField(name, key, field, post_warn)
  local line = GetTableData(name, key, post_warn)
  if line == nil then
    return
  end
  if field == nil then
    traceback("获取策划数据表数据时, field 参数不能为空！！！")
    return
  end
  local field_obj = line[field]
  if field_obj == nil then
    if post_warn == true then
      printWarn(table_tag .. " [" .. warn_color_tag .. name .. end_color_tag .. "] 中 Id = [" .. warn_color_tag .. key .. end_color_tag .. "] 的数据行中没找到字段 [" .. warn_color_tag .. field .. end_color_tag .. "] ！！！")
    else
      traceback(table_tag .. " [" .. error_color_tag .. name .. end_color_tag .. "] 中 Id = [" .. error_color_tag .. key .. end_color_tag .. "] 的数据行中没找到字段 [" .. error_color_tag .. field .. end_color_tag .. "] ！！！")
    end
  end
  return field_obj
end

local function GetUITextData(key, post_warn)
  return GetTableField("UIText", key, "Text", post_warn) or ""
end

local configCache = {}

local function GetTableConfigData(key, post_warn)
  if key == nil then
    traceback("获取策划数据表数据时, key 参数不能为空！！！")
    return
  end
  local data = configCache[key]
  if data ~= nil then
    return data
  end
  data = GetTableField("Config", key, "Value", post_warn)
  if data == nil then
    return
  end
  configCache[key] = data
  return data
end

local function GetTableConfigNumber(key, post_warn)
  if key == nil then
    traceback("获取策划数据表数据时, key 参数不能为空！！！")
    return
  end
  local data = configCache[key]
  if data ~= nil then
    return data
  end
  data = GetTableField("Config", key, "Value", post_warn)
  if data == nil then
    return
  end
  local num = tonumber(data)
  if num == nil then
    if post_warn == true then
      printWarn(table_tag .. " [" .. warn_color_tag .. "Config" .. end_color_tag .. "] 中 Id = [" .. warn_color_tag .. key .. end_color_tag .. "] 的数据行中的字段 [" .. warn_color_tag .. "Value" .. end_color_tag .. "] 不是数字！！！")
    else
      traceback(table_tag .. " [" .. error_color_tag .. "Config" .. end_color_tag .. "] 中 Id = [" .. error_color_tag .. key .. end_color_tag .. "] 的数据行中的字段 [" .. error_color_tag .. "Value" .. end_color_tag .. "] 不是数字！！！")
    end
    return
  end
  configCache[key] = num
  return num
end

local function GetTableConfigArray(key, post_warn)
  if key == nil then
    traceback("获取策划数据表数据时, key 参数不能为空！！！")
    return
  end
  local data = configCache[key]
  if data ~= nil then
    return data
  end
  data = GetTableField("Config", key, "Value", post_warn)
  if data == nil then
    return
  end
  local arr = string.split(data, ",")
  configCache[key] = arr
  return arr
end

local function GetTableConfigNumberArray(key, post_warn)
  if key == nil then
    traceback("获取策划数据表数据时, key 参数不能为空！！！")
    return
  end
  local data = configCache[key]
  if data ~= nil then
    return data
  end
  data = GetTableField("Config", key, "Value", post_warn)
  if data == nil then
    return
  end
  local arr = string.split(data, ",") or {}
  if #arr == 0 then
    configCache[key] = {}
    return {}
  end
  local res = {}
  for _, v in ipairs(arr) do
    local num = tonumber(v)
    if num == nil then
      if post_warn == true then
        printWarn(table_tag .. " [" .. warn_color_tag .. "Config" .. end_color_tag .. "] 中 Id = [" .. warn_color_tag .. key .. end_color_tag .. "] 的数据行中的字段 [" .. warn_color_tag .. "Value" .. end_color_tag .. "] 不是数字数组！！！")
      else
        traceback(table_tag .. " [" .. error_color_tag .. "Config" .. end_color_tag .. "] 中 Id = [" .. error_color_tag .. key .. end_color_tag .. "] 的数据行中的字段 [" .. error_color_tag .. "Value" .. end_color_tag .. "] 不是数字数组！！！")
      end
      return res
    end
    table.insert(res, num)
  end
  configCache[key] = res
  return res
end

local function GetTableData_Character(key, post_warn)
  return GetTableData("Character", key, post_warn)
end

local function GetTableData_Skill(key, post_warn)
  return GetTableData("Skill", key, post_warn)
end

local function GetTableData_Item(key, post_warn)
  return GetTableData("Item", key, post_warn)
end

local function GetTableData_World(key, post_warn)
  return GetTableData("World", key, post_warn)
end

local function GetTableData_HitDamage(key, post_warn)
  return GetTableData("HitDamage", key, post_warn)
end

local function GetTableData_Attribute(key, post_warn)
  return GetTableData("Attribute", key, post_warn)
end

local function GetTableData_Buff(key, post_warn)
  return GetTableData("Buff", key, post_warn)
end

local function GetTableData_Effect(key, post_warn)
  return GetTableData("Effect", key, post_warn)
end

local function GetTableData_Mainline(key, post_warn)
  return GetTableData("Mainline", key, post_warn)
end

local function GetTableData_Perk(key, post_warn)
  return GetTableData("Perk", key, post_warn)
end

local function GetTableData_Story(key, post_warn)
  return GetTableData("Story", key, post_warn)
end

local function GetTableData_CharacterSkin(key, post_warn)
  return GetTableData("CharacterSkin", key, post_warn)
end

local function GetTableData_Trap(key, post_warn)
  return GetTableData("Trap", key, post_warn)
end

_G.ConfigTable = {
  ClearCache = ClearCache,
  ClearTableCache = ClearTableCache,
  Get = GetTable,
  GetData = GetTableData,
  GetField = GetTableField,
  GetUIText = GetUITextData,
  GetConfigValue = GetTableConfigData,
  GetConfigNumber = GetTableConfigNumber,
  GetConfigArray = GetTableConfigArray,
  GetConfigNumberArray = GetTableConfigNumberArray,
  GetData_Character = GetTableData_Character,
  GetData_Skill = GetTableData_Skill,
  GetData_Item = GetTableData_Item,
  GetData_World = GetTableData_World,
  GetData_HitDamage = GetTableData_HitDamage,
  GetData_Attribute = GetTableData_Attribute,
  GetData_Buff = GetTableData_Buff,
  GetData_Effect = GetTableData_Effect,
  GetData_Mainline = GetTableData_Mainline,
  GetData_Perk = GetTableData_Perk,
  GetData_Story = GetTableData_Story,
  GetData_CharacterSkin = GetTableData_CharacterSkin,
  GetData_Trap = GetTableData_Trap
}
