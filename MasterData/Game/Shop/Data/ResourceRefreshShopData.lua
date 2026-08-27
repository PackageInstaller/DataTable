local base = require("Game.Shop.Data.ResourceShopData")
local ResourceRefreshShopData = class("ResourceRefreshShopData", base)
local ShopEnum = require("Game.Shop.ShopEnum")
local ShopGoodData = require("Game.Shop.ShopGoodData")

function ResourceRefreshShopData:ctor()
  self:AddShopDataComp(ShopEnum.eShopDataCompType.timeLimit)
  self:AddShopDataComp(ShopEnum.eShopDataCompType.refresh)
end

return ResourceRefreshShopData
