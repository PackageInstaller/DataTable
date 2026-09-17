local this = {}
local C_MJUnionSDK = CS.MJUnionSDK

function this:req_listShopItems(param, callback)
  local data = {shop_id = param}
  L_Net:sendMessage(MsgGenCode.CSProtoShopInfoReq, data, function(rspData, errorCode)
    if errorCode ~= 0 then
      return
    end
    local shops_infos = rspData.infos
    if shops_infos then
      self:rsp_syncShopInfos(shops_infos)
    end
    if callback then
      callback(errorCode)
    end
  end)
end

function this:req_purchaseShopItem(param, callback)
  L_Net:sendMessage(MsgGenCode.CSProtoShopBuyItems, param, function(rspData, errorCode)
    if errorCode == L_Const.errorCode.ErrCodeShopOldVersion then
      callback(nil, errorCode)
      return
    end
    if errorCode ~= 0 then
      callback(nil, errorCode)
      return
    end
    local buy_infos = rspData.info
    if buy_infos then
      self:rsp_syncBuyInfos(buy_infos)
    end
    local buy_rewards = rspData.rewards
    local itemList = buy_rewards.rewards or {}
    if not table.isEmpty(itemList) then
      itemList.forceShow = true
      if callback then
        callback(itemList, errorCode, buy_rewards.src)
      end
    end
  end)
end

function this:req_purchaseCashItem(param, callback)
  local shopTpl = L_GameTpl:getShopIapTpl()
  local goodsTpl = L_GameTpl:getGoodsPurchaseTpl()
  local sTpl = shopTpl:getTplByShopItemId(param.productId)
  local gTpl = goodsTpl:getTplById(param.productId)
  if sTpl then
    local data = {
      product_id = shopTpl:getPayId(sTpl),
      times = param.times
    }
  elseif C_AppConfigManager.Platform == C_EAppPlatform.Harmony then
    C_MJSDKManager.GetChannelCode(function(channel)
      L_FlyMsgManager:showNormalMsgByKey("notice_channelungoods", {
        [0] = channel
      })
    end)
  else
    local channel = C_MJSDKManager.GetChannelCode()
    L_FlyMsgManager:showNormalMsgByKey("notice_channelungoods", {
      [0] = channel
    })
  end
end

function this:req_shopBuyItemsNew()
end

function this:rsp_syncShopInfos(data)
  local entity = self:getShopInfo(data.shop_id, true)
  entity.shopId = data.shop_id
  entity.endTime = data.end_time
  entity.beginTime = data.begin_time
  self:syncGoodsList(data.shop_id, data.items)
end

function this:rsp_syncBuyInfos(data)
  if data == nil then
    return
  end
  local shopId = math.floor(data.slot_id / 1000)
  local entity = self:getGoodsItem(shopId, data.slot_id)
  if entity then
    entity.buyTimes = data.buy_times
    entity.deadTime = data.dead_time
    self:call(self.event.refreshStock, entity)
  end
end

function this:rsp_syncPayItemOrderInfor(data)
  if data == nil or data.info == nil then
    return
  end
  if data.info then
    self:rsp_syncBuyInfos(data.info)
  end
  local rewards = data.reward
  if not table.isEmpty(rewards) and not table.isEmpty(rewards.rewards) then
    L_RewardManager:showPage(rewards.rewards, rewards.src)
  end
end

function this:syncGoodsList(shopId, data)
  for _, v in ipairs(data) do
    local shopTable = self:getShopSlotIdTable(shopId)
    local entity = self:getGoodsItem(shopId, v.slot_id, true)
    entity.slotId = v.slot_id
    entity.buyTimes = v.buy_times
    entity.deadTime = v.dead_time
    entity.storeNum = v.shop_store_num
    entity.goodsId = v.goods_id
    shopTable[v.goods_id] = v.slot_id
  end
end

return this
