local this = class("moduleMShopCell", G_UIModuleBase)

function this:ctor(...)
  this.super.ctor(self, ...)
  self.data = {
    selectType = nil,
    checkTypeFunc = nil,
    goodsList = {},
    dataCell = {},
    productList = {},
    slotOrderIdList = {},
    miniEndTime = 0,
    nextRefreshTime = -1,
    canResetList = false
  }
end

function this.bind()
  return {
    scrollList_goods = {
      moduleName = "pages/moneyShop/cellShopItem"
    }
  }
end

function this.methods()
  return {
    scrollList_goods = {
      onClickSelect = function(self, slotId)
        local goodsId
        local dataCell = {}
        for i = 1, #self.bind.scrollList_goods do
          if self.bind.scrollList_goods:getValue(i, "slotId") == slotId then
            goodsId = self.bind.scrollList_goods:getValue(i, "goodsId")
            self.bind.scrollList_goods:change(i, {choice = true})
          else
            self.bind.scrollList_goods:change(i, {choice = false})
          end
        end
        self.bind.purchase = true
        local stockNum = L_MoneyShopStore:getStock(self.data.selectType, slotId)
        if stockNum <= 0 then
          L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("msg_pageshop_goodssoldout"))
          return
        end
        self.data.dataCell = L_MoneyShopManager:getShopGoodsData(self.data.selectType, goodsId)
        if self.data.dataCell.isCashGoods then
          L_MoneyShopManager:buyMoneyProduct(slotId, goodsId, self.data.selectType, self.data.dataCell.isCashGoods)
        elseif L_MoneyShopManager:checkItemIsGift(self.data.dataCell.itemId) then
          L_MoneyShopManager:buyGiftGoodsList(slotId, goodsId, self.data.selectType, self.data.dataCell.isCashGoods)
        else
          L_MoneyShopManager:buyShopGoodsList(slotId, goodsId, self.data.selectType, self.data.dataCell.isCashGoods)
        end
      end
    }
  }
end

function this:open()
  this.super.open(self)
  L_MoneyShopStore:listenCallFunc(L_MoneyShopStore.event.refreshStock, self.onEventRefreshStock, self)
  L_MoneyShopManager:getPlantformProductList(self.data.productList)
end

function this:openRefreshShop()
  if self.data.shopRefreshTimer then
    return
  end
  local frequency = 1
  local addTime = 0
  
  local function _run()
    local serverTime = L_TimeUtil.getServerTime()
    if 60 <= addTime then
      addTime = 0
      self:initShopList()
    end
    addTime = addTime + 1
    if 0 < self.data.nextRefreshTime and serverTime > self.data.nextRefreshTime then
      self:refreshShopList()
      self:initShopList()
    end
    if 0 < self.data.miniEndTime and serverTime > self.data.miniEndTime then
      self:initShopList()
    end
    local endTime = L_MoneyShopStore:getEndTime(self.data.selectType)
    if endTime and endTime <= 0 or serverTime < endTime or not self.data.canRefreshBuyTimes then
      return
    end
    L_MoneyShopStore:req_listShopItems(self.data.selectType, function(errorCode)
      self:initShopList()
      if errorCode == L_Const.errorCode.ErrCodeSucc then
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_pageshop_shoprefreshed"))
      end
    end)
  end
  
  _run()
  self.data.shopRefreshTimer = Timer.repeated(frequency, _run)
end

function this:close()
  this.super.close(self)
  L_MoneyShopStore:unListenCallFunc(L_MoneyShopStore.event.refreshStock, self.onEventRefreshStock, self)
  self:closeRefreshShop()
end

function this:closeRefreshShop()
  if self.data.shopRefreshTimer == nil then
    return
  end
  self.data.shopRefreshTimer:destroy()
  self.data.shopRefreshTimer = nil
end

function this:initModule(shopId)
  self.data.selectType = shopId
  L_MoneyShopStore:req_listShopItems(self.data.selectType, function()
    self.data.canResetList = true
    self:closeRefreshShop()
    self:initPage()
  end)
end

function this:initPage()
  self:initShopList()
  self:openRefreshShop()
end

function this:onEventRefreshStock(entity)
  if not entity then
    return
  end
  self:initShopList()
end

function this:initShopList()
  table.clear(self.data.goodsList)
  local sortList = L_MoneyShopStore:getGoodsList(self.data.selectType)
  for _, v in pairs(sortList) do
    local dataCell = L_MoneyShopManager:getShopGoodsData(self.data.selectType, v.goodsId)
    local goodsId = v.goodsId
    local currencyId = dataCell.currencyId
    local currency = dataCell.currency
    local currencyType = dataCell.currencyType
    local isEnd = false
    local itemData
    if dataCell.endTime ~= 0 then
      isEnd = dataCell.endTime <= L_TimeUtil.getServerTime()
      if self.data.miniEndTime > dataCell.endTime and dataCell.endTime > L_TimeUtil.getServerTime() then
        self.data.miniEndTime = dataCell.endTime
      end
    end
    if 0 < v.deadTime and (0 >= self.data.nextRefreshTime or self.data.nextRefreshTime > v.deadTime) then
      self.data.nextRefreshTime = v.deadTime
    end
    local is_recommend = false
    if dataCell.recommend ~= nil and 0 < #dataCell.recommend and 0 < L_MoneyShopStore:getStock(self.data.selectType, v.slotId) then
      is_recommend = true
    end
    local stockNum = L_MoneyShopStore:getStock(self.data.selectType, v.slotId)
    local str = table.concat({
      L_WordsTpl:getValue("ui_moneyshop_lastnumber"),
      stockNum
    })
    if dataCell.isCashGoods then
      itemData = L_ItemTplManager:getCurrencyItem(L_Const.currencyType.trueCash)
      str = ""
    else
      itemData = L_ItemTplManager:getItemConfig(currencyType, currencyId)
      if stockNum == 0 then
        str = L_WordsTpl:getValue("ui_moneyshop_costallgoods")
      end
      if not L_MoneyShopStore:getIsLimitGoods(self.data.selectType, v.slotId) then
        str = ""
      end
    end
    local isComp = dataCell.commonCondition == nil and true or L_ConditionManager:isComplete(dataCell.commonCondition)
    local isOut = L_MoneyShopManager:getShopIsSoldOut(self.data.selectType, v.slotId)
    local isNotShow = isOut and dataCell.isSoldOutMask
    local slotData
    if self.data.slotOrderIdList[v.slotId] == nil then
      slotData = {}
      self.data.slotOrderIdList[v.slotId] = slotData
    else
      slotData = self.data.slotOrderIdList[v.slotId]
    end
    slotData.goodsId = goodsId
    slotData.slotId = v.slotId
    slotData.itemId = dataCell.itemId
    slotData.itemType = dataCell.itemType
    slotData.numText = tostring(dataCell.itemCount)
    slotData.isCellIcon = not dataCell.isCashGoods
    slotData.txtName = dataCell.goodsName
    slotData.imgCurrency = itemData.icon
    slotData.isImgCIcon = not dataCell.isCashGoods
    slotData.istxtCIcon = dataCell.isCashGoods
    slotData.isBigImagIcon = dataCell.isCashGoods
    slotData.bigImgIcon = dataCell.icon
    slotData.txtCost = tostring(currency)
    slotData.goSoldOut = stockNum == 0 and L_MoneyShopStore:getIsLimitGoods(self.data.selectType, v.slotId)
    slotData.goStock = str
    slotData.goRecommend = is_recommend
    slotData.txtLastTime = L_TimeUtil.getLeftTimeStringShort(dataCell.endTime - L_TimeUtil.getServerTime())
    slotData.lastBox = dataCell.endTime > 0
    slotData.stockBox = str ~= ""
    local cloneTable = table.clone(slotData)
    if isComp and not isNotShow and not isEnd then
      table.insert(self.data.goodsList, cloneTable)
    end
  end
  self:showList()
end

function this:refreshShopList()
  self.data.nextRefreshTime = -1
  L_MoneyShopManager:shopListGoodsMSData(self.data.selectType)
end

function this:showList()
  self:sortList()
  if self.data.canResetList then
    self.data.canResetList = false
    self.bind.scrollList_goods:clear()
    self.bind.scrollList_goods:insert_array(self.data.goodsList)
  else
    for i, v in ipairs(self.data.goodsList) do
      self.bind.scrollList_goods:change(i, v)
      local grid = self.bind.scrollList_goods:getItemCls(i)
      grid:refreshCell()
    end
  end
  self.data.canRefreshBuyTimes = true
end

function this:sortList()
  local function _sortByGoodsID(itemA, itemB)
    local vA = itemA.goodsId
    
    local vB = itemB.goodsId
    return vA < vB
  end
  
  local function _sortByStock(itemA, itemB)
    local vA = itemA.goSoldOut == true and 0 or 1
    local vB = itemB.goSoldOut == true and 0 or 1
    if vA == nil or vB == nil then
      return _sortByGoodsID(itemA, itemB)
    end
    if vA == vB then
      return _sortByGoodsID(itemA, itemB)
    else
      return vA > vB
    end
  end
  
  table.sort(self.data.goodsList, _sortByStock)
end

return this
