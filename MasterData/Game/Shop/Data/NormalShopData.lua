local base = require("Game.Shop.Data.ShopDataBase")
local NormalShopData = class("NormalShopData", base)
local ShopEnum = require("Game.Shop.ShopEnum")
local ShopGoodData = require("Game.Shop.ShopGoodData")

function NormalShopData:ctor()
  self:AddShopDataComp(ShopEnum.eShopDataCompType.page)
end

function NormalShopData:UpdateShopGoodsData(shopDataMsg)
  if shopDataMsg == nil then
    return
  end
  local normalShopCfg = ConfigData.shop_normal[self.shopId]
  if normalShopCfg == nil then
    error("normalShopCfg cfg is null,ID:" .. tostring(self.shopId))
    return
  end
  for _, data in pairs(shopDataMsg.data) do
    local goodCfg = normalShopCfg[data.shelfId]
    if goodCfg == nil then
      error("normalShopCfg cfg is null,ID:" .. tostring(self.shopId) .. " shelfId" .. tostring(data.shelfId))
      return
    end
    data.order = goodCfg.order
    if CheckCondition.CheckLua(goodCfg.pre_condition, goodCfg.pre_para1, goodCfg.pre_para2) then
      local shopGoodsData = self.shopGoodsDic[data.shelfId]
      if shopGoodsData == nil then
        self.shopGoodsDic[data.shelfId] = ShopGoodData.CreateShopGoodData(data, self.shopType, self.shopId)
      else
        shopGoodsData:InitShopGoodData(data, self.shopType, self.shopId)
      end
    else
      local shopGoodsData = self.shopGoodsDic[data.shelfId]
      if shopGoodsData ~= nil then
        self.shopGoodsDic[data.shelfId] = nil
      end
    end
  end
end

return NormalShopData
