local this = class("pageCommonShopBuyTip", G_UIPageBase)

function this:ctor(...)
  this.super.ctor(self, ...)
  self.data = {
    selectCount = 0,
    maxCount = 0,
    allCurrencyCount = 0,
    costCurrency = 0,
    dataCell = {}
  }
end

function this.bind()
  return {
    title = "",
    moduleIcon = {
      moduleName = "modulePages/cellIcon"
    },
    itemTitle = "",
    itemContent = "",
    itemCost = "",
    itemCostImage = "",
    itemBuyText = "",
    itemAllCost = "",
    itemAllCostImage = "",
    itemLastBox = true,
    itemLastText = ""
  }
end

function this.methods()
  return {
    onClickClose = function(self)
      L_UI:close(self.pageName)
      if self.onClose then
        self.onClose()
      end
    end,
    onClickCancel = function(self)
      L_UI:close(self.pageName)
      if self.onCancel then
        self.onCancel()
      end
    end,
    onClickSure = function(self)
      if self.data.allCurrencyCount < self.data.selectCount * self.data.costCurrency then
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("msg_pageshop_needitemnotenough"))
        return
      end
      if self.onOK then
        self.onOK(self.data.selectCount)
      end
      L_UI:close(self.pageName)
    end,
    onClickReduce = function(self)
      if self.data.selectCount <= self.data.minCount then
        return
      end
      self.data.selectCount = self.data.selectCount - 1
      self:RefreshSelectText()
    end,
    onClickAdd = function(self)
      if self.data.selectCount >= self.data.maxCount then
        return
      end
      self.data.selectCount = self.data.selectCount + 1
      self:RefreshSelectText()
    end,
    onClickMax = function(self)
      if self.data.maxCount <= 1 then
        self.data.maxCount = 1
      end
      self.data.selectCount = self.data.maxCount
      self:RefreshSelectText()
    end,
    onClickMin = function(self)
      self.data.selectCount = self.data.minCount
      self:RefreshSelectText()
    end
  }
end

function this:created(...)
  this.super.created(self, ...)
  self.txtContent = self.bindComponents.txtContent
  self.txtContent2 = self.bindComponents.content2
end

function this:preOpen(options)
  this.super.preOpen(self, options)
  self:updateOptions(options)
  self:showPageData()
end

function this:updateOptions(options)
  options = options or {}
  self.onOK = options.okFunc
  self.onCancel = options.cancel
  self.onClose = options.close
  self.onExit = options.exit
  self.goodsId = options.goodsId
  self.shopId = options.shopId
  self.slotId = options.slotId
  if options.title then
    self.bind.title = options.title
  end
  self.data.selectCount = options.buyCount ~= nil and options.buyCount or 1
  table.clear(self.data.dataCell)
  self.data.dataCell = L_MoneyShopManager:getShopGoodsData(self.shopId, self.goodsId)
end

function this:showPageData()
  if self.data.dataCell == nil then
    return
  end
  local dataCell = self.data.dataCell
  local currItem = L_ItemManager:parseItem(dataCell.currencyType, dataCell.currencyId)
  local icon = currItem.icon
  self.data.allCurrencyCount = currItem.num
  self.data.maxCount = math.floor(dataCell.currency > 0 and currItem.num / dataCell.currency or 1)
  local stockNum = L_MoneyShopStore:getStock(self.shopId, self.slotId)
  self.data.maxCount = stockNum < self.data.maxCount and stockNum or self.data.maxCount
  self.data.minCount = 1
  self.data.costCurrency = dataCell.currency
  self.modules.moduleIcon:setGeneralContent(dataCell.itemType, dataCell.itemId)
  local itemConf = L_ItemTplManager:getItemConfig(dataCell.itemType, dataCell.itemId)
  self.bind.itemTitle = dataCell.goodsName
  self.bind.itemContent = itemConf.desc
  self.bind.itemCost = tostring(dataCell.currency)
  self.bind.itemCostImage = icon
  self.bind.itemAllCostImage = icon
  self.bind.itemLastBox = L_MoneyShopStore:getIsLimitGoods(self.shopId, self.slotId)
  self.bind.itemLastText = stockNum <= 0 and L_WordsTpl:getValue("ui_moneyshop_costallgoods") or table.concat({
    L_WordsTpl:getValue("ui_moneyshop_lastnumber"),
    stockNum
  })
  self:RefreshSelectText()
end

function this:RefreshSelectText()
  local costText = tostring(math.floor(self.data.selectCount * self.data.costCurrency))
  self.bind.itemBuyText = tostring(math.floor(self.data.selectCount))
  if self.data.allCurrencyCount and self.data.allCurrencyCount < self.data.selectCount * self.data.costCurrency then
    self.bind.itemAllCost = L_GameUtil.fillColor(costText, L_Const.colorHtml.red001)
  else
    self.bind.itemAllCost = costText
  end
end

function this:close()
  this.super.close(self)
  if self.onExit then
    self.onExit()
  end
end

return this
