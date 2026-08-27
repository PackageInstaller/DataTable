local CheckerPlayerLevelUpLimit = {}

function CheckerPlayerLevelUpLimit.LengthCheck(param)
  if 2 <= #param then
    return true
  end
  return false
end

function CheckerPlayerLevelUpLimit.ParamsCheck(param)
  return PlayerDataCenter.playerLevel.level <= param[2]
end

function CheckerPlayerLevelUpLimit.GetUnlockInfo(param)
  return ""
end

return CheckerPlayerLevelUpLimit
