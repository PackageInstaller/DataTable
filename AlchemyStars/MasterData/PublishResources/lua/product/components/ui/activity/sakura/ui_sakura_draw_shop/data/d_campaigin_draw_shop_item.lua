_class("DCampaignDrawShopItem", Object)

function DCampaignDrawShopItem:Constructor(goodsInfo)
end

function DCampaignDrawShopItem:Refresh(goodsInfo, component)
  self.award_id = goodsInfo.m_award_id
  self.item_id = goodsInfo.m_item_id
  self.item_count = goodsInfo.m_count
  self.remain_num = goodsInfo.m_lottery_count
  self.lottery_limit_count = goodsInfo.m_lottery_limit_count
  self.is_big_reward = goodsInfo.m_is_big_reward
  self.lotteryCmpt = component
end

function DCampaignDrawShopItem:GetRestNum()
  return self.remain_num
end

function DCampaignDrawShopItem:GetTotalNum()
  return self.lottery_limit_count
end

function DCampaignDrawShopItem:GetItemId()
  return self.item_id
end

function DCampaignDrawShopItem:GetItemCount()
  return self.item_count
end

function DCampaignDrawShopItem:IsBigReward()
  return self.is_big_reward
end

_class("DCampaignDrawShopItemBox", Object)
DCampaignDrawShopItemBox = DCampaignDrawShopItemBox

function DCampaignDrawShopItemBox:Constructor(goodsInfoList)
end

function DCampaignDrawShopItemBox:Refresh(goodsInfoList, component)
  self.lotteryCmpt = component
  self.itemGroup = {}
  local boxItemLimit = 3
  local rowCellData = {}
  local curItemCountInRowCell = 0
  self:Sort(goodsInfoList)
  for index, value in ipairs(goodsInfoList) do
    local shopItem = DCampaignDrawShopItem:New()
    shopItem:Refresh(value, component)
    curItemCountInRowCell = curItemCountInRowCell + 1
    table.insert(rowCellData, shopItem)
    if curItemCountInRowCell == boxItemLimit or index == #goodsInfoList then
      table.insert(self.itemGroup, rowCellData)
      rowCellData = {}
      curItemCountInRowCell = 0
    end
  end
end

function DCampaignDrawShopItemBox:Sort(goodsInfoList)
  table.sort(goodsInfoList, function(a, b)
    local ra = 1
    local rb = 1
    if a.m_lottery_count == 0 then
      ra = 0
    end
    if b.m_lottery_count == 0 then
      rb = 0
    end
    if ra ~= rb then
      return ra > rb
    end
    return a.m_award_id < b.m_award_id
  end)
end

function DCampaignDrawShopItemBox:GetTotalRestItem()
  local rest = 0
  local total = 0
  for index, value in ipairs(self.itemGroup) do
    for cellIndex, cellData in ipairs(value) do
      rest = rest + cellData:GetRestNum()
      total = total + cellData:GetTotalNum()
    end
  end
  return rest, total
end

function DCampaignDrawShopItemBox:SortBig(goodsInfoList)
  table.sort(goodsInfoList, function(a, b)
    local ra = 1
    local rb = 1
    if a.m_is_big_reward or b.m_is_big_reward then
      if a.m_is_big_reward then
        return true
      else
        return false
      end
    end
    if a.m_lottery_count == 0 then
      ra = 0
    end
    if b.m_lottery_count == 0 then
      rb = 0
    end
    if ra ~= rb then
      return ra > rb
    end
    return a.m_award_id < b.m_award_id
  end)
end

function DCampaignDrawShopItemBox:SortByRewardType(goodsInfoList)
  table.sort(goodsInfoList, function(a, b)
    local ac = a.m_lottery_count ~= 0
    local bc = b.m_lottery_count ~= 0
    if ac ~= bc then
      return ac
    end
    if a.m_reward_type ~= b.m_reward_type then
      return a.m_reward_type > b.m_reward_type
    end
    return a.m_award_id < b.m_award_id
  end)
end

_class("DCampaignDrawShopDrawResultRecord", Object)
DCampaignDrawShopDrawResultRecord = DCampaignDrawShopDrawResultRecord

function DCampaignDrawShopDrawResultRecord:Constructor()
end

function DCampaignDrawShopDrawResultRecord:Record(getRewards, lotteryType, curBoxHasRest, isOpenNew, canDrawOnceMore)
  self.m_getRewards = getRewards
  self.m_lotteryType = lotteryType
  self.m_curBoxHasRest = curBoxHasRest
  self.m_isOpenNew = isOpenNew
  self.m_canDrawOnceMore = canDrawOnceMore
end
