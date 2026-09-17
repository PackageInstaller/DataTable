local this = {}

function this:req_CSProtoNormalProductStart(guid, productId, count, selectMaterial, callback)
  local data = {
    build_guid = guid,
    product_id = productId,
    count = count,
    select_material = selectMaterial or {}
  }
  L_Net:sendMessage(MsgGenCode.CSProtoProductStart, data, function(rspData, errorCode)
    if callback then
      callback(errorCode)
    end
    L_ProductStore:call(L_ProductStore.event.productStartCb)
  end)
end

function this:req_CSProtoAccessoryProductStart(buildGuid, productId, accGuid, callback)
  local data = {
    build_guid = buildGuid,
    product_id = productId,
    ornament_guid = accGuid
  }
  L_Net:sendMessage(MsgGenCode.CSProtoProductOrnamentStart, data, function(rspData, errorCode)
    if callback then
      callback(errorCode)
    end
    L_ProductStore:call(L_ProductStore.event.accessoryProductCb)
  end)
end

function this:req_CSProtoProductStartImmediately(param, callback)
  local data = {
    guid = param.guid,
    product_id = param.productId,
    count = param.count
  }
  L_Net:sendMessage(MsgGenCode.CSProtoProductStart, data, function(rspData, errorCode)
    if callback then
      callback(rspData, errorCode)
    end
    L_ProductStore:call(L_ProductStore.event.productFinish)
  end)
end

function this:req_CSProtoAccessorySmeltOrnament(param, callback)
  L_Net:sendMessage(MsgGenCode.CSProtoSmeltOrnament, param, function(rspData, errorCode)
    local reward
    if rspData.rewards then
      reward = rspData.rewards
    end
    if not table.isEmpty(reward) then
      reward.useStaticBackground = true
      local rewards = require("ui.manager.reward.rewardData").new()
      rewards.rewardShowType = L_Const.rewardShowType.full
      local data = L_DataUtil.parseRewardConfig(reward, true, true)
      rewards:constructList(data)
      L_RewardManager:ShowReward(rewards)
    end
    if callback then
      callback(errorCode)
    end
  end)
end

function this:req_CSProtoProductStartImmediately(param, callback)
  local data = {
    guid = param.guid,
    product_id = param.productId,
    count = param.count
  }
  L_Net:sendMessage(MsgGenCode.CSProtoProductStart, data, function(rspData, errorCode)
    if callback then
      callback(rspData, errorCode)
    end
    L_ProductStore:call(L_ProductStore.event.productFinish)
  end)
end

function this:req_CSProtoProductFinish(buildingGuid, callback)
  local data = {guid = buildingGuid, is_all = true}
  L_Net:sendMessage(MsgGenCode.CSProtoProductFinish, data, function(rspData, errorCode)
    if callback then
      callback(rspData, errorCode)
    end
    L_ProductStore:call(L_ProductStore.event.productFinish)
  end)
end

function this:req_CSProtoProductFinishByPGuidList(buildingGuid, productGuids, callback)
  local data = {
    guid = buildingGuid,
    product_guids = productGuids,
    is_all = false
  }
  L_Net:sendMessage(MsgGenCode.CSProtoProductFinish, data, function(rspData, errorCode)
    if errorCode == L_Const.errorCode.ErrCodeSucc then
      L_ProductStore:call(L_ProductStore.event.productFinish)
    end
    if callback then
      callback(rspData, errorCode)
    end
  end)
end

function this:req_CSProtoProductCancel(buildingGuid, productGuids, callback)
  local data = {
    guid = buildingGuid,
    product_guids = productGuids,
    is_all = false
  }
  L_Net:sendMessage(MsgGenCode.CSProtoProductCancel, data, function(rspData, errorCode)
    if callback then
      callback(errorCode)
    end
    L_ProductStore:call(L_ProductStore.event.productCancel)
  end)
end

function this:req_CSProtoSimpleProductStart(productId, count, selectMaterial, callback)
  local data = {
    build_guid = 0,
    product_id = productId,
    count = count,
    select_material = selectMaterial
  }
  L_Net:sendMessage(MsgGenCode.CSProtoSimpleProductStart, data, function(rspData, errorCode)
    if errorCode == L_Const.errorCode.ErrCodeSucc then
      if callback then
        callback()
      end
      L_ProductStore:call(L_ProductStore.event.quickProductStart)
    end
  end)
end

function this:req_CSProtoSimpleProductCancel(index, callback)
  local data = {u32 = index}
  L_Net:sendMessage(MsgGenCode.CSProtoSimpleProductCancel, data, function(rspData, errorCode)
    if errorCode == L_Const.errorCode.ErrCodeSucc then
      if callback then
        callback()
      end
      L_ProductStore:call(L_ProductStore.event.quickProductCancel)
    end
  end)
end

function this:rsp_onPetFinishProduct(data)
  local guid = data.pet_guid
  local reward = data.reward
  if reward then
    L_ProductManager:showPetFinishMsg(guid, reward.rewards or {})
  end
end

function this:rsp_onSyncFastProductData(data, errorCode)
  if errorCode ~= L_Const.errorCode.ErrCodeSucc then
    return
  end
  L_ProductStore:call(L_ProductStore.event.refreshFastProduct)
  L_ProductManager:onShowAllFastProductRewards()
end

function this:rsp_onSyncHomeFormulaInfo(data)
  L_ProductStore:setHadProductRecordNumList(data)
end

return this
