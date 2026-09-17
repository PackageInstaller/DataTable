local this = class("moneyShopManager")
require("ui.manager.moneyShop.moneyShopConst")
local _shopTpl = L_GameTpl:getShopTpl()
local _shopGroupTpl = L_GameTpl:getShopGroupTpl()
local _goodsTpl = L_GameTpl:getGoodsTpl()
local _goodsPurchaseTpl = L_GameTpl:getGoodsPurchaseTpl()
local _commonItemTpl = L_GameTpl:getCommonItemTpl()
local linkShopGroupID = {
  purchase = {shopGroupId = 900, shopId = 9000},
  freeCurr = {shopGroupId = 900, shopId = 9000}
}

function this:ctor()
  self.detaTime = nil
  self.serverTime = 0
  self.productList = {}
  self._handledGoodConf = {}
end

function this:getShopLinkData(type)
  return linkShopGroupID[type]
end

function this:getShopGoodsData(shopId, goodsId)
  if goodsId == nil then
    return nil
  end
  local shopData = _shopTpl:getTplById(shopId)
  if shopData == nil then
    errorf("商店" .. shopId .. "没有配")
    return {}
  end
  local goodList = _shopTpl:getGoodsList(shopData)
  local purchaseList = _shopTpl:getGoodsListPurchase(shopData)
  if self:checkArrayHasElement(goodList, goodsId) then
    return self:getShopgoodsIdData(goodsId)
  end
  if self:checkArrayHasElement(purchaseList, goodsId) then
    return self:getShoopGoodsPurchaseData(goodsId)
  end
  return self:getShopgoodsIdData(goodsId)
end

function this:getShopgoodsIdData(goodsId)
  local result = self._handledGoodConf[goodsId]
  if not result then
    result = {}
    local tpl = _goodsTpl:getTplById(goodsId)
    if tpl == nil then
      errorf("good没有配" .. goodsId)
      return nil
    end
    local item = _goodsPurchaseTpl:getItem(tpl)
    result.goodsId = goodsId
    result.itemType = item[1][1]
    result.itemId = item[1][2]
    result.currencyId = _goodsTpl:getCurrencyId(tpl)
    result.currency = _goodsTpl:getCurrencyNum(tpl)
    result.currencyType = _goodsTpl:getCurrencyType(tpl)
    result.recommend = _goodsTpl:getRecommend(tpl)
    result.goodsName = _goodsTpl:getGoodsName(tpl)
    result.icon = _goodsTpl:getIcon(tpl)
    result.itemCount = item[1][3]
    result.isCashGoods = false
    result.commonCondition = _goodsTpl:getCommonCondition(tpl)
    result.isSoldOutMask = _goodsTpl:getIsDelete(tpl)
    result.endTime = _goodsTpl:getEndTime(tpl)
    result.refreshType = _goodsTpl:getRefreshType(tpl)
    result.refreshParam = _goodsTpl:getRefreshTypeParam(tpl)
  end
  self._handledGoodConf[goodsId] = result
  return result
end

function this:getShoopGoodsPurchaseData(goodsId)
  local result = self._handledGoodConf[goodsId]
  if not result then
    result = {}
    local tpl = _goodsPurchaseTpl:getTplById(goodsId)
    if tpl == nil then
      errorf("goodsPurchase没有配" .. goodsId)
      return nil
    end
    local item = _goodsPurchaseTpl:getItem(tpl)
    result.goodsId = goodsId
    result.itemType = item[1][1]
    result.itemId = item[1][2]
    result.currencyId = L_Const.currencyType.trueCash
    result.currency = _goodsPurchaseTpl:getCostNum(tpl)
    result.currencyType = L_Const.resType.currency
    result.recommend = _goodsPurchaseTpl:getRecommend(tpl)
    result.goodsName = _goodsPurchaseTpl:getGoodsName(tpl)
    result.icon = _goodsPurchaseTpl:getIcon(tpl)
    result.itemCount = item[1][3]
    result.isCashGoods = true
    result.commonCondition = _goodsPurchaseTpl:getCommonCondition(tpl)
    result.isSoldOutMask = _goodsPurchaseTpl:getIsDelete(tpl)
    result.endTime = _goodsPurchaseTpl:getEndTime(tpl)
    result.refreshType = _goodsPurchaseTpl:getRefreshType(tpl)
    result.refreshParam = _goodsPurchaseTpl:getRefreshTypeParam(tpl)
  end
  self._handledGoodConf[goodsId] = result
  return result
end

function this:checkArrayHasElement(arrayList, element)
  if arrayList == nil then
    return false
  end
  for _, v in ipairs(arrayList) do
    if element == v then
      return true
    end
  end
  return false
end

function this:buyShopGoodsList(slotId, goodsId, shopId, isCashGoods)
  self:openBuyItemGoodsItemTips(slotId, goodsId, shopId, "pageCommonShopBuyTip", isCashGoods)
end

function this:buyGiftGoodsList(slotId, goodsId, shopId, isCashGoods)
  self:openBuyItemGoodsItemTips(slotId, goodsId, shopId, "pageCommonShopGiftTip", isCashGoods)
end

function this:buyMoneyProduct(slotId, goodsId, shopId, isCashGoods)
  local paramData = {}
  paramData.slot_id = slotId
  paramData.sign = L_MoneyShopStore:getEndTime(shopId)
  paramData.times = 1
  L_GameUtil.showCommonTip({
    txtTitle = L_WordsTpl:getValue("residual_code_moneyshopmanager_01"),
    txtContent = L_WordsTpl:getValue("residual_code_moneyshopmanager_02"),
    confirmCallback = function()
      if isCashGoods then
        L_MoneyShopStore:req_purchaseCashItem(paramData, goodsId)
      else
        self:purchaseShopItem(paramData, goodsId)
      end
    end
  })
end

function this:openBuyItemGoodsItemTips(slotId, goodsId, shopId, openPageName, isCashGoods)
  local paramData = {}
  paramData.slot_id = slotId
  paramData.sign = L_MoneyShopStore:getEndTime(shopId)
  local options = {
    goodsId = goodsId,
    shopId = shopId,
    slotId = slotId,
    title = L_WordsTpl:getValue("ui_moneyshop_goodsbuytitle"),
    okFunc = function(buyCount)
      paramData.times = buyCount
      if isCashGoods then
        L_MoneyShopStore:req_purchaseCashItem(paramData, goodsId)
      else
        self:purchaseShopItem(paramData, goodsId)
      end
    end
  }
  L_UI:open(openPageName, options)
end

function this:purchaseShopItem(paramData, goodsId)
  L_MoneyShopStore:req_purchaseShopItem(paramData, function(itemList, errorCode, srcId)
    if errorCode == L_Const.errorCode.ErrCodeShopOldVersion then
      local data_tip = {
        txtContent = L_WordsTpl:getValue("ui_moneyshop_goodsisrefresh")
      }
      L_GameUtil.showCommonTip(data_tip)
    elseif errorCode ~= nil and 0 <= errorCode then
      local errorCodeTpl = L_GameTpl:getErrorCodeTpl()
      local tpl = errorCodeTpl:getTplById(errorCode)
      L_FlyMsgManager:showNormalMsg(errorCodeTpl:getName(tpl, nil, errorCode))
    end
    if not table.isEmpty(itemList) then
      itemList.forceShow = true
      L_RewardManager:showPage(itemList, srcId)
    end
  end)
end

function this:getShopIsSoldOutForGoodsID(shopId, goodsId)
  local slotId = L_MoneyShopStore:getSlotIdForGoodsId(shopId, goodsId)
  if slotId == nil then
    return false
  end
  return self:getShopIsSoldOut(shopId, slotId)
end

function this:getShopIsSoldOut(shopId, slotId)
  return L_MoneyShopStore:getIsSoulOut(shopId, slotId)
end

function this:shopListGoodsMSData(shopId)
  local sortList = L_MoneyShopStore:getGoodsList(shopId)
  self:shopListGoodsRefresh(sortList, shopId)
end

function this:shopListGoodsRefresh(list, shopId)
  if list == nil then
    return
  end
  local sortList = list
  self.serverTime = L_TimeUtil.getServerTime()
  for _, v in pairs(sortList) do
    local deadTime = v.deadTime
    if 0 < deadTime and deadTime < self.serverTime then
      v.deadTime = self:getNextRefreshTime(shopId, v.goodsId, deadTime)
      v.buyTimes = 0
    end
  end
end

function this:getNextRefreshTime(shopId, goodsId, deadTime)
  local dataCell = self:getShopGoodsData(shopId, goodsId)
  local addTime = 0
  if dataCell.refreshType == L_MRShopConst.refreshType.notRefresh then
    addTime = L_MRShopConst.maxRefreshSecond
  elseif dataCell.refreshType == L_MRShopConst.refreshType.minuteRefresh then
    local minute = dataCell.refreshParam[1]
    addTime = L_TimeUtil.getMinuteSecond(minute)
  elseif dataCell.refreshType == L_MRShopConst.refreshType.monthRefresh then
    addTime = self:getMonthSecond(dataCell.refreshParam)
  elseif dataCell.refreshType == L_MRShopConst.refreshType.timedRefresh then
    addTime = self:getTimedResSecond(dataCell.refreshParam)
  elseif dataCell.refreshType == L_MRShopConst.refreshType.weeklyRefresh then
    addTime = self:getWeeklyResScond(dataCell.refreshParam)
  elseif dataCell.refreshType == L_MRShopConst.refreshType.shopRefresh then
    addTime = L_MRShopConst.maxRefreshSecond
  end
  return deadTime + addTime
end

function this:getMonthSecond(param)
  if param == nil then
    return L_MRShopConst.maxRefreshSecond
  end
  self:getNowDateTime()
  local nDays = os.date("%d", os.time({
    year = self.detaTime.year,
    month = self.detaTime.month,
    day = 0
  }))
  local nextDay = 100
  local firstDay = -1
  for _, v in ipairs(param) do
    if firstDay <= 0 then
      firstDay = v
    end
    if v < nextDay and v > self.detaTime.day then
      nextDay = v
    end
  end
  if nDays < nextDay then
    nDays = nDays - self.detaTime.day + firstDay
  else
    nDays = nextDay - self.detaTime.day
  end
  return L_TimeUtil.getDaysToSecond(nDays)
end

function this:getNowDateTime()
  if self.detaTime == nil then
    self.detaTime = {}
  end
  if self.detaTime.second and self.detaTime.second >= self.serverTime then
    return
  end
  self.detaTime.second = self.serverTime
  local timeInfo = L_TimeUtil.getDateInfo(self.serverTime)
  self.detaTime.year = timeInfo.year
  self.detaTime.month = timeInfo.month
  self.detaTime.day = timeInfo.day
  self.detaTime.weekly = timeInfo.wday - 1
  if self.detaTime.weekly < 0 then
    self.detaTime.weekly = 6
  end
end

function this:getTimedResSecond(param)
  local dataInfo = L_TimeUtil.getSecondInfo(self.serverTime)
  local firstTime = -1
  for _, v in ipairs(param) do
    local hour, minute, second = L_TimeUtil.getDateTimeInfor(v)
    local aTime = L_TimeUtil.HOUR * hour + L_TimeUtil.MINUTE * minute + second
    local oTime = L_TimeUtil.HOUR * dataInfo.hour + L_TimeUtil.MINUTE * dataInfo.minute + second
    if firstTime <= 0 then
      firstTime = aTime + L_TimeUtil.DAY_WHOLE - oTime
    end
    if aTime > oTime then
      return aTime - oTime
    end
  end
  return firstTime
end

function this:getWeeklyResScond(param)
  self:getNowDateTime()
  local nextWday = -1
  local firstWday = -1
  for _, v in ipairs(param) do
    if firstWday <= 0 or v < firstWday then
      firstWday = v
    end
    if v > self.detaTime.weekly and (v < nextWday or nextWday <= 0) then
      nextWday = v
    end
  end
  if nextWday <= 0 then
    return L_TimeUtil.getDaysToSecond(7 - self.detaTime.weekly + firstWday)
  else
    return L_TimeUtil.getDaysToSecond(nextWday - self.detaTime.weekly)
  end
end

function this:getPlantformProductList(productList)
  if productList == nil then
    return
  end
  table.clear(productList)
end

function this:checkItemIsGift(id)
  local tpl = _commonItemTpl:getTplById(id)
  if tpl == nil then
    return false
  end
  local type = _commonItemTpl:getType(tpl)
  return type == L_BagConst.bagItemType.heroGift or type == L_BagConst.bagItemType.heroRandomGift or type == L_BagConst.bagItemType.heroFixedGift or type == L_BagConst.bagItemType.petFeedGift
end

return this
