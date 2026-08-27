local CheckAvg = {}

function CheckAvg.LengthCheck(param)
  if 2 <= #param then
    return true
  end
  return false
end

function CheckAvg.IsCompletedAvg(avgId)
  if avgId == 0 then
    return true
  end
  return ControllerManager:GetController(ControllerTypeId.AvgPlay, true):IsAvgPlayed(avgId)
end

function CheckAvg.ParamsCheck(param)
  local ok = CheckAvg.IsCompletedAvg(param[2])
  return ok
end

function CheckAvg.GetUnlockInfo(param)
  local avgId = param[2]
  local avgCfg = ConfigData.story_avg[avgId]
  if avgCfg ~= nil then
    return string.format(ConfigData:GetTipContent(911), LanguageUtil.GetLocaleText(avgCfg.name))
  end
  return ""
end

return CheckAvg
