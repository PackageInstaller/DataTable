local RapidJson = require("rapidjson")
local GameTableDefine = require("Game.CodeGen.GAME_TABLE_DEFINE")
local ClientManager = CS.ClientManager.Instance
require("GameCore.Data.ConfigTable")
require("GameCore.Data.CacheTable")
local ConfigData = {IntFloatPrecision = 1.0E-4}

local function PreProcess()
end

function ConfigData.Load(sLanguage)
  NovaAPI.LoadAllDataTable(sLanguage)
  require("GameCore.Data.LanguageTable")
  LanguageTable.Init(sLanguage)
  if NovaAPI.IsBinFormatEnabled() then
    require("GameCore.Data.GameBinTable")
    LoadGameBinTable(sLanguage)
  else
    require("GameCore.Data.GameJsonTable")
    LoadGameJsonTable(sLanguage)
  end
  PreProcess()
  printLog("Config data loaded.")
end

function ConfigData.Unload()
  NovaAPI.UnLoadAllDataTable()
  printLog("Config data unload.")
end

local function GenLanguageTable(jsonArray)
  if jsonArray ~= nil and type(jsonArray) == "table" then
    local jsonObject = {}
    for _, v in ipairs(jsonArray) do
      local id = v.Key
      jsonObject[id] = v.Value
    end
    return jsonObject
  end
  return nil
end

local function ConvertKeyTable(jsonArray)
  if jsonArray ~= nil and type(jsonArray) == "table" and jsonArray.list ~= nil and type(jsonArray.list) == "table" then
    local jsonObject = {}
    for i, v in ipairs(jsonArray.list) do
      local id = v.Id
      jsonObject[id] = v
    end
    return jsonObject
  end
  return nil
end

local function ConvertNoKeyTable(jsonArray)
  if jsonArray ~= nil and type(jsonArray) == "table" and jsonArray.list ~= nil and type(jsonArray.list) == "table" then
    local jsonObject = {}
    for i, v in ipairs(jsonArray.list) do
      jsonObject[i] = v
    end
    return jsonObject
  end
  return nil
end

local function HandleLanguage(jsonArray, sLanguage, tableName, langDefine)
  if langDefine == nil then
    return
  end
  local languageTab = ConfigData.LoadLanguageTable(sLanguage, tableName)
  if jsonArray ~= nil and type(jsonArray) == "table" and jsonArray.list ~= nil and type(jsonArray.list) == "table" then
    for _, v in ipairs(jsonArray.list) do
      for _, d in ipairs(langDefine) do
        local lang = v[d]
        if lang ~= nil then
          v[d] = languageTab[lang] or ""
        end
      end
    end
  end
end

function ConfigData.LoadLanguageTable(lang, tableName)
  local jsonText = NovaAPI.LoadTableData("language/" .. lang .. "/" .. tableName .. ".json") or ""
  local tab = RapidJson.decode(jsonText) or {}
  return tab
end

function ConfigData.LoadCommonJsonTable(tableName, define, sLanguage)
  local jsonText = NovaAPI.LoadTableData("json/" .. tableName .. ".json") or ""
  local tab = RapidJson.decode(jsonText)
  local lang = define.Lang
  if NovaAPI.IsLQA() then
    lang = nil
  end
  HandleLanguage(tab, sLanguage, tableName, lang)
  local tab1
  if define.Key then
    tab1 = ConvertKeyTable(tab)
  else
    tab1 = ConvertNoKeyTable(tab)
  end
  return tab1
end

function ConfigData.LoadCommonBinTable(tableName, define, sLanguage)
  local tab = {}
  NovaAPI.LoadCommonBinData("bin/" .. tableName .. ".bytes", tab)
  local langs = define.Lang
  if NovaAPI.IsLQA() then
    langs = nil
  end
  local lang
  local loaded = false
  if not ClientManager:GetMemoryType() and langs ~= nil then
    lang = ConfigData.LoadLanguageTable(sLanguage, tableName)
    loaded = true
  end
  local meta = {
    pbName = tableName,
    langs = langs,
    lang = lang,
    loaded = loaded
  }
  local tab1 = LoadDataTable(meta, tab)
  return tab1
end

return ConfigData
