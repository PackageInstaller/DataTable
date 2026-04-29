local UIActivityN21CCShopRewardStatus = {
  UnComplete = 1,
  HasGet = 2,
  UnGet = 3
}
_enum("UIActivityN21CCShopRewardStatus", UIActivityN21CCShopRewardStatus)
_class("UIActivityN21CCShopItemData", Object)
UIActivityN21CCShopItemData = UIActivityN21CCShopItemData

function UIActivityN21CCShopItemData:Constructor(progress, status, rewards, progressComponent)
  self._progressComponent = progressComponent
  self._progress = progress
  self._status = status
  self._rewards = rewards
end

function UIActivityN21CCShopItemData:GetProgressComponent()
  return self._progressComponent
end

function UIActivityN21CCShopItemData:GetProgress()
  return self._progress
end

function UIActivityN21CCShopItemData:GetStatus()
  return self._status
end

function UIActivityN21CCShopItemData:SetStatus(status)
  self._status = status
end

function UIActivityN21CCShopItemData:GetRewards()
  return self._rewards
end

function UIActivityN21CCShopItemData:GetPriority()
  local priority = self._progress
  local weight = 1000000
  if self._status == UIActivityN21CCShopRewardStatus.UnComplete then
    priority = priority + 2 * weight
  elseif self._status == UIActivityN21CCShopRewardStatus.HasGet then
    priority = priority + 3 * weight
  elseif self._status == UIActivityN21CCShopRewardStatus.UnGet then
    priority = priority + weight
  end
  return priority
end
