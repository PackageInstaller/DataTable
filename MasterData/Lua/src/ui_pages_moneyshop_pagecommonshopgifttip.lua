local this = class("pageCommonShopGiftTip", G_UIPageBase)
local _commonItemTpl = L_GameTpl:getCommonItemTpl()
local _commonItemTypeIconTpl = L_GameTpl:getCommonItemTypeIconTpl()

function this:ctor(...)
  this.super.ctor(self, ...)
  self.data = {
    selectCount = 0,
    maxCount = 0,
    costCurrency = 0,
    isEnough = true,
    dataCell = {},
    itemGroup = {}
  }
end

function this.bind()
  return {
    title = "",
    moduleIcon = {
      moduleName = "modulePages/cellIcon"
    },
    itemCost = "",
    itemCostImage = "",
    itemNameText = "",
    itemLastBox = true,
    itemLastText = "",
    btnCostNum = "",
    btnCostIcon = "",
    textChoose = true,
    textRandom = true,
    textGetAll = true,
    scrollList_goods = {
      moduleName = "pages/Common/cellCommonShopItem"
    }
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
      if not self.data.isEnough then
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_goodsItemInsufficient"))
        return
      end
      if self.onOK then
        self.onOK(1)
      end
      L_UI:close(self.pageName)
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
  table.clear(self.data.dataCell)
  self.data.dataCell = L_MoneyShopManager:getShopGoodsData(self.shopId, self.goodsId)
  local dataCell = self.data.dataCell
  local currItem
  if dataCell.isCashGoods then
    currItem = L_ItemTplManager:getCurrencyItem(L_Const.currencyType.trueCash)
    self.data.isEnough = true
  else
    local currType, currId = dataCell.currencyType, dataCell.currencyId
    currItem = L_ItemTplManager:getItemConfig(currType, currId)
    self.data.isEnough = L_ItemTplManager:getItemNum(currType, currId) >= dataCell.currency
  end
  local costText = tostring(dataCell.currency)
  local icon = currItem.icon
  local stockNum = L_MoneyShopStore:getStock(self.shopId, self.slotId)
  self.bind.itemCost = tostring(dataCell.currency)
  self.bind.itemCostImage = icon
  self.modules.moduleIcon:setGeneralContent(dataCell.itemType, dataCell.itemId)
  self.bind.itemLastBox = L_MoneyShopStore:getIsLimitGoods(self.shopId, self.slotId)
  self.bind.itemLastText = stockNum <= 0 and L_WordsTpl:getValue("ui_moneyshop_costallgoods") or table.concat({
    L_WordsTpl:getValue("ui_moneyshop_lastnumber"),
    stockNum
  })
  local tpl = _commonItemTpl:getTplById(dataCell.itemId)
  local type = _commonItemTpl:getType(tpl)
  self.bind.textChoose = type == L_BagConst.bagItemType.heroGift or type == L_BagConst.bagItemType.petFeedGift
  self.bind.textRandom = type == L_BagConst.bagItemType.heroRandomGift
  self.bind.textGetAll = type == L_BagConst.bagItemType.heroFixedGift
  self.bind.itemNameText = dataCell.goodsName
  if self.data.isEnough then
    self.bind.btnCostNum = costText
  else
    self.bind.btnCostNum = L_GameUtil.fillColor(costText, L_Const.colorHtml.red001)
  end
  self.bind.btnCostIcon = icon
end

function this:showPageData()
  local commonItemTpl = L_GameTpl:getCommonItemTpl()
  local dropTpl = L_GameTpl:getDropTpl()
  local tpl = commonItemTpl:getTplById(self.data.dataCell.itemId)
  local funcList = commonItemTpl:getUseFunction(tpl)
  if funcList == nil or #funcList <= 0 then
    return
  end
  local dropGroup = dropTpl:getDropGroup(funcList[1])
  table.clear(self.data.itemGroup)
  for _, v in pairs(dropGroup) do
    local itemId = dropTpl:getItemId(v)
    local itemType = dropTpl:getType(v)
    local rewardNum = dropTpl:getMinValue(v)
    local itemData = L_ItemTplManager:getItemConfig(itemType, itemId)
    table.insert(self.data.itemGroup, {
      itemId = itemId,
      itemType = itemType,
      imgChoice = false,
      textName = itemData.name,
      textStock = table.concat({
        "x ",
        tostring(rewardNum)
      })
    })
  end
  self:RefreshRewardList()
end

function this:RefreshRewardList()
  self.bind.scrollList_goods:clear()
  self.bind.scrollList_goods:insert_array(self.data.itemGroup)
end

function this:close()
  this.super.close(self)
  if self.onExit then
    self.onExit()
  end
end

return this
