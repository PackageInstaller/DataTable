local this = {}

function this:init()
  this.super.init(self)
  self.data = {
    shopList = {},
    curShopGroupId = 0
  }
end

function this:getShopList()
  return self.data.shopList
end

function this:getGoodsList(shopId)
  local shopList = self:getShopList()
  return shopList[shopId].items
end

function this:getShopInfo(shopId, isCreate)
  local shopList = self:getShopList()
  local shopInfo = shopList[shopId]
  if shopInfo == nil and isCreate then
    shopInfo = require(L_R.store .. "shop.data.shopInfo").new()
    shopInfo.shopId = shopId
    shopList[shopId] = shopInfo
  end
  return shopInfo
end

function this:getGoodsItem(shopId, slotId, isCreate)
  local shopList = self:getShopList()
  local items = shopList[shopId].items
  local item = items[slotId]
  if item == nil and isCreate then
    item = require(L_R.store .. "shop.data.goodsItem").new()
    item.slotId = slotId
    items[slotId] = item
  end
  return item
end

function this:getGoodsItemByShopAndgoodsId(shopId, goodsId)
  local shopList = self:getShopList()
  if not shopList[shopId] then
    return nil
  end
  local items = shopList[shopId].items or {}
  for _, item in pairs(items) do
    if item.goodsId == goodsId then
      return item
    end
  end
  return nil
end

function this:getGoodsItemByShopAndgoodsId(shopId, ItemId)
  local shopList = self:getShopList()
  if not shopList[shopId] then
    return nil
  end
  local items = shopList[shopId].items or {}
  for _, item in pairs(items) do
  end
  return nil
end

function this:getEndTime(shopId)
  local shopList = self:getShopList()
  local shopInfo = shopList[shopId]
  if not shopInfo then
    return nil
  end
  return shopInfo.endTime or 0
end

function this:getStock(shopId, slotId)
  local goodsItem = self:getGoodsItem(shopId, slotId)
  if not math.isEmpty(goodsItem.deadTime) and goodsItem.deadTime <= L_TimeUtil.getServerTime() then
    goodsItem.buyTimes = 0
  end
  if not goodsItem.buyTimes then
    return goodsItem.storeNum
  end
  if self:getIsLimitGoods(shopId, slotId) then
    return goodsItem.storeNum - goodsItem.buyTimes
  else
    return 99999999
  end
end

function this:getIsLimitGoods(shopId, slotId)
  local goodsItem = self:getGoodsItem(shopId, slotId)
  if goodsItem == nil then
    return false
  end
  return goodsItem.storeNum > 0
end

function this:getCurOpenShopGroupId()
  return self.data.curShopGroupId
end

function this:setCurOpenShopGroupId(shopId)
  self.data.curShopGroupId = shopId
end

return this
