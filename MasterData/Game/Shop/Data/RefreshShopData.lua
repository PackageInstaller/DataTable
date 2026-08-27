local base = require("Game.Shop.Data.ShopDataBase")
local RefreshShopData = class("RefreshShopData", base)
local ShopEnum = require("Game.Shop.ShopEnum")

function RefreshShopData:ctor()
  self:AddShopDataComp(ShopEnum.eShopDataCompType.refresh)
end

return RefreshShopData
