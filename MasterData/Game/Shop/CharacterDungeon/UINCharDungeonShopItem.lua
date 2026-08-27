local UINCharDungeonShopItem = class("UINCharDungeonShopItem", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")

function UINCharDungeonShopItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_goodItem, self, self.OnDungeonShopItemClicked)
  self.itemWithCount = UINBaseItemWithCount.New()
  self.itemWithCount:Init(self.ui.obj_itemWithCount)
  self.itemWithCount:SetNotNeedAnyJump(true)
end

function UINCharDungeonShopItem:InitCharDungeonShopItem(shopGoodData, index, clickEvent)
  self.__shopGoodData = shopGoodData
  self.__clickEvent = clickEvent
  self.__dataIndex = index
  self:RefreshCharDungeonShopItem()
end

function UINCharDungeonShopItem:RefreshCharDungeonShopItem()
  self.ui.tex_GoodName.text = LanguageUtil.GetLocaleText(self.__shopGoodData.itemCfg.name)
  self.itemWithCount:InitItemWithCount(self.__shopGoodData.itemCfg, self.__shopGoodData.itemNum)
  local priceItem = ConfigData.item[self.__shopGoodData.currencyId]
  self.ui.img_Cost.sprite = CRH:GetSprite(priceItem.small_icon)
  self.ui.tex_Price.text = tostring(self.__shopGoodData.newCurrencyNum)
  self.ui.tex_surplusCount.gameObject:SetActive(self.__shopGoodData.isLimit)
  local num = self.__shopGoodData.limitTime - self.__shopGoodData.purchases
  local isSoldOut = self.__shopGoodData.isSoldOut
  self.ui.obj_price:SetActive(not isSoldOut)
  self.ui.obj_isSellOut:SetActive(isSoldOut)
  local showRecommend = self.__shopGoodData.isRecommendGood and not isSoldOut
  self.ui.obj_Recommend:SetActive(showRecommend)
  self.ui.obj_outTag:SetActive(false)
  if self.__shopGoodData.itemCfg.overflow_type == eItemTransType.actMoneyX then
    local overflowNum = PlayerDataCenter:GetItemOverflowNum(self.__shopGoodData.itemId, 1)
    if overflowNum ~= 0 then
      self.ui.obj_outTag:SetActive(true)
    end
  end
  if self.__shopGoodData.isLimit then
    self.ui.tex_surplusCount:SetIndex(0, tostring(num))
  end
end

function UINCharDungeonShopItem:GetDungeonShopItemData()
  return self.__shopGoodData
end

function UINCharDungeonShopItem:GetDungeonShopDataIndex()
  return self.__dataIndex
end

function UINCharDungeonShopItem:OnDungeonShopItemClicked()
  if self.__clickEvent ~= nil then
    self.__clickEvent(self.__dataIndex, self)
  end
end

function UINCharDungeonShopItem:OnDelete()
  base.OnDelete(self)
end

return UINCharDungeonShopItem
