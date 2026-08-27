local PayGiftInfo = class("PayGiftInfo")
local ShopEnum = require("Game.Shop.ShopEnum")
local CheckerTypeId, _ = table.unpack(require("Game.Common.CheckCondition.CheckerGlobalConfig"))
local eSelfSelectGift = require("Game.PayGift.eSelfSelectGift")
local isSelfSelectChipGiftTable = {
  eSelfSelectGift.type.heroFragWithOutLimit,
  eSelfSelectGift.type.heroFragWithSpecWeapon,
  eSelfSelectGift.type.heroFragSelected,
  eSelfSelectGift.type.heroFragSelectedAndOwned
}

function PayGiftInfo.CreatePayGiftInfo(groupCfg)
  local data = PayGiftInfo.New()
  data.groupCfg = groupCfg
  data.initPreGroupId = data.groupCfg.id
  data.initPreGroupLine = data.groupCfg.line
  if data.groupCfg.pre_group ~= nil and #data.groupCfg.pre_group > 0 then
    data.initPreGroupId = data.groupCfg.pre_group[1]
    data.initPreGroupLine = ConfigData.pay_gift_type[data.initPreGroupId].line
  end
  data.giftCfgList = {}
  for i, v in pairs(data.groupCfg.giftDic) do
    table.insert(data.giftCfgList, v)
  end
  data.times = 0
  data.refreshTime = 0
  data.nextRefreshTime = data.refreshTime
  table.sort(data.giftCfgList, function(a, b)
    if a.limit_type ~= b.limit_type then
      return a.limit_type < b.limit_type
    end
    return a.id < b.id
  end)
  data.defaultCfg = data.giftCfgList[1]
  data.needRefresh = data.defaultCfg.limit_type == ShopEnum.eLimitType.Day or data.defaultCfg.limit_type == ShopEnum.eLimitType.Week or data.defaultCfg.limit_type == ShopEnum.eLimitType.Month or data.defaultCfg.limit_type == ShopEnum.eLimitType.Subscription
  data.isFree = nil
  if data:IsUseItemPay() then
    data.isFree = (data.defaultCfg.cur_price or 0) == 0
  else
    local payCtrl = ControllerManager:GetController(ControllerTypeId.Pay, true)
    _, data.isFree = payCtrl:GetPayPriceInter(data.defaultCfg.payId)
  end
  data.selfSelectGiftIsSelected = false
  data.selfSelectGiftSelectedItemIds = nil
  data.selfSelectGiftSelectedItemNums = nil
  data.selfSelectGiftSelectedParams = nil
  if data:IsSelfSelectGift() then
    data.customGiftCount = #data.defaultCfg.params
    data.customGiftCfg = ConfigData.customized_gift[data.defaultCfg.param]
  end
  return data
end

function PayGiftInfo:IsPeriodicityPayGift()
  return self.defaultCfg.limit_type == ShopEnum.eLimitType.Day or self.defaultCfg.limit_type == ShopEnum.eLimitType.Week or self.defaultCfg.limit_type == ShopEnum.eLimitType.Month
end

function PayGiftInfo:UpdatePayGiftInfo()
  local timepassCtr = ControllerManager:GetController(ControllerTypeId.TimePass, true)
  local counterEl
  for k, v in pairs(self.giftCfgList) do
    local tempCounterEl = timepassCtr:getCounterElemData(proto_object_CounterModule.CounterModuleGiftReset, v.id)
    if tempCounterEl ~= nil and tempCounterEl.nextExpiredTm > PlayerDataCenter.timestamp then
      counterEl = tempCounterEl
      break
    end
  end
  if counterEl ~= nil then
    self.times = counterEl.times
    self.refreshTime = counterEl.nextExpiredTm
    self.nextRefreshTime = self.refreshTime
    self:UpadteNextTime()
  end
end

function PayGiftInfo:IsUnlock()
  return CheckCondition.CheckLua(self.groupCfg.pre_condition, self.groupCfg.pre_para1, self.groupCfg.pre_para2)
end

function PayGiftInfo:GetUnlockParam()
  return self.groupCfg.pre_condition, self.groupCfg.pre_para1, self.groupCfg.pre_para2
end

function PayGiftInfo:IsUnlockTimeCondition()
  for i, preCondition in ipairs(self.groupCfg.pre_condition) do
    if preCondition == CheckerTypeId.TimeRange then
      return true, self.groupCfg.pre_para1[i], self.groupCfg.pre_para2[i]
    elseif preCondition == CheckerTypeId.SectorStagePassTm then
      local ok, outRange, sectorPassTm, realSectorPassTm = PlayerDataCenter.sectorStage:CheckStagePassTmInRange(self.groupCfg.pre_para1[i], self.groupCfg.pre_para2[i])
      if ok and not outRange then
        return true, sectorPassTm, realSectorPassTm
      end
    end
  end
  return false
end

function PayGiftInfo:GetPopGiftType()
  return self.groupCfg.ispop
end

function PayGiftInfo:GeyGiftGroupPopId()
  return self.groupCfg.group_pop
end

function PayGiftInfo:GetPopGiftSortLevel()
  return self.groupCfg.line
end

function PayGiftInfo:GetGiftInWhichShop()
  return self.groupCfg.inShop
end

function PayGiftInfo:IsGiftInfoInShop()
  return self.groupCfg.inShop ~= 0
end

function PayGiftInfo:IsUnlockForAdditionalTimeCondition2()
  return self.endTime ~= nil and self.endTime > PlayerDataCenter.timestamp
end

function PayGiftInfo:IsUnclockPopGift()
  if self.groupCfg.ispop == 0 and self.groupCfg.group_pop == 0 then
    return false
  end
  if not self:IsUnlockForAdditionalTimeCondition2() and not CheckCondition.CheckLua(self.groupCfg.pre_condition2, self.groupCfg.pre_para3, self.groupCfg.pre_para4) then
    return false
  end
  if 0 < self.groupCfg.pop_date then
    local timeData = TimeUtil:TimestampToDate(math.floor(PlayerDataCenter.timestamp))
    return timeData.day & 1 == self.groupCfg.pop_date & 1
  end
  return true
end

function PayGiftInfo:GetPopGiftConditionsAndParas()
  return self.groupCfg.pre_condition2, self.groupCfg.pre_para3, self.groupCfg.pre_para4
end

function PayGiftInfo:IsHeroConditionInGift()
  for i, preCondition in ipairs(self.groupCfg.pre_condition) do
    if preCondition == CheckerTypeId.MinHeroStar then
      return true, self.groupCfg.pre_para1[i], self.groupCfg.pre_para2[i]
    end
  end
  return false
end

function PayGiftInfo:GetParas34ByCondition2Id(conditionId)
  for i = 1, #self.groupCfg.pre_condition2 do
    if self.groupCfg.pre_condition2[i] == conditionId then
      return self.groupCfg.pre_para3[i], self.groupCfg.pre_para4[i]
    end
  end
end

function PayGiftInfo:IsLinearGift()
  if self.groupCfg.pre_group ~= nil and #self.groupCfg.pre_group > 0 then
    return true
  end
  if self.groupCfg.afterGroup ~= nil and 0 < table.count(self.groupCfg.afterGroup) then
    return true
  end
  return false
end

function PayGiftInfo:IsSoldOut()
  if self.defaultCfg.limit_type == ShopEnum.eLimitType.None then
    return false
  end
  if self.defaultCfg.limit_type == ShopEnum.eLimitType.Eternal or self.defaultCfg.limit_type == ShopEnum.eLimitType.EternalSubscription then
    return self.times >= self.defaultCfg.times
  end
  return self.refreshTime > PlayerDataCenter.timestamp and self.times >= self.defaultCfg.times
end

function PayGiftInfo:IsEternalAndSoldOut()
  if self.defaultCfg.limit_type == ShopEnum.eLimitType.Eternal or self.defaultCfg.limit_type == ShopEnum.eLimitType.EternalSubscription then
    return self:IsSoldOut()
  end
  return false
end

function PayGiftInfo:GetLimitBuyCount()
  local isLimitBuy = self.defaultCfg.limit_type ~= ShopEnum.eLimitType.None
  local times = self.times
  if isLimitBuy and PlayerDataCenter.timestamp > self.refreshTime then
    times = 0
  end
  return isLimitBuy, times, self.defaultCfg.times
end

function PayGiftInfo:GetPayGiftNextTime()
  if not self:NeedRefreshTime() then
    return -1
  end
  if self.nextRefreshTime > PlayerDataCenter.timestamp then
    return self.nextRefreshTime
  else
    self:UpadteNextTime()
    return self.nextRefreshTime
  end
end

function PayGiftInfo:NeedRefreshTime()
  if self.needRefresh then
    if self.defaultCfg.limit_type == ShopEnum.eLimitType.Subscription then
      return self.nextRefreshTime > PlayerDataCenter.timestamp
    end
    return true
  end
  return false
end

function PayGiftInfo:IsUseItemPay()
  return self.defaultCfg.pay_type == 2
end

function PayGiftInfo:UpadteNextTime()
  if self.nextRefreshTime >= PlayerDataCenter.timestamp then
    return
  end
  local time = TimeUtil:TimestampToDate(math.floor(TimeUtil:TimpApplyLogicOffset(PlayerDataCenter.timestamp)))
  if self.defaultCfg.limit_type == ShopEnum.eLimitType.Day then
    time.hour = 0
    time.min = 0
    time.sec = 0
    self.nextRefreshTime = TimeUtil:DateToTimestamp(time) + 86400 + 3600 * TimeUtil:GetDayPassTime()
  elseif self.defaultCfg.limit_type == ShopEnum.eLimitType.Week or self.defaultCfg.limit_type == ShopEnum.eLimitType.Subscription then
    local wday = time.wday
    wday = wday - 1
    if wday == 0 then
      wday = 7
    end
    local dayCount = 8 - wday
    time.hour = 0
    time.min = 0
    time.sec = 0
    self.nextRefreshTime = TimeUtil:DateToTimestamp(time) + 86400 * dayCount + 3600 * TimeUtil:GetDayPassTime()
  elseif self.defaultCfg.limit_type == ShopEnum.eLimitType.Month then
    time.day = 1
    time.hour = 0
    time.min = 0
    time.sec = 0
    if time.month == 12 then
      time.month = 1
      time.year = time.year + 1
    else
      time.month = time.month + 1
    end
    self.nextRefreshTime = TimeUtil:DateToTimestamp(time) + 3600 * TimeUtil:GetDayPassTime()
  end
end

function PayGiftInfo:TryGetGiftSubscriptionCfg()
  for _, giftCfg in ipairs(self.giftCfgList) do
    if giftCfg.limit_type == ShopEnum.eLimitType.Subscription or giftCfg.limit_type == ShopEnum.eLimitType.EternalSubscription or self:IsOrderOfManyTypeGift() then
      return true, giftCfg, giftCfg.param
    end
    if self:IsCheckNextGift() then
      return true, giftCfg, 0
    end
  end
  return false, nil, 0
end

function PayGiftInfo:TryGetGiftRaffleCfg()
  for _, giftCfg in ipairs(self.giftCfgList) do
    if giftCfg.type == ShopEnum.eGiftType.raffle then
      return true, giftCfg
    end
  end
  return false, nil
end

function PayGiftInfo:IsNewGiftInShop()
  if not self.groupCfg.is_new then
    return false
  end
  local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  local isNotNew = saveUserData:GetNewPayGiftItemIsNotNew(self.groupCfg.id)
  if not isNotNew and not self:IsSoldOut() then
    return true
  end
  return false
end

function PayGiftInfo:SetNewGiftLooked()
  if not self.groupCfg.is_new then
    return
  end
  local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  local isNotNew = saveUserData:SetNewGiftItemIsNotNew(self.groupCfg.id, true)
end

function PayGiftInfo:IsSelfSelectChipGift()
  for _, giftCfg in ipairs(self.giftCfgList) do
    if giftCfg.type == ShopEnum.eGiftType.select and table.contain(isSelfSelectChipGiftTable, ConfigData.customized_gift[giftCfg.param].type) then
      return true
    end
  end
  return false
end

function PayGiftInfo:IsCheckNextGift()
  for _, giftCfg in ipairs(self.giftCfgList) do
    if giftCfg.type == ShopEnum.eGiftType.checkNextGift then
      return true
    end
  end
  return false
end

function PayGiftInfo:IsOrderOfManyTypeGift()
  for _, giftCfg in ipairs(self.giftCfgList) do
    if giftCfg.type == ShopEnum.eGiftType.orderOfManyType then
      return true
    end
  end
  return false
end

function PayGiftInfo:IsSelfSelectHeroGift()
  for _, giftCfg in ipairs(self.giftCfgList) do
    if giftCfg.type == ShopEnum.eGiftType.select and giftCfg.type == eSelfSelectGift.type.heroCard then
      return true
    end
  end
  return false
end

function PayGiftInfo:IsSelfSelectGift()
  for _, giftCfg in ipairs(self.giftCfgList) do
    if giftCfg.type == ShopEnum.eGiftType.select then
      return true
    end
  end
  return false
end

function PayGiftInfo:IsFreeGift()
  for _, giftCfg in ipairs(self.giftCfgList) do
    if giftCfg.cur_price == 0 then
      return true
    end
  end
  return false
end

function PayGiftInfo:CleanSelfSelectInfo()
  self.selfSelectGiftIsSelected = false
  self.selfSelectGiftSelectedItemIds = nil
  self.selfSelectGiftSelectedItemNums = nil
  self.selfSelectGiftSelectedParams = nil
end

function PayGiftInfo:SetSelfSelectInfo(showItemIds, showItemNums, params)
  if not self:IsSelfSelectGift() then
    return
  end
  self.selfSelectGiftSelectedItemIds = showItemIds
  self.selfSelectGiftSelectedItemNums = showItemNums
  self.selfSelectGiftSelectedParams = params
  self.selfSelectGiftIsSelected = #params >= self.customGiftCount
end

function PayGiftInfo:GetSelfSelectGiftIsSelected()
  return self.selfSelectGiftIsSelected
end

function PayGiftInfo:GetSelfSelectGiftParams()
  return self.selfSelectGiftSelectedParams
end

function PayGiftInfo:GetSelectGiftCustomCfg()
  return self.customGiftCfg
end

function PayGiftInfo:GetSelectGiftCustomCount()
  return self.customGiftCount
end

function PayGiftInfo:TryGetPayGiftOldPrice()
  local showOldPrice = self.defaultCfg.cur_price ~= self.defaultCfg.old_price and not Consts.GameChannelType.IsTw()
  local oldPrice = self.defaultCfg.old_price
  if not self:IsUseItemPay() and LanguageUtil.LanguageInt == eLanguageType.EN_US then
    oldPrice = FormatNum(oldPrice / 100)
  end
  return showOldPrice, oldPrice
end

function PayGiftInfo:GetPayGiftRewards()
  local itemids = {}
  local itemnums = {}
  table.insertto(itemids, self.defaultCfg.awardIds)
  table.insertto(itemnums, self.defaultCfg.awardCounts)
  if self.selfSelectGiftSelectedItemIds ~= nil then
    table.insertto(itemids, self.selfSelectGiftSelectedItemIds)
    table.insertto(itemnums, self.selfSelectGiftSelectedItemNums)
  end
  return itemids, itemnums
end

function PayGiftInfo:GetPayGiftTagValue()
  if Consts.GameChannelType.IsInland() then
    return self.groupCfg.tagValue / 10
  else
    return self.groupCfg.tagValue
  end
end

return PayGiftInfo
