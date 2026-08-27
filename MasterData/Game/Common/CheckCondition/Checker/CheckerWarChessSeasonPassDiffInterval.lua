local CheckerWarChessSeasonPassDiffInterval = {}

function CheckerWarChessSeasonPassDiffInterval.LengthCheck(param)
  if 3 <= #param then
    return true
  end
  return false
end

function CheckerWarChessSeasonPassDiffInterval.ParamsCheck(param)
  local seasonId = param[2]
  local diffIdMin = param[3] // 1000
  local diffIdMax = param[3] % 1000
  if diffIdMin > diffIdMax then
    if isGameDev then
      error("maxDiff < minDiff error,minDiffId:" .. tostring(diffIdMin) .. ",maxDiffId:" .. tostring(diffIdMax))
    end
    return false
  end
  local wcsPassedData = WarChessSeasonManager:GetWCSPassedTower()
  local sPassedData = wcsPassedData[seasonId]
  if sPassedData == nil then
    return false
  end
  local passedMap = sPassedData.difficultyRecord
  if passedMap == nil then
    return false
  end
  for i = diffIdMin, diffIdMax do
    if passedMap[i] then
      return true
    end
  end
  return false
end

function CheckerWarChessSeasonPassDiffInterval.GetUnlockInfo(param)
  return ""
end

return CheckerWarChessSeasonPassDiffInterval
