local base = require("Game.Shop.Data.ShopDataBase")
local HeroShopData = class("HeroShopData", base)
local ShopEnum = require("Game.Shop.ShopEnum")
local ShopGoodData = require("Game.Shop.ShopGoodData")

function HeroShopData:ctor()
  self:AddShopDataComp(ShopEnum.eShopDataCompType.page)
end

function HeroShopData:UpdateShopGoodsData(shopDataMsg)
  local heroShopCfg = ConfigData.shop_hero[self.shopId]
  if heroShopCfg == nil then
    error("heroShop cfg is null,ID:" .. tostring(self.shopId))
    return
  end
  for shelfId, data in pairs(heroShopCfg) do
    if CheckCondition.CheckLua(data.pre_condition, data.pre_para1, data.pre_para2) then
      local goodsData = self.shopGoodsDic[shelfId]
      local serverData
      local purchases = 0
      local historyPurchases = 0
      local hasdouble
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

return HeroShopData
