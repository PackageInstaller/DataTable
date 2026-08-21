_class("UIHauteCoutureDrawPrizeItemBase", UICustomWidget)
UIHauteCoutureDrawPrizeItemBase = UIHauteCoutureDrawPrizeItemBase

function UIHauteCoutureDrawPrizeItemBase:Constructor()
  self._coinNum = 0
  self._itemId = 0
  self._itemCount = 0
  self._assetList = {}
  self._data = nil
  self._specail = nil
  self.clickCb = nil
end

function UIHauteCoutureDrawPrizeItemBase:SetData(prizeSortOrder, componentId, specail, ctx, replaced)
  self._data = Cfg.cfg_component_senior_skin_weight({ComponentID = componentId, RewardSortOrder = prizeSortOrder})[1]
  if replaced then
    self._itemId = self._data.ReplaceRewardID
    self._itemCount = self._data.ReplaceRewardCount
  else
    self._itemId = self._data.RewardID
    self._itemCount = self._data.RewardCount
  end
  self._coinNum = self._data.AppendGlow
  self._specail = specail
  self._replaced = replaced
  self._ctx = ctx
  self._componentId = componentId
  self:_InsertReward()
  self:_OnValue()
end

function UIHauteCoutureDrawPrizeItemBase:SetClickCb(cb)
  self.clickCb = cb
end

function UIHauteCoutureDrawPrizeItemBase:_OnValue()
end

function UIHauteCoutureDrawPrizeItemBase:GetPrizeId()
  return self._itemId
end

function UIHauteCoutureDrawPrizeItemBase:GetCfgID()
  return self._data.ID
end

function UIHauteCoutureDrawPrizeItemBase:_InsertReward()
  local reward = RoleAsset:New()
  if self._replaced then
    reward.assetid = self._data.ReplaceRewardID
    reward.count = self._data.ReplaceRewardCount
  else
    reward.assetid = self._data.RewardID
    reward.count = self._data.RewardCount
  end
  table.insert(self._assetList, reward)
  if self._data.AppendGlow and self._data.AppendGlow > 0 then
    local rewardCoin = RoleAsset:New()
    rewardCoin.assetid = RoleAssetID.RoleAssetGlow
    rewardCoin.count = self._data.AppendGlow
    table.insert(self._assetList, rewardCoin)
  end
end

function UIHauteCoutureDrawPrizeItemBase:IsSpecailPrize()
  return self._specail
end

function UIHauteCoutureDrawPrizeItemBase:IsHauteCouture()
  return self._itemId > RoleAssetID.RoleAssetPetSkinBegin and self._itemId < RoleAssetID.RoleAssetPetSkinEnd
end
