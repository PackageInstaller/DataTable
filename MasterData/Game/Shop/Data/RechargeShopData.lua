local base = require("Game.Shop.Data.ShopDataBase")
local RechargeShopData = class("RechargeShopData", base)
local ShopEnum = require("Game.Shop.ShopEnum")
local ShopGoodData = require("Game.Shop.ShopGoodData")

function RechargeShopData:ctor()
end

function RechargeShopData:UpdateShopGoodsData(shopDataMsg)
  local rechargeShopCfg = ConfigData.shop_recharge[self.shopId]
  if rechargeShopCfg == nil then
    error("Cant get rechargeShopCfg, shopId = " .. tostring(self.shopId))
    return
  end
  for shelfId, data in pairs(rechargeShopCfg) do
    if CheckCondition.CheckLua(data.pre_condition, data.pre_para1, data.pre_para2) then
      local goodsData = self.shopGoodsDic[shelfId]
      local serverData
      local purchases = 0
      local hasdouble
      local historyPurchases = 0
      local freshType
      if shopDataMsg ~= nil then
        serverData = shopDataMsg.data[shelfId]
        if serverData ~= nil then
          purchases = serverData.purchases
          hasdouble = serverData.hasDouble
          historyPurchases = serverData.historyPurchases
          freshType = serverData.FreshType
        end
      end
      if goodsData == nil or shopDataMsg == nil then
        self.shopGoodsDic[shelfId] = ShopGoodData.CreateNewShopGoodData(data, self.shopType, self.shopId, purchases, hasdouble, historyPurchases, freshType)
      else
        goodsData:InitNewShopGoodData(data, self.shopType, self.shopId, purchases, hasdouble, historyPurchases, freshType)
      end
    else
      self.shopGoodsDic[shelfId] = nil
    end
  end
end

return RechargeShopData
