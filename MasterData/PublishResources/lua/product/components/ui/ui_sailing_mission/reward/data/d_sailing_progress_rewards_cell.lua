_class("DSailingProgressRewardsCell", Object)
DSailingProgressRewardsCell = DSailingProgressRewardsCell

function DSailingProgressRewardsCell:Constructor()
end

function DSailingProgressRewardsCell:Refresh(data)
  self._progressNum = 0
  self._cfgID = 0
  self._items = {}
  self._state = 1
  self._isSpecial = false
end

function DSailingProgressRewardsCell:CanReceive()
  return self._state == ECumulativeLoginRewardStatus.E_CUMULATIVE_LOGIN_REWARD_CAN_RECV
end

function DSailingProgressRewardsCell:Unlocked()
  if self._state == ECumulativeLoginRewardStatus.E_CUMULATIVE_LOGIN_REWARD_CAN_RECV or self._state == ECumulativeLoginRewardStatus.E_CUMULATIVE_LOGIN_REWARD_RECVED then
    return true
  end
  return false
end

function DSailingProgressRewardsCell:IsReceived()
  return self._state == ECumulativeLoginRewardStatus.E_CUMULATIVE_LOGIN_REWARD_RECVED
end
