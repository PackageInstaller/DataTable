_class("DCampaignShopItemBase", Object)

function DCampaignShopItemBase:Constructor(goodsInfo)
end

function DCampaignShopItemBase:Refresh(goodsInfo, exchangeCmpt)
  self.goodsId = goodsInfo.m_id
  self.isSpecial = goodsInfo.m_is_special
  self.exchangeLimitCount = goodsInfo.m_exchange_limit_count
  self.remainNum = goodsInfo.m_can_exchange_count
  self.costCount = goodsInfo.m_cost_count
  self.costItemId = goodsInfo.m_cost_item_id
  self.unlockCostItems = goodsInfo.m_unlock_cost_item
  self.rewardInfo = {}
  self.rewardInfo.assetid = goodsInfo.m_reward.assetid
  self.rewardInfo.count = goodsInfo.m_reward.count
  self.exchangeCmpt = exchangeCmpt
end

function DCampaignShopItemBase:GetGoodsId()
  return self.goodsId
end

function DCampaignShopItemBase:GetIsSpecial()
  return self.isSpecial
end

function DCampaignShopItemBase:GetRemainCount()
  if self.exchangeLimitCount ~= -1 then
    return self.remainNum
  else
    return -1
  end
end

function DCampaignShopItemBase:GetCostItemId()
  return self.costItemId
end

function DCampaignShopItemBase:GetRemainTotalCount()
  return 1
end

function DCampaignShopItemBase:ShowRemain()
  return self.exchangeLimitCount > 0
end

function DCampaignShopItemBase:GetItemId()
  return self.rewardInfo.assetid
end

function DCampaignShopItemBase:IsPet()
  local itemId = self:GetItemId()
  return Cfg.cfg_pet[itemId] ~= nil
end

function DCampaignShopItemBase:GetItemCount()
  return self.rewardInfo.count
end

function DCampaignShopItemBase:GetSaleType()
  return self.costItemId
end

function DCampaignShopItemBase:GetSalePrice()
  return self.costCount
end

function DCampaignShopItemBase:GetSaleTag()
  return 0
end

function DCampaignShopItemBase:ShowSaleTag()
  return false
end

function DCampaignShopItemBase:IsUnLimit()
  return self.exchangeLimitCount <= 0
end

function DCampaignShopItemBase:UnlockItems()
  return self.unlockCostItems
end

_class("DCampaignShopItemGroup", Object)

function DCampaignShopItemGroup:Constructor()
  self._campaignId = 0
  self._unlockTime = 0
  self._showTime = 0
  self._closeTime = 0
  self._isShow = false
  self._isUnlock = false
  self._isClose = false
end
