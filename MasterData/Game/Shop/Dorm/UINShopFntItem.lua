local UINShopFntItem = class("UINShopFntItem", UIBaseNode)
local base = UIBaseNode
local ShopEnum = require("Game.Shop.ShopEnum")

function UINShopFntItem:OnInit()
  base.OnInit(self)
end

function UINShopFntItem:InitNormalGoodsItem(goodData, purchaseRoot, refreshFunc, baseObj)
  self.goodData = goodData
  self.purchaseRoot = purchaseRoot
  self.refreshFunc = refreshFunc
  self.type = goodData.type
  self.baseObj = baseObj
  self.baseObj.transform:SetParent(self.transform, false)
  self.baseObj:InitFntItem(goodData, self)
end

function UINShopFntItem:RefreshLeftSellTime()
  self.baseObj:RefreshLeftSellTime()
end

function UINShopFntItem:RefreshGoods()
  if self.refreshFunc ~= nil then
    self.refreshFunc()
  end
end

return UINShopFntItem
