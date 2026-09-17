local this = {}

function this:req_listShopItems(param, callback)
  local data = {shop_id = param}
  L_Net:sendMessage(MsgGenCode.CSProtoShopInfoReq, data, function(rspData, errorCode)
    if callback then
      callback(errorCode)
    end
  end)
end

function this:req_purchaseShopItem(param, callback)
  L_Net:sendMessage(MsgGenCode.CSProtoShopBuyItems, param, function(rspData, errorCode)
    print("=================================errorCode", errorCode)
    if callback then
      callback(rspData, errorCode)
    end
    if errorCode == L_Const.errorCode.ErrCodeSucc then
      self:call(self.event.onBuyShopGoodsSucc)
    end
  end)
end

function this:rsp_shopInfoDatas(rspData, errorCode)
  if errorCode ~= 0 then
    return
  end
  local shopsInfos = rspData.shop_info
  if shopsInfos then
    self:rsp_syncShopInfos(shopsInfos)
  end
end

function this:rsp_syncShopInfos(data)
  self.data.shopList = self.data.shopList or {}
  local entity = self:getShopInfo(data.shop_id, true)
  entity.shopId = data.shop_id
  entity.endTime = data.end_time
  entity.beginTime = data.begin_time
  self:syncGoodsList(data.shop_id, data.shop_items or {})
  self:call(self.event.syncShopInfosComplete)
end

function this:rsp_syncBuyInfos(data)
  local shopId = math.floor(data.slot_id / 1000)
  local entity = self:getGoodsItem(shopId, data.slot_id)
  entity.buyTimes = data.buy_times
  entity.deadTime = data.dead_time
  self:call(self.event.refreshStock, entity)
end

function this:syncGoodsList(shopId, data)
  for _, v in ipairs(data) do
    if v.slot_id then
      local entity = self:getGoodsItem(shopId, v.slot_id, true)
      entity.slotId = v.slot_id
      entity.buyTimes = v.buy_times
      entity.deadTime = v.dead_time
      entity.storeNum = v.shop_store_num
      entity.goodsId = v.goods_id
      entity.unlockProgress = v.unlock_progress
    end
  end
end

return this
