local UINActSum22ShopGoodsItem = class("UINActSum22ShopGoodsItem", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")

function UINActSum22ShopGoodsItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_goodItem, self, self.OnDungeonShopItemClicked)
  self.itemWithCount = UINBaseItemWithCount.New()
  self.itemWithCount:Init(self.ui.obj_itemWithCount)
  self.itemWithCount:SetNotNeedAnyJump(true)
  self.__OnBuyShopDataCallback = BindCallback(self, self.OnDungeonShopItemClicked)
end

function UINActSum22ShopGoodsItem:InitCharDungeonShopItem(shopGoodData, index, clickEvent)
  self.__shopGoodData = shopGoodData
  self.__clickEvent = clickEvent
  self.__dataIndex = index
  self:RefreshCharDungeonShopItem()
end

function UINActSum22ShopGoodsItem:RefreshCharDungeonShopItem()
  self.ui.tex_GoodName.text = LanguageUtil.GetLocaleText(self.__shopGoodData.itemCfg.name)
  self.ui.tex_stock:SetIndex(0, tostring(self.__shopGoodData.limitTime - self.__shopGoodData.purchases))
  self.itemWithCount:InitItemWithCount(self.__shopGoodData.itemCfg, self.__shopGoodData.itemNum, self.__OnBuyShopDataCallback)
  local priceItem = ConfigData.item[self.__shopGoodData.currencyId]
  self.ui.img_Cost.sprite = CRH:GetSprite(priceItem.small_icon)
  self.ui.tex_Price.text = tostring(self.__shopGoodData.newCurrencyNum)
  self.ui.obj_price:SetActive(not self.__shopGoodData.isSoldOut)
  self.ui.obj_isSellOut:SetActive(self.__shopGoodData.isSoldOut)
  if not IsNull(self.ui.img_Tag) then
    self.ui.img_Tag:SetActive(false)
    if self.__shopGoodData.itemCfg.overflow_type == eItemTransType.actMoneyX then
      local overflowNum = PlayerDataCenter:GetItemOverflowNum(self.__shopGoodData.itemId, 1)
      if overflowNum ~= 0 then
        self.ui.img_Tag:SetActive(true)
      end
    end
  end
end

function UINActSum22ShopGoodsItem:GetDungeonShopItemData()
  return self.__shopGoodData
end

function UINActSum22ShopGoodsItem:GetDungeonShopDataIndex()
  return self.__dataIndex
end

function UINActSum22ShopGoodsItem:OnDungeonShopItemClicked()
  if self.__clickEvent ~= nil and not self.__shopGoodData.isSoldOut then
    self.__clickEvent(self.__dataIndex, self)
  end
end

function UINActSum22ShopGoodsItem:OnDelete()
  base.OnDelete(self)
end

return UINActSum22ShopGoodsItem
