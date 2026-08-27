local UINShopHeroFreeGoodsItem = class("UINShopHeroFreeGoodsItem", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")

function UINShopHeroFreeGoodsItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.itemWithCount = UINBaseItemWithCount.New()
  self.itemWithCount:Init(self.ui.obj_itemWithCount)
  self.itemWithCount:EnableButton(true)
end

function UINShopHeroFreeGoodsItem:RefreshItem(itemId, itemNum)
  self.ui.obj_tag:SetActive(true)
  local itemCfg = ConfigData.item[itemId]
  self.itemWithCount:InitItemWithCount(itemCfg, itemNum)
  self.itemWithCount:SetItemFragTag(false)
end

function UINShopHeroFreeGoodsItem:OnDelete()
  self.itemWithCount:OnDelete()
  base.OnDelete(self)
end

return UINShopHeroFreeGoodsItem
