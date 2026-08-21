_class("UIDrawCardPoolInfo", Object)
UIDrawCardPoolInfo = UIDrawCardPoolInfo

function UIDrawCardPoolInfo:Constructor(data, idx)
  self.poolData = data
  self.index = idx
  self.singleMat = nil
  self.singlePrice = nil
  self.singleOriPrice = nil
  self.singleDiscount = 0
  self.multipleMat = nil
  self.multiplePrice = nil
  self.multipleOriPrice = nil
  self.multipleDiscount = 0
  self.freeCount = self.poolData.remain_free_count
  self.nextTimer = self.poolData.next_refresh_free_time
  self.closeTimer = self.poolData.free_campaign_end_time
  self.freeCount_Mul = self.poolData.mul_remain_free_count
  self.nextTimer_Mul = self.poolData.mul_next_refresh_free_time
  self.closeTimer_Mul = self.poolData.mul_free_campaign_end_time
  self._mRole = GameGlobal.GetModule(RoleModule)
  self.singleMat, self.singlePrice, self.singleOriPrice, self.singleDiscount = self:GetOneDrawInfo()
  self._canSingleDraw = self.singleMat ~= nil
  self._canMultipleDraw = true
  if self:IsNovicePool() then
    self._canMultipleDraw = self.poolData.extend_data >= self.poolData.multiple_shake_times
  end
  self.multipleMat, self.multiplePrice, self.multipleOriPrice, self.multipleDiscount = self:GetTenDrawInfo()
end

function UIDrawCardPoolInfo:GetOneDrawInfo()
  local itemM = GameGlobal.GetModule(ItemModule)
  local canUseCoupon = false
  if self.poolData.pre_use_ticket and self.poolData.pre_use_ticket > 0 then
    canUseCoupon = 0 < itemM:GetItemCount(self.poolData.pre_use_ticket)
  end
  if canUseCoupon then
    return self.poolData.pre_use_ticket, 1, 1, nil
  end
  if self.poolData.cost1_id == 0 and self.poolData.cost2_id == 0 then
    Log.exception("严重错误，卡池无材料消耗:", self.poolData.prize_pool_id)
  end
  local mats = {}
  if self:ItemCanOneDraw(self.poolData.cost1_id) then
    mats[#mats + 1] = {
      self.poolData.cost1_id,
      self.poolData.one_shake_price1,
      self.poolData.one_shake_discount1_price
    }
  end
  if self:ItemCanOneDraw(self.poolData.cost2_id) then
    mats[#mats + 1] = {
      self.poolData.cost2_id,
      self.poolData.one_shake_price2,
      self.poolData.one_shake_discount2_price
    }
  end
  if #mats == 0 then
    Log.error("没有可用的单抽材料:", self.poolData.prize_pool_id)
    return
  end
  for idx, data in ipairs(mats) do
    local id = data[1]
    local oriPrice = data[2]
    local discountPrice = data[3]
    local itemID
    local cfg = Cfg.cfg_item[id]
    if id == RoleAssetID.RoleAssetDrawCard100 then
      local item = itemM:GetAvailableLimitDrawcardCoupon(ItemSubType.ItemSubType_TempDrawTicket)
      if item then
        itemID = item:GetTemplateID()
      else
        itemID = RoleAssetID.RoleAssetDrawCard100
      end
    elseif id == RoleAssetID.RoleAssetDrawCard101 then
      local item = itemM:GetAvailableLimitDrawcardCoupon(ItemSubType.ItemSubType_TempSpecialTicket)
      if item then
        itemID = item:GetTemplateID()
      else
        itemID = RoleAssetID.RoleAssetDrawCard101
      end
    else
      itemID = id
    end
    local have = itemM:GetItemCount(itemID)
    local price = oriPrice
    local discount
    if discountPrice and 0 < discountPrice then
      price = discountPrice
      discount = math.ceil((oriPrice - discountPrice) / oriPrice * 100)
    end
    if have >= price then
      return itemID, price, oriPrice, discount
    elseif idx == #mats then
      return itemID, price, oriPrice, discount
    end
  end
end

function UIDrawCardPoolInfo:GetTenDrawInfo()
  local itemM = GameGlobal.GetModule(ItemModule)
  if self.poolData.cost1_id == 0 and self.poolData.cost2_id == 0 then
    Log.exception("严重错误，卡池无材料消耗:", self.poolData.prize_pool_id)
  end
  local mats = {}
  if self:ItemCanTenDraw(self.poolData.cost1_id) then
    mats[#mats + 1] = {
      self.poolData.cost1_id,
      self.poolData.multiple_shake_price1,
      self.poolData.multiple_shake_discount1_price
    }
  end
  if self:ItemCanTenDraw(self.poolData.cost2_id) then
    mats[#mats + 1] = {
      self.poolData.cost2_id,
      self.poolData.multiple_shake_price2,
      self.poolData.multiple_shake_discount2_price
    }
  end
  if #mats == 0 then
    Log.exception("严重错误，没有可用的十连材料:", self.poolData.prize_pool_id)
  end
  for idx, data in ipairs(mats) do
    local id = data[1]
    local oriPrice = data[2]
    local discountPrice = data[3]
    local have = itemM:GetItemCount(id)
    local price = oriPrice
    local discount
    if discountPrice and 0 < discountPrice then
      price = discountPrice
      discount = math.ceil((oriPrice - discountPrice) / oriPrice * 100)
    end
    if have >= price then
      return id, price, oriPrice, discount
    elseif idx == #mats then
      return id, price, oriPrice, discount
    end
  end
end

function UIDrawCardPoolInfo:ItemCanOneDraw(id)
  if id and 0 < id then
    local cfg = Cfg.cfg_item[id]
    return cfg.ItemSubType ~= ItemSubType.ItemSubType_10DrawCardTicket
  end
  return false
end

function UIDrawCardPoolInfo:ItemCanTenDraw(id)
  if id and 0 < id then
    return true
  end
  return false
end

function UIDrawCardPoolInfo:CloseTimer_Single()
  return self.closeTimer
end

function UIDrawCardPoolInfo:NextTimer_Single()
  return self.nextTimer
end

function UIDrawCardPoolInfo:GetFreeCount_Single()
  return self.freeCount
end

function UIDrawCardPoolInfo:CloseTimer_Multi()
  return self.closeTimer_Mul
end

function UIDrawCardPoolInfo:NextTimer_Multi()
  return self.nextTimer_Mul
end

function UIDrawCardPoolInfo:GetFreeCount_Multi()
  return self.freeCount_Mul
end

function UIDrawCardPoolInfo:Get2AssetId()
  return self.poolData.cost1_id, self.poolData.cost2_id
end

function UIDrawCardPoolInfo:GetXBName(isSingle)
  local costMat
  if isSingle then
    costMat = self.singleMat
  else
    costMat = self.multipleMat
  end
  local name = StringTable.Get("str_item_" .. costMat)
  return name
end

function UIDrawCardPoolInfo:IsCostXB(isSingle)
  local costid
  if isSingle then
    costid = self.singleMat
  else
    costid = self.multipleMat
  end
  local isCostXB = costid == RoleAssetID.RoleAssetDrawCard100
  local isCostTZXB = costid == RoleAssetID.RoleAssetDrawCard101
  return isCostXB or isCostTZXB, costid
end

function UIDrawCardPoolInfo:GetPoolViewID()
  return self.poolData.performance_id
end

function UIDrawCardPoolInfo:IsCostGp(isSingle)
  local costid
  if isSingle then
    costid = self.singleMat
  else
    costid = self.multipleMat
  end
  return costid == RoleAssetID.RoleAssetGlow, costid
end

function UIDrawCardPoolInfo:GetAssetsPrice(isSingle)
  if isSingle then
    return self.singleOriPrice, self.singlePrice, self.singleDiscount, self.singleMat
  else
    return self.multipleOriPrice, self.multiplePrice, self.multipleDiscount, self.multipleMat
  end
end

function UIDrawCardPoolInfo:IsXBEnough(cost, isSingle)
  local isCostXB, xbId = self:IsCostXB(isSingle)
  if not isCostXB then
    Log.fatal("### not cost xb.")
    return
  end
  local count = self._mRole:GetAssetCount(xbId)
  local isEnough = cost <= count
  local diff = cost - count
  return isEnough, diff
end

function UIDrawCardPoolInfo:IsGPEnough(cost)
  local count = self._mRole:GetGlow()
  local isEnough = cost <= count
  local diff = cost - count
  return isEnough, diff
end

function UIDrawCardPoolInfo:IsYJEnough(cost)
  local mShop = GameGlobal.GetModule(ShopModule)
  local count, countFree = mShop:GetDiamondCount()
  local total = count
  local isEnough = cost <= total
  local diff = cost - total
  return isEnough, diff
end

function UIDrawCardPoolInfo:HasFreeDraw()
  return self.freeCount > 0 or 0 < self.freeCount_Mul
end

function UIDrawCardPoolInfo:GetTopTips(itemIDs)
  local limitItem = {}
  if self.poolData.cost1_id == RoleAssetID.RoleAssetDrawCard100 or self.poolData.cost2_id == RoleAssetID.RoleAssetDrawCard100 then
    local item = GameGlobal.GetModule(ItemModule):GetAvailableLimitDrawcardCoupon(ItemSubType.ItemSubType_TempDrawTicket)
    if item then
      limitItem[#limitItem + 1] = item:GetTemplateID()
    end
  elseif self.poolData.cost1_id == RoleAssetID.RoleAssetDrawCard101 or self.poolData.cost2_id == RoleAssetID.RoleAssetDrawCard101 then
    local item = GameGlobal.GetModule(ItemModule):GetAvailableLimitDrawcardCoupon(ItemSubType.ItemSubType_TempSpecialTicket)
    if item then
      limitItem[#limitItem + 1] = item:GetTemplateID()
    end
  end
  if 0 < #limitItem then
    for _, id in ipairs(itemIDs) do
      limitItem[#limitItem + 1] = id
    end
    return limitItem
  end
  return itemIDs
end

function UIDrawCardPoolInfo:CanSingleDraw()
  return self._canSingleDraw
end

function UIDrawCardPoolInfo:GetRefreshTime()
  local poolCloseTime, sinFreeRefreshTime, mulFreeRefreshTime, xingBiaoCloseTime
  poolCloseTime = self:GetPoolCloseTime()
  local now = GetSvrTimeNow()
  local sinCloseTime = self:CloseTimer_Single()
  if now <= sinCloseTime then
    local time = self:NextTimer_Single()
    if 0 < time then
      sinFreeRefreshTime = time
    end
  end
  local mulCloseTime = self:CloseTimer_Multi()
  if now <= mulCloseTime then
    local time = self:NextTimer_Multi()
    if 0 < time then
      mulFreeRefreshTime = time
    end
  end
  local itemM = GameGlobal.GetModule(ItemModule)
  local item = itemM:GetAvailableLimitDrawcardCoupon(ItemSubType.ItemSubType_TempDrawTicket)
  item = item or itemM:GetAvailableLimitDrawcardCoupon(ItemSubType.ItemSubType_TempSpecialTicket)
  if item then
    xingBiaoCloseTime = GameGlobal.GetModule(LoginModule):GetTimeStampByTimeStr(item:GetTemplate().CompulsiveDeadTime, Enum_DateTimeZoneType.E_ZoneType_GMT)
  end
  local timeTb = {
    poolCloseTime,
    sinFreeRefreshTime,
    mulFreeRefreshTime,
    xingBiaoCloseTime
  }
  if not next(timeTb) then
    return
  end
  local time = math.maxinteger
  for _, value in pairs(timeTb) do
    if value < time then
      time = value
    end
  end
  return time
end

function UIDrawCardPoolInfo:GetPoolCloseTime()
  if self.poolData.close_type == PrizePoolOpenCloseType.TIME_CONDITON then
    return self.poolData.extend_data
  elseif self.poolData.close_type == PrizePoolOpenCloseType.PLAY_TIMES_CONDITON and self.poolData.close_condition2 > 0 then
    return self.poolData.close_condition2
  end
end

function UIDrawCardPoolInfo:IsNovicePool()
  local closeType = self.poolData.close_type
  local closeType2 = self.poolData.close_condition2
  return closeType == PrizePoolOpenCloseType.PLAY_TIMES_CONDITON and (closeType2 == nil or closeType2 <= 0)
end

function UIDrawCardPoolInfo:CanMultipleDraw()
  return self._canMultipleDraw
end
