local this = {}

function this:init()
  this.super.init(self)
  self.shopTypeList = {
    default = {
      shopClass = table.concat({
        L_R.store,
        "moneyShop.data.moneyShopInfo"
      }),
      goodsClass = table.concat({
        L_R.store,
        "moneyShop.data.moneyGoodsItem"
      })
    },
    [5] = {
      shopClass = table.concat({
        L_R.store,
        "moneyShop.data.moneyShopInfo"
      }),
      goodsClass = table.concat({
        L_R.store,
        "moneyShop.data.moneyGoodsItem"
      })
    }
  }
  self.data = {
    shopList = {}
  }
  self.slotIdList = {}
end

function this:getShopList()
  return self.data.shopList
end

function this:getDataTypeInfo(shopId)
  if self.shopTypeList[shopId] == nil then
    return self.shopTypeList.default
  end
  return self.shopTypeList[shopId]
end

function this:getShopSlotIdTable(shopId)
  if self.slotIdList[shopId] == nil then
    self.slotIdList[shopId] = {}
  end
  return self.slotIdList[shopId]
end

function this:getGoodsList(shopId)
  local shopList = self:getShopList()
  return shopList[shopId].items
end

function this:getShopInfo(shopId, isCreate)
  local shopList = self:getShopList()
  local shopInfo = shopList[shopId]
  local typeInfo = self:getDataTypeInfo(shopId)
  if shopInfo == nil and isCreate then
    shopInfo = require(typeInfo.shopClass):new()
    shopInfo.shopId = shopId
    shopInfo.items = {}
    shopList[shopId] = shopInfo
  end
  return shopInfo
end

function this:getGoodsItem(shopId, slotId, isCreate)
  local shopList = self:getShopList()
  local context = shopList[shopId]
  if context then
    local items = context.items
    local item = items[slotId]
    local typeInfo = self:getDataTypeInfo(shopId)
    if item == nil and isCreate then
      item = require(typeInfo.goodsClass):new()
      item.slotId = slotId
      items[slotId] = item
    end
    return item
  end
end

function this:getEndTime(shopId)
  local shopList = self:getShopList()
  if shopList == nil or shopList[shopId] == nil then
    return 0
  end
  return shopList[shopId].endTime
end

function this:getCurrencyDic(shopId)
  local dic = {}
  local goodsTpl = L_GameTpl:getGoodsTpl()
  local items = self:getShopInfo(shopId).items
  for _, v in pairs(items) do
    local tpl = goodsTpl:getTplById(v.goodsId)
    local currencyId = goodsTpl:getCurrencyId(tpl)
    if currencyId and not dic[currencyId] then
      dic[currencyId] = currencyId
    end
  end
  return dic
end

function this:getStock(shopId, slotId)
  local goodsItem = self:getGoodsItem(shopId, slotId)
  if goodsItem.deadTime and goodsItem.deadTime <= L_TimeUtil.getServerTime() and goodsItem.storeNum <= 0 then
    goodsItem.buyTimes = 0
  end
  if not goodsItem.buyTimes then
    return goodsItem.storeNum
  end
  if self:getIsLimitGoods(shopId, slotId) then
    return goodsItem.storeNum - goodsItem.buyTimes
  else
    return 999999
  end
end

function this:getIsLimitGoods(shopId, slotId)
  local goodsItem = self:getGoodsItem(shopId, slotId)
  if goodsItem == nil then
    return false
  end
  return goodsItem.storeNum > 0
end

function this:getIsSoulOut(shopId, slotId)
  local goodsItem = self:getGoodsItem(shopId, slotId)
  if goodsItem.storeNum <= 0 then
    return false
  end
  return 0 >= self:getStock(shopId, slotId)
end

function this:getSlotIdForGoodsId(shopId, goodsId)
  if self.slotIdList[shopId] == nil then
    return nil
  end
  return self.slotIdList[shopId][goodsId]
end

return this
