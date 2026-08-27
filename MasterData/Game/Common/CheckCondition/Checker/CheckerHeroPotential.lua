local CheckerHeroPotential = {}

function CheckerHeroPotential.LengthCheck(param)
  return 3 <= #param
end

function CheckerHeroPotential.ParamsCheck(param)
  local heroId = param[2]
  local potential = param[3]
  local heroData = PlayerDataCenter.heroDic[heroId]
  if heroData == nil then
    return false
  end
  return potential <= heroData:GetHeroPotential()
end

function CheckerHeroPotential.GetUnlockInfo(param)
  local heroId = param[2]
  local potential = param[3]
  local heroName = LanguageUtil.GetLocaleText(ConfigData.hero_data[heroId].name)
  return string.format(ConfigData:GetTipContent(922), heroName, potential)
end

return CheckerHeroPotential
