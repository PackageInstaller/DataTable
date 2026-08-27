local base = require("Game.Shop.Data.ShopDataBase")
local ResourceShopData = class("ResourceShopData", base)
local ShopEnum = require("Game.Shop.ShopEnum")
local ShopGoodData = require("Game.Shop.ShopGoodData")

function ResourceShopData:ctor()
end

function ResourceShopData:UpdateShopGoodsData(shopDataMsg)
  local resourceShopCfg = ConfigData.shop_resource[self.shopId]
  if resourceShopCfg == nil then
    error("resourceShop cfg is null,ID:" .. tostring(self.shopId))
    return
  end
  for shelfId, data in pairs(resourceShopCfg) do
    if CheckCondition.CheckLua(data.pre_condition, data.pre_para1, data.pre_para2) then
      local goodsData = self.shopGoodsDic[shelfId]
      local purchases = 0
      local serverData, hasdouble
      local historyPurchases = 0
      if shopDataMsg ~= nil then
        serverData = shopDataMsg.data[shelfId]
        if serverData ~= nil then
          purchases = serverData.purchases
          hasdouble = serverData.hasDouble
          historyPurchases = serverData.historyPurchases
        end
      end
      if goodsData == nil or shopDataMsg == nil then
        self.shopGoodsDic[shelfId] = ShopGoodData.CreateNewShopGoodData(data, self.shopType, self.shopId, purchases, hasdouble, historyPurchases)
      else
        goodsData:InitNewShopGoodData(data, self.shopType, self.shopId, purchases, hasdouble, historyPurchases)
      end
    end
  end
end

return ResourceShopData
