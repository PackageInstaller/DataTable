local HeroInfoTextUtil = class("HeroInfoTextUtil")
local CS_LanguageGlobal = CS.LanguageGlobal
HeroInfoTextUtil.textCfgDic = nil

function HeroInfoTextUtil.GetArchiveText(heroId, textKey)
  local heroCfg = ConfigData.hero_data[heroId]
  if heroCfg == nil then
    error("Cant get hero_data, heroId = " .. tostring(heroId))
    return
  end
  local resCfg = ConfigData.resource_model[heroCfg.src_id]
  if resCfg == nil then
    error("resource model Cfg is null,id:" .. tostring(heroCfg.src_id))
    return
  end
  if HeroInfoTextUtil.textCfgDic == nil then
    HeroInfoTextUtil.textCfgDic = {}
  end
  local textCfg = HeroInfoTextUtil.textCfgDic[heroId]
  if textCfg == nil then
    local lang = CS_LanguageGlobal.GetLanguageStr()
    local langPath = "CharacterTextConfig." .. resCfg.res_Name .. "_" .. lang
    local ok, err = pcall(function()
      textCfg = require(langPath)
      textCfg.cfgPath = langPath
      return true
    end)
    if not ok then
      error("Can't get textCfg, path = " .. langPath .. ",\n" .. err)
      return
    end
    HeroInfoTextUtil.textCfgDic[heroId] = textCfg
  end
  local text = textCfg[textKey]
  if string.IsNullOrEmpty(text) then
    error("Can't get Language, heroId = " .. tostring(heroId) .. ", textKey = " .. tostring(textKey))
    return
  end
  return text
end

function HeroInfoTextUtil.RemoveArchiveText(heroId)
  local textCfg = HeroInfoTextUtil.textCfgDic[heroId]
  if textCfg ~= nil then
    package.loaded[textCfg.cfgPath] = nil
    HeroInfoTextUtil.textCfgDic[heroId] = nil
    collectgarbage()
  end
end

function HeroInfoTextUtil.RemoveAllArchiveText()
  if HeroInfoTextUtil.textCfgDic ~= nil then
    for k, textCfg in pairs(HeroInfoTextUtil.textCfgDic) do
      package.loaded[textCfg.cfgPath] = nil
    end
  end
  HeroInfoTextUtil.textCfgDic = nil
  collectgarbage()
end

function HeroInfoTextUtil.Delete()
  HeroInfoTextUtil.RemoveAllArchiveText()
end

return HeroInfoTextUtil
