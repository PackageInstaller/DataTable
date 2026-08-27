local CheckerHeroLevel = {}

function CheckerHeroLevel.LengthCheck(param)
  return 3 <= #param
end

function CheckerHeroLevel.ParamsCheck(param)
  local heroId = param[2]
  local level = param[3]
  local heroData = PlayerDataCenter.heroDic[heroId]
  if heroData == nil then
    return false
  end
  return level <= heroData.level
end

function CheckerHeroLevel.GetUnlockInfo(param)
  local heroId = param[2]
  local level = param[3]
  local heroName = LanguageUtil.GetLocaleText(ConfigData.hero_data[heroId].name)
  return string.format(ConfigData:GetTipContent(923), heroName, level)
end

return CheckerHeroLevel
