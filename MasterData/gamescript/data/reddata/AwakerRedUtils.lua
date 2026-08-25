local AwakerBreakThrough = CommonDefine.AwakerBreakThrough
local AwakerRedUtils = {}

function AwakerRedUtils.GetBreakthroughPreviewRed(awaker, star)
  local recvState = AwakerDataUtils.GetBreakthroughRewardReceiveState(awaker, star)
  return recvState == AwakerBreakThrough.RewardAvailable
end

function AwakerRedUtils.GetAllBreakthroughPreviewRed(awakerTid)
  if not awakerTid then
    return false
  end
  local awaker = AwakerDataUtils.GetAwakerData(awakerTid)
  local maxStar = AwakerDataUtils.GetMaxBreakthroughLevel(awakerTid)
  for star = 1, maxStar do
    if AwakerRedUtils.GetBreakthroughPreviewRed(awaker, star) then
      return true
    end
  end
  return false
end

function AwakerRedUtils.GetBreakthroughRedData(awakerTid)
  local hasRed = AwakerRedUtils.GetAllBreakthroughPreviewRed(awakerTid) and 1 or 0
  return {red = hasRed}
end

return AwakerRedUtils
