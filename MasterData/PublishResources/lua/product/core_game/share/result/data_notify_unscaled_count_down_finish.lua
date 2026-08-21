_class("DataUnscaledCountDownFinish", Object)
DataUnscaledCountDownFinish = DataUnscaledCountDownFinish

function DataUnscaledCountDownFinish:Constructor(flagID)
  self._flagID = flagID
end

function DataUnscaledCountDownFinish:GetFlagID()
  return self._flagID
end
