local UINShopFntEmptyItem = class("UINShopFntEmptyItem", UIBaseNode)
local base = UIBaseNode
local ShopEnum = require("Game.Shop.ShopEnum")

function UINShopFntEmptyItem:OnInit()
  base.OnInit(self)
end

function UINShopFntEmptyItem:InitFntItem(goodData, baseObj)
end

function UINShopFntEmptyItem:RefreshLeftSellTime()
end

return UINShopFntEmptyItem
