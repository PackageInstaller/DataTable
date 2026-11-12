local PB = require("pb")
local ipairs = _ENV.ipairs
local rawget = _ENV.rawget
local setmetatable = _ENV.setmetatable
local ConfigData = require("GameCore.Data.ConfigData")
local ReadTable = {}

function ReadTable:__index(k)
  local raw = rawget(self, "raw")
  local meta = rawget(self, "meta")
  local lang = meta.lang
  local loaded = meta.loaded
  local pbName = meta.pbName
  local langs = meta.langs
  local line = raw[k]
  if langs ~= nil and lang == nil and not loaded then
    lang = ConfigData.LoadLanguageTable(LanguageTable.GetType(), pbName)
    meta.lang = lang
    meta.loaded = true
  end
  if nil ~= line then
    local lineInstance = assert(PB.decode("nova.client." .. pbName, line))
    if langs ~= nil then
      for _, v in ipairs(langs) do
        local field = lineInstance[v]
        if field ~= nil and lang ~= nil then
          lineInstance[v] = lang[field] or ""
        end
      end
    end
    return lineInstance
  end
end

function LoadDataTable(meta, raw, lang)
  local newTable = {
    raw = raw,
    meta = meta,
    lang = lang
  }
  setmetatable(newTable, ReadTable)
  return newTable
end
