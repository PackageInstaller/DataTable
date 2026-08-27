local UINShopHeroFreeGoodsList = class("UINShopHeroFreeGoodsList", UIBaseNode)
local base = UIBaseNode
local UINShopHeroFreeGoodsItem = require("Game.Shop.UINShopHeroFreeGoodsItem")

function UINShopHeroFreeGoodsList:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.obj_item:SetActive(false)
  self.__itemList = UIItemPool.New(UINShopHeroFreeGoodsItem, self.ui.obj_item)
end

function UINShopHeroFreeGoodsList:RefreshItemList(freeItemIds, freeItemNums)
  self.__itemList:HideAll()
  for index, id in ipairs(freeItemIds) do
    local item = self.__itemList:GetOne()
    local num = freeItemNums[index]
    item:RefreshItem(id, num)
  end
end

function UINShopHeroFreeGoodsList:OnDelete()
  self.__itemList:DeleteAll()
  base.OnDelete(self)
end

return UINShopHeroFreeGoodsList
