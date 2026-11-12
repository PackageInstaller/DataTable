local ConfigData = require("GameCore.Data.ConfigData")
require("Diagnose")
local tab = {}

function tab.Init(lang)
  tab.SetType(lang)
end

function tab.SetType(lang)
  tab.LanguageType = lang
end

function tab.GetType()
  if tab.LanguageType == nil then
    tab.LanguageType = "zh_CN"
  end
  return tab.LanguageType
end

_G.LanguageTable = tab
