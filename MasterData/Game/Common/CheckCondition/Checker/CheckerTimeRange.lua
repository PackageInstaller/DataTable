local CheckerTimeRange = {}

function CheckerTimeRange.LengthCheck(param)
  if 3 <= #param then
    return true
  end
  return false
end

function CheckerTimeRange.TimeInRange(startTime, endTime)
  local startOk, endOk = false, false
  if startTime == -1 or math.floor(startTime) == 4294967295 then
    startOk = true
  else
    startOk = startTime <= PlayerDataCenter.timestamp
  end
  if endTime == -1 or math.floor(endTime) == 4294967295 then
    endOk = true
  else
    endOk = endTime >= PlayerDataCenter.timestamp
  end
  return startOk and endOk
end

function CheckerTimeRange.ParamsCheck(param)
  local ok = CheckerTimeRange.TimeInRange(param[2], param[3])
  return ok
end

function CheckerTimeRange.GetUnlockInfo(param)
  local startTime = param[2]
  if startTime == -1 then
    return ""
  end
  local endTime = param[3]
  if endTime ~= -1 and endTime <= PlayerDataCenter.timestamp then
    return ConfigData:GetTipContent(802)
  end
  return os.date(ConfigData:GetTipContent(921), startTime)
end

return CheckerTimeRange
