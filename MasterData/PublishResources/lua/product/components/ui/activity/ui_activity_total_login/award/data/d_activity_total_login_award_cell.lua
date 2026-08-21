_class("DActivityTotalLoginAwardCell", Object)

function DActivityTotalLoginAwardCell:Constructor()
end

function DActivityTotalLoginAwardCell:Refresh(data)
  self._dayNum = 0
  self._items = {}
  self._state = 1
  self._isSpecial = false
end

function DActivityTotalLoginAwardCell:GetGoodsId()
  return self.goodsId
end

function DActivityTotalLoginAwardCell:CanReceive()
  return self._state == ECumulativeLoginRewardStatus.E_CUMULATIVE_LOGIN_REWARD_CAN_RECV
end

function DActivityTotalLoginAwardCell:Unlocked()
  if self._state == ECumulativeLoginRewardStatus.E_CUMULATIVE_LOGIN_REWARD_CAN_RECV or self._state == ECumulativeLoginRewardStatus.E_CUMULATIVE_LOGIN_REWARD_RECVED then
    return true
  end
  return false
end
