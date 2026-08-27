local CherkerFriendshipLevel = {}

function CherkerFriendshipLevel.LengthCheck(param)
  if 3 <= #param then
    return true
  end
  return false
end

function CherkerFriendshipLevel.HeroFriendShipLevel(heroId, friendshipLevel)
  local level = PlayerDataCenter.allFriendshipData:GetLevel(heroId)
  if friendshipLevel <= level then
    return true
  end
  return false
end

function CherkerFriendshipLevel.ParamsCheck(param)
  local ok = CherkerFriendshipLevel.HeroFriendShipLevel(param[2], param[3])
  return ok
end

function CherkerFriendshipLevel.GetUnlockInfo(param)
  local heroId = param[2]
  local friendshipLevel = param[3]
  local hreoName = LanguageUtil.GetLocaleText(ConfigData.hero_data[heroId].name)
  return string.format(ConfigData:GetTipContent(918), hreoName, friendshipLevel)
end

return CherkerFriendshipLevel
