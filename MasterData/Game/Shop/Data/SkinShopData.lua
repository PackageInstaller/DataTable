local base = require("Game.Shop.Data.ShopDataBase")
local SkinShopData = class("SkinShopData", base)
local ShopUtil = require("Game.Shop.ShopUtil")
local ShopEnum = require("Game.Shop.ShopEnum")
local ShopGoodData = require("Game.Shop.ShopGoodData")

function SkinShopData:ctor()
  self:AddShopDataComp(ShopEnum.eShopDataCompType.timeLimit)
  self:AddShopDataComp(ShopEnum.eShopDataCompType.page)
end

function SkinShopData:UpdateShopGoodsData(shopDataMsg)
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
    if data.freshTm == 0 then
      local hasTimeLimit, inTime, startTime, endTime = ShopUtil.GetShopGoodStillTime(goodCfg)
      if hasTimeLimit then
        data.freshTm = endTime
      end
    end
    local shopGoodsData = self.shopGoodsDic[data.shelfId]
    if shopGoodsData == nil then
      self.shopGoodsDic[data.shelfId] = ShopGoodData.CreateShopGoodData(data, self.shopType, self.shopId)
    else
      shopGoodsData:InitShopGoodData(data, self.shopType, self.shopId)
    end
  end
end

return SkinShopData
