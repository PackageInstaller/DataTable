local CheckMinHeroStar = {}

function CheckMinHeroStar.LengthCheck(param)
  if 3 <= #param then
    return true
  end
  return false
end

function CheckMinHeroStar.ParamsCheck(param)
  local heroId = param[2]
  local targetStar = param[3]
  local heroData = PlayerDataCenter.heroDic[heroId]
  local heroStar = 0
  if heroData ~= nil then
    heroStar = heroData.star
  end
  local ok = targetStar <= heroStar
  return ok
end

function CheckMinHeroStar.GetUnlockInfo(param)
  local heroId = param[2]
  local targetStar = param[3]
  local hreoName = LanguageUtil.GetLocaleText(ConfigData.hero_data[heroId].name)
  local showStar = targetStar // 2
  if targetStar % 2 == 0 then
    return string.format(ConfigData:GetTipContent(917), hreoName, showStar)
  end
  return string.format(ConfigData:GetTipContent(925), hreoName, showStar)
end

return CheckMinHeroStar
