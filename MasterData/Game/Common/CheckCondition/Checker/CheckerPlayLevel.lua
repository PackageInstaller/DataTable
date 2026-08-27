local CheckerPlayLevel = {}

function CheckerPlayLevel.LengthCheck(param)
  if 2 <= #param then
    return true
  end
  return false
end

function CheckerPlayLevel.ParamsCheck(param)
  return PlayerDataCenter.playerLevel.level >= param[2]
end

function CheckerPlayLevel.GetUnlockInfo(param)
  local playerLevel = param[2]
  return string.format(ConfigData:GetTipContent(913), playerLevel)
end

return CheckerPlayLevel
