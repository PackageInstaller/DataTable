local this = class("productManager")
local _productsTpl = L_GameTpl:getProductsTpl()
local _accessoryProductTpl = L_GameTpl:getAccessoryProductTpl()
local _foodTpl = L_GameTpl:getFoodTpl()
local _foodGroupTpl = L_GameTpl:getFoodGroupTpl()
local _homeBuildingTpl = L_GameTpl:getHomeBuildingTpl()
local _homeBuildingProductionTpl = L_GameTpl:getHomeBuildingProductionTpl()
local _productsMultiQualityTpl = L_GameTpl:getProductsMultiQualityTpl()
local _commonItemTpl = L_GameTpl:getCommonItemTpl()
local _SystemVoiceUnitruleTpl = L_GameTpl:getSystemVoiceUnitruleTpl()
local _foodMaterialTpl = L_GameTpl:getFoodMaterialGroupTpl()
local _productsMaterialGroupTpl = L_GameTpl:getProductsMaterialGroupTpl()
local csHomeStore = L_HomeStore:getCsHomeStore()
local ProductItemType2InsertEndCheckFuncName = {
  [L_Const.resType.mountSaddle] = "checkIsNeedInsertEndSaddleType"
}

function this:initialize()
  self:addEventListener()
  self:initialCachedData()
end

function this:initialCachedData()
  self.cachedProduceOnceTime = {}
  self.curBuildingIdList = {}
  self.cachedBuildingIdAndTabId2ProductConfigDataList = {}
  self.cachedQuickProductConfigDataList = {}
  self.cachedProductRewardItemData = {}
end

function this:resetCachedData()
  table.clear(self.cachedProduceOnceTime)
end

function this:addEventListener()
  L_UI:addListener(L_UI.pageEvent.showed, self.onEventMessageUIShowed, self)
  
  function self.onHomeBuildSync()
    self:resetCachedData()
    self:preloadAllProductConfigDataForBuildingByCurHomeBuildingIdList()
  end
  
  C_HomeStoreEvent.instance:Listen(C_EHomeStoreEvent.HomeBuildAdd, self.onHomeBuildSync)
  L_PetStore:listenCallFunc(L_PetStore.event.refreshPetDatas, self.onRefreshPetDatas, self)
  L_TechnologyStore:listenCallFunc(L_TechnologyStore.event.refresh, self.onRefreshTechnology, self)
end

function this:dispose()
  L_UI:removeListener(L_UI.pageEvent.showed, self.onEventMessageUIShowed, self)
  C_HomeStoreEvent.instance:Cancel(C_EHomeStoreEvent.HomeBuildAdd, self.onHomeBuildSync)
  L_PetStore:unListenCallFunc(L_PetStore.event.refreshPetDatas, self.onRefreshPetDatas, self)
  L_TechnologyStore:unListenCallFunc(L_TechnologyStore.event.refresh, self.onRefreshTechnology, self)
  self:resetCachedData()
end

function this:onRefreshPetDatas()
  self:resetCachedData()
end

function this:onRefreshTechnology()
  self:resetCachedData()
end

function this:onEventMessageUIShowed(pageName)
  if pageName == "pageMainCity" then
    self:onShowAllFastProductRewards()
  end
end

function this:getMaxCanProductNum(productId)
  local tpl = _productsTpl:getTplById(productId)
  local limit = _productsTpl:getNumberLimit(tpl)
  local material = _productsTpl:getMaterial(tpl)
  local minCanNum = math.maxinteger
  for i, v in pairs(material) do
    local hasNum = L_ItemTplManager:getItemNum(v[1], v[2], true)
    minCanNum = math.min(minCanNum, math.floor(hasNum / v[3]))
  end
  local count, limitCnt = self:getLimitForBuildingItem(productId)
  if limitCnt ~= nil then
    minCanNum = math.min(minCanNum, limitCnt - count)
    if minCanNum == 0 then
      minCanNum = 1
    end
  end
  local hadMax, maxNum = self:getIsExistMaxProductLimitByTpl(tpl)
  limit = hadMax and limit >= maxNum and maxNum or limit
  return math.min(minCanNum, limit)
end

function this:reqCancelProduct(buildingGuid, productGuid, callback)
  local pGuidList = {}
  table.insert(pGuidList, productGuid)
  L_ProductStore:req_CSProtoProductCancel(buildingGuid, pGuidList, function(errCode)
    if errCode == L_Const.errorCode.ErrCodeSucc then
      if callback then
        callback()
      end
    else
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_product_get_receive_first"))
    end
  end)
end

function this:reqCollectProduct(buildingGuid, callback, ignoreShowReward, tipCallBack)
  local checkCurrencyExceed = true
  if checkCurrencyExceed then
    local queueDataList = L_ProductManager:getProduceQueueForBuilding(buildingGuid)
    if queueDataList and next(queueDataList) ~= nil then
      local productIdList = {}
      local sendProductList = {}
      local finishNumList = {}
      local guidList = {}
      
      local function processCallback(rspData, errCode)
        if rspData then
          if callback then
            callback(rspData)
          end
          local csHomeBuildData = L_HomeStore:getCsHomeBuildDataByGuid(buildingGuid)
          local buildingId = csHomeBuildData.buildId
          local buildingCfg = _homeBuildingTpl:getTplById(buildingId)
          local groupId = _homeBuildingTpl:getGroupId(buildingCfg)
          L_ProductStore:call(L_ProductStore.event.productFinishGuide, groupId, sendProductList)
        end
      end
      
      for index, queueItemData in ipairs(queueDataList) do
        if queueItemData.isEmpty == false and queueItemData.csHomeBuildProductData and queueItemData.csHomeBuildProductData.productId then
          local csHomeBuildProductData = queueItemData.csHomeBuildProductData
          local finishCount = csHomeBuildProductData.finishCount
          if 0 < finishCount and csHomeBuildProductData.productId then
            table.insert(productIdList, csHomeBuildProductData.productId)
            table.insert(sendProductList, csHomeBuildProductData.productId)
            table.insert(finishNumList, finishCount)
            table.insert(guidList, csHomeBuildProductData.guid)
          end
        end
      end
      local exceedIndexList = L_ProductStore:checkProductCurrencyNumExceed(productIdList, finishNumList)
      if next(exceedIndexList) ~= nil then
        local sendGuidList = {}
        sendProductList = {}
        for index, guid in ipairs(guidList) do
          if not exceedIndexList[index] then
            sendGuidList[#sendGuidList + 1] = guid
            sendProductList[#sendGuidList + 1] = productIdList[index]
          end
        end
        local data = {
          txtTitle = L_WordsTpl:getValue("notice_home_elementcurrencystore_reachlimit_title"),
          txtContent = L_WordsTpl:getValue("notice_home_elementcurrencystore_reachlimit"),
          confirmCallback = function(txt)
            if tipCallBack ~= nil then
              tipCallBack(false)
            end
            self:internalReqCSProtoProductFinish(buildingGuid, processCallback, ignoreShowReward)
          end,
          cancelCallback = function(txt)
            if tipCallBack ~= nil then
              tipCallBack(true, sendGuidList)
            end
            self:internalReqCSProtoProductFinish(buildingGuid, processCallback, ignoreShowReward, sendGuidList)
          end
        }
        L_GameUtil.showCommonTip(data)
      else
        if tipCallBack ~= nil then
          tipCallBack(false)
        end
        self:internalReqCSProtoProductFinish(buildingGuid, processCallback, ignoreShowReward)
      end
    end
  end
end

function this:internalReqCSProtoProductFinish(buildingGuid, callback, ignoreShowReward, sendGuidList)
  local function rspCallback(rspData, errCode)
    if errCode == L_Const.errorCode.ErrCodeSucc then
      self:playProductHarvestVoice(rspData.reward)
      
      if not ignoreShowReward then
        self:showProductFinishReward(rspData, false)
      end
      if callback then
        callback(rspData)
      end
    end
  end
  
  if sendGuidList ~= nil then
    L_ProductStore:req_CSProtoProductFinishByPGuidList(buildingGuid, sendGuidList, rspCallback)
  else
    L_ProductStore:req_CSProtoProductFinish(buildingGuid, rspCallback)
  end
end

function this:showProductFinishReward(rspData, ignoreQueueCheck)
  local reward
  rspData.reward.rewards = L_DataUtil.parseRewardConfig(rspData.reward.rewards, true, true, nil, true)
  if rspData.reward then
    reward = rspData.reward.rewards
  end
  local specialReward
  if rspData.special_reward then
    specialReward = rspData.special_reward.rewards
  end
  if not table.isEmpty(reward) then
    rspData.reward.ignoreQueueCheck = ignoreQueueCheck
    L_RewardManager:ShowReward(rspData.reward)
  end
  if not table.isEmpty(specialReward) then
    rspData.special_reward.ignoreQueueCheck = ignoreQueueCheck
    L_RewardManager:ShowReward(rspData.special_reward)
  end
end

function this:showPetFinishMsg(petGuid, protoRewards)
  local petData = L_PetStore:getPetItem(petGuid)
  local items = L_DataUtil.paresRewardProto(protoRewards)
  for _, item in ipairs(items) do
    local conf = L_ItemTplManager:getItemConfig(item.itemType, item.itemId)
    local showName = L_WordsTpl:getValue("notice_productManager", {
      [0] = petData.pet_name,
      [1] = conf.name
    })
    L_FlyMsgManager:showCommonRewardMsg(item.itemType, item.itemId, item.itemNum, showName)
    local eventData = {
      pet_id = petData.id,
      pet_guid = petGuid,
      item_id = item.itemId,
      item_num = item.itemNum,
      item_type = item.itemType
    }
    L_GameUtil.logEvent(L_Const.logEventName.pet_carry, eventData)
  end
end

function this:isProductRewarded(buildingGuid)
  local csHomeBuildingData = L_HomeStore:getCsHomeBuildDataByGuid(buildingGuid)
  if csHomeBuildingData.status:GetHashCode() ~= L_Const.WorldMapBuildStatusType.WMBST_PRODUCT then
    return
  end
  local csHomeBuildProductDataList = csHomeBuildingData.products
  if not csHomeBuildProductDataList or csHomeBuildProductDataList.Count == 0 then
    return
  end
  local csHomeBuildProductData = csHomeBuildProductDataList[0]
  local finishCount = csHomeBuildProductData.finishCount
  if 0 < finishCount then
    return true
  end
  return false
end

function this:checkProductBuildingPetSize(tpl, size)
  if not tpl then
    return false
  end
  local homeBuildingProductionTpl = L_GameTpl:getHomeBuildingProductionTpl()
  local petSizes = homeBuildingProductionTpl:getPetSize(tpl)
  for _, petSize in ipairs(petSizes) do
    if petSize == size then
      return true
    end
  end
  return false
end

function this:getMaxproduceQueueNum(buildingId)
  local homeBuildingTpl = L_GameTpl:getHomeBuildingTpl()
  local buildingCfg = homeBuildingTpl:getTplById(buildingId)
  while not math.isEmpty(homeBuildingTpl:getNextLevel(buildingCfg)) do
    buildingCfg = homeBuildingTpl:getTplById(homeBuildingTpl:getNextLevel(buildingCfg))
  end
  local maxBuildId = homeBuildingTpl:getId(buildingCfg)
  local homeBuildingProductionTpl = L_GameTpl:getHomeBuildingProductionTpl()
  local tpl = homeBuildingProductionTpl:getTplById(maxBuildId)
  local maxNum = tpl and homeBuildingProductionTpl:getProductionQueueNum(homeBuildingProductionTpl:getTplById(maxBuildId)) or 0
  return maxNum or 1
end

function this:checkQueueNumValid(buildingId, checkLevel)
  local currentQueueNum = _homeBuildingProductionTpl:getProductionQueueNum(_homeBuildingProductionTpl:getTplById(buildingId))
  if checkLevel <= currentQueueNum then
    return true
  end
  local buildingCfg = _homeBuildingTpl:getTplById(buildingId)
  local groupId = _homeBuildingTpl:getGroupId(buildingCfg)
  local groups = _homeBuildingTpl:getGroupData(groupId)
  for k, cfg in pairs(groups) do
    local id = _homeBuildingTpl:getId(cfg)
    local queueNum = _homeBuildingProductionTpl:getProductionQueueNum(_homeBuildingProductionTpl:getTplById(id))
    if checkLevel <= queueNum then
      return false, _homeBuildingTpl:getLevel(cfg)
    end
  end
  return false, L_Const.maxInt
end

function this:getProductRewardItemData(productId)
  if self.cachedProductRewardItemData[productId] ~= nil then
    return self.cachedProductRewardItemData[productId]
  end
  local tpl = _productsTpl:getTplById(productId)
  local reward = _productsTpl:getRewardId(tpl)
  if reward[1] then
    self.cachedProductRewardItemData[productId] = L_DataUtil.parseRewardConfigItem(reward[1])
  else
    self.cachedProductRewardItemData[productId] = nil
  end
  return self.cachedProductRewardItemData[productId]
end

function this:isBuildingOnProducing(buildingGuid)
  local csHomeBuildData = L_HomeStore:getCsHomeBuildDataByGuid(buildingGuid)
  return csHomeBuildData and csHomeBuildData.status:GetHashCode() == L_Const.WorldMapBuildStatusType.WMBST_PRODUCT
end

function this:isBuildingHasPet(buildingGuid)
  local csHomeBuildData = L_HomeStore:getCsHomeBuildDataByGuid(buildingGuid)
  return not math.isEmpty(csHomeBuildData.petGuid)
end

function this:getProduceQueueForBuilding(buildingGuid)
  local csHomeBuildData = L_HomeStore:getCsHomeBuildDataByGuid(buildingGuid)
  if not csHomeBuildData then
    return {}
  end
  local buildingId = csHomeBuildData.buildId
  local maxQueueNum = self:getMaxproduceQueueNum(buildingId)
  local queueData = {}
  local csHomeBuildProductDataList = csHomeBuildData.products
  for i = 1, maxQueueNum do
    local isUnlock, unlockLevel = self:checkQueueNumValid(buildingId, i)
    local isEmpty = i > csHomeBuildProductDataList.Count or math.isEmpty(csHomeBuildProductDataList[i - 1].productId)
    local weight = i * 100000000000
    local csHomeBuildProductData
    if not isEmpty then
      weight = csHomeBuildProductDataList[i - 1].guid
      csHomeBuildProductData = csHomeBuildProductDataList[i - 1]
    end
    table.insert(queueData, {
      index = i,
      isUnlock = isUnlock,
      unlockLevel = unlockLevel,
      csHomeBuildProductData = csHomeBuildProductData,
      isEmpty = isEmpty,
      buildingGuid = buildingGuid,
      buildingId = buildingId,
      weight = weight
    })
  end
  table.sort(queueData, function(a, b)
    return a.weight < b.weight
  end)
  return queueData
end

function this:getProductGuidBySpecialGuid(buildGuid, specialGuid)
  local csHomeBuildData = L_HomeStore:getCsHomeBuildDataByGuid(buildGuid)
  local csHomeBuildProductDataList = csHomeBuildData.products
  for i = 0, csHomeBuildProductDataList.Count - 1 do
    local csHomeBuildProductData = csHomeBuildProductDataList[i]
    if csHomeBuildProductData.specialGuid == specialGuid then
      return csHomeBuildProductData.guid
    end
  end
  return 0
end

function this:getProductByGuid(buildingGuid, productGuid)
  local csHomeBuildData = L_HomeStore:getCsHomeBuildDataByGuid(buildingGuid)
  if not csHomeBuildData then
    return nil
  end
  local csHomeBuildProductDataList = csHomeBuildData.products
  for i = 0, csHomeBuildProductDataList.Count - 1 do
    if csHomeBuildProductDataList[i].guid == productGuid then
      return csHomeBuildProductDataList[i]
    end
  end
  return nil
end

function this:getProductState(buildingGuid, productGuid)
  local csHomeBuildProductData = self:getProductByGuid(buildingGuid, productGuid)
  local csHomeBuildData = L_HomeStore:getCsHomeBuildDataByGuid(buildingGuid)
  if not csHomeBuildProductData then
    return L_HomeConst.ProductQueueState.NONE
  end
  local totalCount = csHomeBuildProductData.totalCount
  if totalCount == 0 then
    return L_HomeConst.ProductQueueState.FINISH
  else
    local nowTime = L_TimeUtil.getServerTimeWithFloor()
    local isWatting = csHomeBuildProductData.startTime == 0 or nowTime < csHomeBuildProductData.startTime
    if isWatting then
      local isEating = L_SatietyStore:isEating(0 < csHomeBuildData.stationedPetGuidList.Count and csHomeBuildData.stationedPetGuidList[0] or 0)
      if isEating then
        return L_HomeConst.ProductQueueState.PAUSE, isEating
      end
      local isSatietyPause = L_SatietyStore:isSatietyPause(buildingGuid, productGuid)
      if isSatietyPause then
        return L_HomeConst.ProductQueueState.PAUSE
      end
      return L_HomeConst.ProductQueueState.WAITING
    end
    return L_HomeConst.ProductQueueState.RUNNING
  end
end

function this:checkProduceQueueAvaliable(buildingGuid)
  local queueData = self:getProduceQueueForBuilding(buildingGuid)
  for k, queue in ipairs(queueData) do
    if queue.isEmpty and queue.isUnlock then
      return true
    end
  end
  return false
end

function this:getProductProduceInfo(buildingGuid, csHomeBuildProductData)
  local onceTime
  local buildType = C_HomeUtil.GetBuildingType(buildingGuid)
  if buildType == L_Const.WorldMapBuildType.WMBT_HATCH then
    onceTime = L_PetStore:getEggIncubationTime(L_PetStore:getPetEggItem(csHomeBuildProductData.specialGuid).configId, buildingGuid)
  else
    onceTime = self:getProduceOnceTime(buildingGuid, csHomeBuildProductData.productId)
  end
  if csHomeBuildProductData.startTime == 0 then
    return 0, csHomeBuildProductData.totalCount, 0
  end
  local nowTime = L_TimeUtil.getServerTimeWithFloor()
  local total = csHomeBuildProductData.totalCount + csHomeBuildProductData.finishCount
  if onceTime <= 0 then
    onceTime = tonumber(L_GameTpl:getGameConstTpl():getData("HOME_PROCESS_PRODUCT_TIME", L_Const.GameTplType.int))
  end
  if L_SatietyStore:isBuildingPause(buildingGuid) then
    return csHomeBuildProductData.finishCount, total, csHomeBuildProductData.finishCount / total
  end
  return csHomeBuildProductData.finishCount, total, math.min((csHomeBuildProductData.finishCount + (nowTime - csHomeBuildProductData.startTime) / onceTime) / total, 1)
end

local ProductProduceTimeConditions = {
  [L_HomeConst.buffConditionType.PRODUCT_TYPE] = 1
}
local ProductProduceTimeParams = {petGuid = 0}

function this:getProduceOnceTimeWithPetGuid(buildingGuid, productId, isProduct, previewPetGuid)
  local csHomeBuildData = L_HomeStore:getCsHomeBuildDataByGuid(buildingGuid)
  local homeBuildingProductionTpl = L_GameTpl:getHomeBuildingProductionTpl()
  local tpl = homeBuildingProductionTpl:getTplById(csHomeBuildData.buildId)
  local type = homeBuildingProductionTpl:getType(tpl)
  local laborType = homeBuildingProductionTpl:getLaborType(tpl)
  ProductProduceTimeConditions[L_HomeConst.buffConditionType.PRODUCT_TYPE] = type
  ProductProduceTimeParams.petGuid = previewPetGuid
  ProductProduceTimeParams.laborType = laborType
  ProductProduceTimeParams.isProduct = isProduct
  ProductProduceTimeParams.buildType = csHomeBuildData:GetGroupConfig().type
  csHomeBuildData = nil
  local petData = previewPetGuid and L_PetStore:getPetItem(previewPetGuid)
  if petData and petData.talent_id then
    ProductProduceTimeParams.talentIds = petData.talent_id
  else
    ProductProduceTimeParams.talentIds = nil
  end
  return L_HomeBuffManager:getProductProduceTime(productId, ProductProduceTimeConditions, ProductProduceTimeParams)
end

function this:getProduceOnceTime(buildingGuid, productId, isProduct)
  self.cachedProduceOnceTime[buildingGuid] = self.cachedProduceOnceTime[buildingGuid] or {}
  if self.cachedProduceOnceTime[buildingGuid][productId] ~= nil and not isProduct then
    return self.cachedProduceOnceTime[buildingGuid][productId]
  end
  local csHomeBuildData = L_HomeStore:getCsHomeBuildDataByGuid(buildingGuid)
  local homeBuildingProductionTpl = L_GameTpl:getHomeBuildingProductionTpl()
  local tpl = homeBuildingProductionTpl:getTplById(csHomeBuildData.buildId)
  local type = homeBuildingProductionTpl:getType(tpl)
  local laborType = homeBuildingProductionTpl:getLaborType(tpl)
  local petGuid = csHomeBuildData.petGuid
  ProductProduceTimeConditions[L_HomeConst.buffConditionType.PRODUCT_TYPE] = type
  ProductProduceTimeParams.petGuid = petGuid
  ProductProduceTimeParams.laborType = laborType
  ProductProduceTimeParams.isProduct = isProduct
  ProductProduceTimeParams.buildType = csHomeBuildData:GetGroupConfig().type
  csHomeBuildData = nil
  local petData = petGuid and L_PetStore:getPetItem(petGuid)
  if petData and petData.talent_id then
    ProductProduceTimeParams.talentIds = petData.talent_id
  else
    ProductProduceTimeParams.talentIds = nil
  end
  self.cachedProduceOnceTime[buildingGuid][productId] = L_HomeBuffManager:getProductProduceTime(productId, ProductProduceTimeConditions, ProductProduceTimeParams)
  return self.cachedProduceOnceTime[buildingGuid][productId]
end

function this:getFastProduceOnceTime(productId)
  local productTpl = _productsTpl:getTplById(productId)
  if not productTpl then
    errorf("无效的 product ID: " .. tostring(productId))
    return 0
  end
  local onceTime = _productsTpl:getTime(productTpl)
  return onceTime
end

function this:getIsExistMaxProductLimitById(productId, excludeQueue)
  local productTpl = _productsTpl:getTplById(productId)
  local isHadMax, canProductMaxNum = self:getIsExistMaxProductLimitByTpl(productTpl, excludeQueue)
  return isHadMax, canProductMaxNum
end

function this:getIsExistMaxProductLimitByTpl(productTpl, excludeQueue)
  if excludeQueue == nil then
    excludeQueue = true
  end
  local canProductMaxNum = 0
  local isHadMax, maxNum = _productsTpl:getMaxProductNum(productTpl)
  if isHadMax then
    local productId = _productsTpl:getId(productTpl)
    local hadProductedNum = L_ProductStore:getHadProductRecordNumById(productId)
    if maxNum > hadProductedNum then
      canProductMaxNum = maxNum - hadProductedNum
    end
    if 0 < canProductMaxNum and not excludeQueue then
      local queueNum = csHomeStore:GetHadNumWithProductQueueByProductId(productId)
      canProductMaxNum = canProductMaxNum - queueNum
    end
  end
  return isHadMax, canProductMaxNum
end

function this:getProductDataListForPageProduct(buildingId, tabId)
  local productConfigDataList = L_CommonUtil.deepClone(self:getProductConfigDataListForPageProductByBuildingIdTabId(buildingId, tabId))
  local productDataList = self:getProductDataListForPageProductByProductConfigDataList(productConfigDataList)
  return productDataList
end

function this:getProductConfigDataListForPageProductByBuildingIdTabId(buildingId, tabId)
  if tabId == nil then
    tabId = -1
  end
  local productConfigDataList
  self.cachedBuildingIdAndTabId2ProductConfigDataList[buildingId] = self.cachedBuildingIdAndTabId2ProductConfigDataList[buildingId] or {}
  self.cachedBuildingIdAndTabId2ProductConfigDataList[buildingId][tabId] = self.cachedBuildingIdAndTabId2ProductConfigDataList[buildingId][tabId] or {}
  if not table.isEmpty(self.cachedBuildingIdAndTabId2ProductConfigDataList[buildingId][tabId]) then
    productConfigDataList = self.cachedBuildingIdAndTabId2ProductConfigDataList[buildingId][tabId]
    return productConfigDataList
  end
  local homeBuildingProductionTpl = _homeBuildingProductionTpl:getTplById(buildingId)
  local buildingProductionGroup = _homeBuildingProductionTpl:getGroupId(homeBuildingProductionTpl)
  if buildingProductionGroup == 0 then
    self.cachedBuildingIdAndTabId2ProductConfigDataList[buildingId][tabId] = {}
    productConfigDataList = self.cachedBuildingIdAndTabId2ProductConfigDataList[buildingId][tabId]
    return productConfigDataList
  end
  productConfigDataList = {}
  local productsTplList = _productsTpl:getTplsByGroup(buildingProductionGroup)
  self:collectSingleQualityProductConfigData(productConfigDataList, {
    buildingId = buildingId,
    tabId = tabId,
    productsTplList = productsTplList
  })
  self:collectMultiQualityProductConfigData(productConfigDataList, {buildingId = buildingId, tabId = tabId})
  self.cachedBuildingIdAndTabId2ProductConfigDataList[buildingId][tabId] = productConfigDataList
  return productConfigDataList
end

function this:collectSingleQualityProductConfigData(productConfigDataList, params)
  local buildingId = params.buildingId
  local tabId = params.tabId
  local productsTplList = params.productsTplList
  local homeBuildingTpl = _homeBuildingTpl:getTplById(buildingId)
  local homeBuildingCurLevel = _homeBuildingTpl:getLevel(homeBuildingTpl)
  for _, productsTpl in pairs(productsTplList) do
    if self:checkIsSingleQualityProduct(productsTpl) then
      local productTabId = _productsTpl:getTabId(productsTpl)
      if tabId == -1 or tabId == L_Const.FoodProductConst.all or tabId == L_Const.FoodProductConst.recent or tabId == productTabId then
        local productId = _productsTpl:getId(productsTpl)
        local reward = _productsTpl:getRewardId(productsTpl)
        local itemData = L_DataUtil.parseRewardConfigItem(reward[1])
        local itemParse = L_ItemTplManager:getItemConfig(itemData.itemType, itemData.itemId)
        local isNeedPet = _productsTpl:getIsNeedPet(productsTpl)
        table.insert(productConfigDataList, {
          id = productId,
          quality = itemParse.quality,
          productId = productId,
          lockIconActive = false,
          unlockText = L_WordsTpl:getValue("home_product_unlock_condition", {
            [0] = 0
          }),
          petNeededIconActive = isNeedPet,
          itemData = itemData,
          itemName = itemParse.name,
          buildingId = buildingId,
          tabId = tabId,
          isLock = false
        })
      end
    end
  end
end

function this:checkIsSingleQualityProduct(productsTpl)
  local material = _productsTpl:getMaterial(productsTpl)
  if material ~= nil and not table.isEmpty(material) then
    return true
  end
  local materialSelectList = _productsTpl:getMaterialSelectList(productsTpl)
  if materialSelectList ~= nil and not table.isEmpty(materialSelectList) then
    return true
  end
  return false
end

function this:collectMultiQualityProductConfigData(productConfigDataList, params)
  local buildingId = params.buildingId
  local tabId = params.tabId
  local homeBuildingTpl = _homeBuildingTpl:getTplById(buildingId)
  local homeBuildingGroupId = _homeBuildingTpl:getGroupId(homeBuildingTpl)
  local homeBuildingCurLevel = _homeBuildingTpl:getLevel(homeBuildingTpl)
  for foodGroupId, foodGroupTpl in pairs(_foodGroupTpl.data) do
    local needLv = _foodGroupTpl:getUnlockLevel(foodGroupTpl)
    if needLv[homeBuildingGroupId] ~= nil and not (homeBuildingCurLevel < needLv[homeBuildingGroupId]) then
      if tabId == -1 then
      elseif tabId == L_Const.FoodProductConst.all then
      elseif tabId == L_Const.FoodProductConst.recent then
      elseif tabId == L_Const.FoodProductConst.satiety and _foodGroupTpl:getFoodType(foodGroupTpl) == 1 then
      elseif tabId == L_Const.FoodProductConst.attack and _foodGroupTpl:getFoodType(foodGroupTpl) == 4 then
      elseif tabId == L_Const.FoodProductConst.defend and _foodGroupTpl:getFoodType(foodGroupTpl) == 3 then
        goto lbl_81
        goto lbl_140
        ::lbl_81::
        local foodId = _productsMultiQualityTpl:getItemIdListByFoodGroupId(foodGroupId)[1]
        local commonItemTpl = _commonItemTpl:getTplById(foodId)
        if commonItemTpl then
          local quality = _commonItemTpl:getRarity(commonItemTpl)
          table.insert(productConfigDataList, {
            isFood = true,
            id = foodGroupId,
            quality = quality,
            foodGroupId = foodGroupId,
            productIdList = _productsMultiQualityTpl:getProductIdListByFoodGroupId(foodGroupId),
            lockIconActive = homeBuildingCurLevel < (needLv[homeBuildingGroupId] or 0),
            unlockText = L_WordsTpl:getValue("home_product_unlock_condition", {
              [0] = needLv[homeBuildingGroupId]
            }),
            petNeededIconActive = _productsTpl:getIsNeedPet(foodGroupTpl),
            itemName = _foodGroupTpl:getName(foodGroupTpl),
            buildingId = buildingId,
            tabId = tabId,
            isLock = false
          })
        end
      end
    end
    ::lbl_140::
  end
end

function this:getProductDataListForPageProductByProductConfigDataList(productConfigDataList)
  local targetProductConfigDataList = {}
  for _, productConfigData in ipairs(productConfigDataList) do
    local ableToShow, isComplete = self:checkAbleToShow(productConfigData, false)
    if ableToShow then
      productConfigData.isLock = not isComplete
      local tabId = productConfigData.tabId
      if tabId == L_Const.FoodProductConst.recent then
        local isRecentProduct = self:checkIsRecentProduct(productConfigData)
        if not isRecentProduct then
          goto lbl_30
        end
      end
      table.insert(targetProductConfigDataList, productConfigData)
    end
    ::lbl_30::
  end
  for _, productConfigData in ipairs(targetProductConfigDataList) do
    if not productConfigData.isFood then
      self:setDynamicData2SingleQualityProductConfigData(productConfigData)
    else
      self:setDynamicData2MultiQualityProductConfigData(productConfigData)
    end
    productConfigData.isGray = productConfigData.isGray or productConfigData.isLock
  end
  self:sortProductDataListForPageProduct(targetProductConfigDataList)
  local productDataList = targetProductConfigDataList
  return productDataList
end

function this:getConditionTechTreeId(productId)
  local productsTpl = _productsTpl:getTplById(productId)
  if productsTpl == nil then
    return 0
  else
    local condition = _productsTpl:getUnlockCondition(productsTpl)
    for i, v in ipairs(condition) do
      if v[1] == 11012 then
        return v[2]
      end
    end
    return 0
  end
end

function this:checkIsUnlockConditionComplete(productConfigData)
  local productId
  if not productConfigData.isFood then
    productId = productConfigData.id
  else
    if productConfigData.productIdList == nil then
      C_MJLog.LogError(string.format("products_multi_quality没有对应配置, foodGroupId: %d", productConfigData.id))
      return false
    end
    productId = productConfigData.productIdList[1]
  end
  local productsTpl = _productsTpl:getTplById(productId)
  if productsTpl == nil then
    C_MJLog.LogError(string.format("productId:%d 没配置", productId))
    return false
  end
  local condition = _productsTpl:getUnlockCondition(productsTpl)
  local isComplete, _ = L_ConditionManager:isComplete(condition)
  return isComplete
end

function this:checkAbleToShow(productConfigData, isQuickProduct)
  local isComplete = false
  if isQuickProduct then
    isComplete = L_ConditionManager:isComplete(productConfigData.unlockCondition)
  else
    isComplete = self:checkIsUnlockConditionComplete(productConfigData)
  end
  local isUnlockable = false
  if not productConfigData.isFood then
    isUnlockable = CS.Lens.Gameplay.UI.TechnologyStore.GetStore():IsProductUnlockable(productConfigData.productId)
  else
    isUnlockable = CS.Lens.Gameplay.UI.TechnologyStore.GetStore():IsProductUnlockable(productConfigData.productIdList[1])
  end
  local show = isComplete or isUnlockable
  if show then
    local productId
    if isQuickProduct then
      productId = productConfigData.productId
    elseif not productConfigData.isFood then
      productId = productConfigData.id
    else
      productId = productConfigData.productIdList[1]
    end
    local isHadMax, canProductMaxNum = self:getIsExistMaxProductLimitById(productId)
    if isHadMax and canProductMaxNum <= 0 then
      local productTpl = _productsTpl:getTplById(productId)
      local rewardList = productTpl and _productsTpl:getRewardId(productTpl)
      local reward = rewardList and L_DataUtil.parseRewardConfigItem(rewardList[1])
      if reward and reward.itemType == L_Const.resType.commonItem then
        show = false
      end
    end
  end
  return show, isComplete
end

function this:checkIsRecentProduct(productConfigData)
  local buildingId = productConfigData.buildingId
  local homeBuildingTpl = _homeBuildingTpl:getTplById(buildingId)
  local groupId = _homeBuildingTpl:getGroupId(homeBuildingTpl)
  local buildingGuid = AzurWorld.HomeMgr:GetHomeStore():GetMaxLvBuildIdByGroup(groupId)
  local productList = csHomeStore:GetRecentProductData(buildingGuid)
  if not productList then
    return false
  end
  if not productConfigData.isFood then
    local productId = productConfigData.id
    for i = 0, productList.Count - 1 do
      if productId == productList[i] then
        return true
      end
    end
  else
    local productIdList = productConfigData.productIdList
    for i = 0, productList.Count - 1 do
      if table.containsValue(productIdList, productList[i]) then
        return true
      end
    end
  end
  return false
end

function this:setDynamicData2SingleQualityProductConfigData(productConfigData)
  local productId = productConfigData.id
  local productsTpl = _productsTpl:getTplById(productId)
  local reward = _productsTpl:getRewardId(productsTpl)
  local itemData = L_DataUtil.parseRewardConfigItem(reward[1])
  local isHomeBuildingNumOverLimit = false
  if itemData.itemType == L_Const.resType.homeBuilding then
    local tplBuilding = _homeBuildingTpl:getTplById(itemData.itemId)
    local itemGroupId = _homeBuildingTpl:getGroupId(tplBuilding)
    local limitCnt = L_HomeStore:getBuildingLimitCount(itemGroupId)
    local count = L_HomeStore:getCurNumByBuildingGroupId(itemGroupId)
    if limitCnt then
      isHomeBuildingNumOverLimit = limitCnt <= count
    end
  end
  local isHasMountSaddle = false
  if itemData.itemType == L_Const.resType.mountSaddle then
    isHasMountSaddle = AzurWorld.mountMgr:GetIdMountSaddleUnlock(itemData.itemId) == true
  end
  local isOtherTypeProductNumOverLimit = false
  local isHadMax, canProductMaxNum = L_ProductManager:getIsExistMaxProductLimitById(productId)
  if isHadMax and canProductMaxNum <= 0 then
    isOtherTypeProductNumOverLimit = true
  end
  local isAllMaterialEnough = true
  local material = _productsTpl:getMaterial(productsTpl)
  if material ~= nil and not table.isEmpty(material) and not self:isMaterialEnough(material) then
    isAllMaterialEnough = false
  end
  local materialSelectList = _productsTpl:getMaterialSelectList(productsTpl)
  if materialSelectList ~= nil and not table.isEmpty(materialSelectList) then
    for _, materialGroupId in ipairs(materialSelectList) do
      local isCurGridMaterialEnough = false
      local groupData = table.clone(_productsMaterialGroupTpl:getGroupDataByMaterialGroupId(materialGroupId))
      for _, v in ipairs(groupData) do
        local needNum = v.itemNum
        local curNum = L_ItemTplManager:getItemNum(v.itemType, v.itemId)
        if needNum <= curNum then
          isCurGridMaterialEnough = true
          break
        end
      end
      if not isCurGridMaterialEnough then
        isAllMaterialEnough = false
        break
      end
    end
  end
  productConfigData.overLimit = isHomeBuildingNumOverLimit
  productConfigData.isGray = not isAllMaterialEnough or isHomeBuildingNumOverLimit or isHasMountSaddle or isOtherTypeProductNumOverLimit
end

function this:GetProductGrayState(productId)
  local productsTpl = _productsTpl:getTplById(productId)
  if productsTpl == nil then
    return true
  end
  local reward = _productsTpl:getRewardId(productsTpl)
  local itemData = L_DataUtil.parseRewardConfigItem(reward[1])
  local isHomeBuildingNumOverLimit = false
  if itemData.itemType == L_Const.resType.homeBuilding then
    local tplBuilding = _homeBuildingTpl:getTplById(itemData.itemId)
    local itemGroupId = _homeBuildingTpl:getGroupId(tplBuilding)
    local limitCnt = L_HomeStore:getBuildingLimitCount(itemGroupId)
    local count = L_HomeStore:getCurNumByBuildingGroupId(itemGroupId)
    if limitCnt then
      isHomeBuildingNumOverLimit = limitCnt <= count
    end
  end
  local isHasMountSaddle = false
  if itemData.itemType == L_Const.resType.mountSaddle then
    isHasMountSaddle = AzurWorld.mountMgr:GetIdMountSaddleUnlock(itemData.itemId) == true
  end
  local isOtherTypeProductNumOverLimit = false
  local isHadMax, canProductMaxNum = L_ProductManager:getIsExistMaxProductLimitById(productId)
  if isHadMax and canProductMaxNum <= 0 then
    isOtherTypeProductNumOverLimit = true
  end
  local isAllMaterialEnough = true
  local material = _productsTpl:getMaterial(productsTpl)
  if material ~= nil and not table.isEmpty(material) and not self:isMaterialEnough(material) then
    isAllMaterialEnough = false
  end
  local materialSelectList = _productsTpl:getMaterialSelectList(productsTpl)
  if materialSelectList ~= nil and not table.isEmpty(materialSelectList) then
    for _, materialGroupId in ipairs(materialSelectList) do
      local isCurGridMaterialEnough = false
      local groupData = table.clone(_productsMaterialGroupTpl:getGroupDataByMaterialGroupId(materialGroupId))
      for _, v in ipairs(groupData) do
        local needNum = v.itemNum
        local curNum = L_ItemTplManager:getItemNum(v.itemType, v.itemId)
        if needNum <= curNum then
          isCurGridMaterialEnough = true
          break
        end
      end
      if not isCurGridMaterialEnough then
        isAllMaterialEnough = false
        break
      end
    end
  end
  local isGray = not isAllMaterialEnough or isHomeBuildingNumOverLimit or isHasMountSaddle or isOtherTypeProductNumOverLimit
  return isGray
end

function this:setDynamicData2MultiQualityProductConfigData(productConfigData)
  local foodGroupId = productConfigData.foodGroupId
  local isFoodMaterialEnough = self:isFoodMaterialEnough(foodGroupId)
  productConfigData.isGray = not isFoodMaterialEnough
end

function this:sortProductDataListForPageProduct(productConfigDataList)
  table.sort(productConfigDataList, function(a, b)
    if a.isLock ~= b.isLock then
      return not a.isLock
    end
    if a.isGray ~= b.isGray then
      return not a.isGray
    end
    if not a.isFood and not b.isFood then
      return self:singleProductDataSortFunc(a, b)
    elseif not a.isFood and b.isFood then
      return true
    elseif a.isFood and not b.isFood then
      return false
    elseif a.isFood and b.isFood then
      return self:multiProductDataSortFunc(a, b)
    end
  end)
  self:specialSortProductDatas(productConfigDataList)
end

function this:singleProductDataSortFunc(a, b)
  if a.quality ~= b.quality then
    return a.quality < b.quality
  elseif a.overLimit ~= b.overLimit then
    return not a.overLimit
  elseif a.lockIconActive ~= b.lockIconActive then
    return not a.lockIconActive
  else
    return a.id < b.id
  end
end

function this:multiProductDataSortFunc(a, b)
  if a.quality ~= b.quality then
    return a.quality < b.quality
  elseif a.lockIconActive ~= b.lockIconActive then
    return not a.lockIconActive
  else
    return a.id < b.id
  end
end

function this:specialSortProductDatas(targetProductDatas)
  local frontList = {}
  local endList = {}
  for _, targetProductData in ipairs(targetProductDatas) do
    if targetProductData.itemData and targetProductData.itemData.itemType then
      local targetProductItemType = targetProductData.itemData.itemType
      local funcName = ProductItemType2InsertEndCheckFuncName[targetProductItemType]
      local isNeedInsertEnd = false
      if funcName then
        isNeedInsertEnd = self[funcName](self, targetProductData)
      end
      if isNeedInsertEnd == false then
        table.insert(frontList, targetProductData)
      else
        table.insert(endList, targetProductData)
      end
    else
      table.insert(frontList, targetProductData)
    end
  end
  if #endList == 0 then
    return
  end
  for i = #targetProductDatas, 1, -1 do
    targetProductDatas[i] = nil
  end
  for _, productData in ipairs(frontList) do
    table.insert(targetProductDatas, productData)
  end
  for _, productData in ipairs(endList) do
    table.insert(targetProductDatas, productData)
  end
end

function this:isAccessoryMaterialEnough(productId)
  local tpl = _productsTpl:getTplById(productId)
  if not tpl then
    return true
  end
  local fixedMaterialList = _productsTpl:getMaterial(tpl)
  local materialSelectList = _productsTpl:getMaterialSelectList(tpl)
  local groupDataList = {}
  for _, materialGroupId in ipairs(materialSelectList) do
    local groupData = table.clone(_productsMaterialGroupTpl:getGroupDataByMaterialGroupId(materialGroupId))
    table.insert(groupDataList, groupData)
  end
  local index = 0
  for _, groupData in ipairs(groupDataList) do
    index = index + 1
    if 4 < index then
      break
    end
    local isAnyItemEnough = false
    for k, v in ipairs(groupData) do
      local needNum = v.itemNum
      local curNum = L_ItemTplManager:getItemNum(v.itemType, v.itemId)
      if needNum <= curNum then
        isAnyItemEnough = true
      end
    end
    if not isAnyItemEnough then
      return false
    end
  end
  for i, v in ipairs(fixedMaterialList) do
    index = index + 1
    if 4 < index then
      break
    end
    local reward = L_DataUtil.parseRewardConfigItem(v)
    if reward.itemType ~= L_Const.resType.accessory then
      local needNum = reward.itemNum
      local hadNum = L_ItemTplManager:getItemNum(reward.itemType, reward.itemId)
      if needNum > hadNum then
        return false
      end
    end
  end
  for _, v in ipairs(fixedMaterialList) do
    local reward = L_DataUtil.parseRewardConfigItem(v)
    if reward.itemType == L_Const.resType.accessory then
      local itemId = reward.itemId
      local guids = C_AccessoryMgr:getAccessoryGuidsById(itemId)
      if guids == nil or guids.Count == 0 then
        return false
      end
    end
  end
  return true
end

function this:isMaterialEnough(material)
  for k, v in ipairs(material) do
    local itemType = v[1]
    local itemId = v[2]
    local itemNum = L_ItemTplManager:getItemNum(itemType, itemId)
    if itemNum < v[3] then
      return false
    end
  end
  return true
end

function this:isFoodMaterialEnough(groupId)
  if not math.isEmpty(groupId) then
    local foodIdList = _productsMultiQualityTpl:getItemIdListByFoodGroupId(groupId)
    if foodIdList then
      local foodId = foodIdList[1]
      local materials = _productsMultiQualityTpl:getNeedMaterialByConfigId(foodId)
      for x = 1, 4 do
        local material = materials[x]
        if material then
          local materialGroupId = material[1]
          local needNum = material[2]
          local needRarity = material[3]
          local itemIds = _foodMaterialTpl:getGroupItemIds(materialGroupId)
          local anyItemEnough = false
          for k, v in ipairs(itemIds) do
            if k >= needRarity then
              local itemNum = C_BagMgr:getItemNumByItemId(v)
              if needNum <= itemNum then
                anyItemEnough = true
                break
              end
            end
          end
          if not anyItemEnough then
            return false
          end
        end
      end
    end
  end
  return true
end

function this:getLimitForBuildingItem(productId)
  local tpl_pro = _productsTpl:getTplById(productId)
  local reward = _productsTpl:getRewardId(tpl_pro)
  if table.isEmpty(reward) then
    return
  end
  local itemData = L_DataUtil.parseRewardConfigItem(reward[1])
  if itemData.itemType ~= L_Const.resType.homeBuilding then
    return 0
  end
  local tplBuilding = _homeBuildingTpl:getTplById(itemData.itemId)
  local itemGroupId = _homeBuildingTpl:getGroupId(tplBuilding)
  local limitCnt = L_HomeStore:getBuildingLimitCount(itemGroupId)
  local count = L_HomeStore:getCurNumByBuildingGroupId(itemGroupId)
  return count, limitCnt
end

function this:preloadAllProductConfigDataForBuildingByCurHomeBuildingIdList()
  table.clear(self.curBuildingIdList)
  local csHomeBuildDataList = L_HomeStore:getAllCsHomeBuildData()
  for _, csHomeBuildData in ipairs(csHomeBuildDataList) do
    local buildingId = csHomeBuildData.buildId
    table.insert(self.curBuildingIdList, buildingId)
  end
  for _, buildingId in pairs(self.curBuildingIdList) do
    self:preloadAllProductConfigForBuilding(buildingId)
  end
end

function this:preloadAllProductConfigForBuilding(buildingId)
  local homeBuildingProductionTpl = _homeBuildingProductionTpl:getTplById(buildingId)
  if homeBuildingProductionTpl == nil then
    return
  end
  local tabIdCount = 0
  local tableTabs = _homeBuildingProductionTpl:getTab(homeBuildingProductionTpl)
  for _, tabId in ipairs(tableTabs) do
    tabIdCount = tabIdCount + 1
    self:getProductConfigDataListForPageProductByBuildingIdTabId(buildingId, tabId)
  end
  if tabIdCount == 0 then
    self:getProductConfigDataListForPageProductByBuildingIdTabId(buildingId, nil)
  end
end

function this:checkBuildingIdIsBuild(targetBuildingId, curHomeBuildingIdList)
  for _, buildingId in pairs(curHomeBuildingIdList) do
    if targetBuildingId == buildingId then
      return true
    end
  end
  return false
end

function this:getIsHomeWorkBuildingNeedPet(buildingGuid)
  if math.isEmpty(buildingGuid) then
    return false
  end
  local csHomeBuildData = L_HomeStore:getCsHomeBuildDataByGuid(buildingGuid)
  local tpl_proBuilding = _homeBuildingProductionTpl:getTplById(csHomeBuildData.buildId)
  if not tpl_proBuilding then
    return false
  end
  local csHomeBuildProductDataList = csHomeBuildData.products
  for i = 0, csHomeBuildProductDataList.Count - 1 do
    local csHomeBuildProductData = csHomeBuildProductDataList[i]
    local tpl_pro = _productsTpl:getTplById(csHomeBuildProductData.productId, false)
    if tpl_pro and _productsTpl:getIsNeedPet(tpl_pro) then
      return true
    end
  end
  return false
end

function this:preloadQuickProductConfigData()
  if self.cachedQuickProductConfigDataList ~= nil and not table.isEmpty(self.cachedQuickProductConfigDataList) then
    return
  end
  local configList = _productsTpl:getConfig()
  local dataList = {}
  for _, value in pairs(configList) do
    if value.isQuickProduct then
      local productId = value.id
      local rewardInfo = value.rewardId[1]
      local rewardItemType = rewardInfo[1]
      local rewardItemId = rewardInfo[2]
      local itemConfig = L_ItemTplManager:getItemConfig(rewardItemType, rewardItemId)
      local productsTpl = _productsTpl:getTplById(productId)
      local sequenceQuickProduct = _productsTpl:getSequenceQuickProduct(productsTpl)
      local unlockCondition = value.unlockCondition
      local item = {
        productId = productId,
        itemId = rewardItemId,
        itemType = rewardItemType,
        sequenceQuickProduct = sequenceQuickProduct,
        unlockCondition = unlockCondition
      }
      table.insert(dataList, item)
    end
  end
  self.cachedQuickProductConfigDataList = dataList
end

function this:getQuickProductDataList()
  local quickProductDataList = {}
  self:preloadQuickProductConfigData()
  local quickProductConfigDataList = L_CommonUtil.deepClone(self.cachedQuickProductConfigDataList)
  for _, quickProductConfigData in pairs(quickProductConfigDataList) do
    local show, isComplete = self:checkAbleToShow(quickProductConfigData, true)
    if show then
      quickProductConfigData.isLock = not isComplete
      table.insert(quickProductDataList, quickProductConfigData)
    end
  end
  for _, quickProductData in pairs(quickProductDataList) do
    local productId = quickProductData.productId
    local productsTpl = _productsTpl:getTplById(productId)
    local maxProductCount = self:onGetMaxCountFastProduct(productId)
    if maxProductCount == 0 then
      local productTpl = _productsTpl:getTplById(productId)
      local isHadMax, maxNum = _productsTpl:getMaxProductNum(productTpl)
      if isHadMax then
        maxProductCount = maxNum
      end
    end
    quickProductData.maxCount = maxProductCount
    local hadNum = L_ProductManager:onGetAllFastProductCount(productId, false)
    local material = _productsTpl:getMaterial(productsTpl)
    local isMaterialEnough = self:isMaterialEnough(material)
    quickProductData.isGray = not isMaterialEnough or 0 < maxProductCount and maxProductCount <= hadNum or quickProductData.isLock
  end
  table.sort(quickProductDataList, function(a, b)
    if a.isLock ~= b.isLock then
      return not a.isLock
    end
    if a.isGray ~= b.isGray then
      return not a.isGray
    end
    if a.sequenceQuickProduct ~= b.sequenceQuickProduct then
      return a.sequenceQuickProduct > b.sequenceQuickProduct
    else
      return a.productId < b.productId
    end
  end)
  return quickProductDataList
end

function this:onGetHomeBuildFunctionType(buildGroupType)
  local type = L_HomeConst.HomeBuildFunctionType.PRODUCT
  if buildGroupType == L_HomeConst.HomeBuildGroupType.TABLE_CUISINE or buildGroupType == L_HomeConst.HomeBuildGroupType.SHOP_CUISINE then
    type = L_HomeConst.HomeBuildFunctionType.CUISINE
  elseif buildGroupType == L_HomeConst.HomeBuildGroupType.TABLE_WEAPON_STATION or buildGroupType == L_HomeConst.HomeBuildGroupType.TABLE_ARMOR or buildGroupType == L_HomeConst.HomeBuildGroupType.SHOP_FORGE or buildGroupType == L_HomeConst.HomeBuildGroupType.SHOP_ARMOR then
    type = L_HomeConst.HomeBuildFunctionType.EQUIP
  end
  return type
end

function this:onIsHadIdleQueueWithFastProduct()
  local productGuid2CsFastProductDataDic = L_ProductStore:getFastProductMap()
  if productGuid2CsFastProductDataDic.Count < 4 then
    return true
  end
  return false
end

function this:onShowAllFastProductRewards(isForce)
  local curPageName = L_UI:currentPage(L_UI.groupKeys.stack)
  if not isForce and curPageName ~= "pageMainCity" then
    return
  end
  local csRewardsList = L_ProductStore:getFastProductRewards()
  if csRewardsList == nil or csRewardsList.Count == 0 then
    return
  end
  for i = 0, csRewardsList.Count - 1 do
    local csRewards = csRewardsList[i]
    L_RewardManager:ShowReward(csRewards)
  end
  L_ProductStore:clearFastProductRewards()
end

function this:onHadInFastProduct(productId)
  local productGuid2CsFastProductDataDic = L_ProductStore:getFastProductMap()
  if productGuid2CsFastProductDataDic == nil or productGuid2CsFastProductDataDic.Count == 0 then
    return false
  end
  for _, csFastProductData in pairs(productGuid2CsFastProductDataDic) do
    if csFastProductData.ProductId == productId then
      return true
    end
  end
  return false
end

function this:onGetMaxCountFastProduct(productId)
  local tpl = _productsTpl:getTplById(productId)
  local maxCount = 0
  local reward = _productsTpl:getRewardId(tpl)
  if not table.isEmpty(reward) then
    local itemData = L_DataUtil.parseRewardConfigItem(reward[1])
    if itemData.itemType == L_Const.resType.homeBuilding then
      local tplBuilding = _homeBuildingTpl:getTplById(itemData.itemId)
      local itemGroupId = _homeBuildingTpl:getGroupId(tplBuilding)
      maxCount = L_HomeStore:getBuildingLimitCount(itemGroupId)
    end
  end
  return maxCount
end

function this:onGetInFastProductCount(productId)
  local productGuid2CsFastProductDataDic = L_ProductStore:getFastProductMap()
  if productGuid2CsFastProductDataDic == nil or productGuid2CsFastProductDataDic.Count == 0 then
    return 0
  end
  local count = 0
  for _, csFastProductData in pairs(productGuid2CsFastProductDataDic) do
    if csFastProductData.ProductId == productId then
      count = count + csFastProductData.TotalCount
    end
  end
  return count
end

function this:onGetAllFastProductCount(productId, inProduct)
  local tpl = _productsTpl:getTplById(productId)
  local reward = _productsTpl:getRewardId(tpl)
  if table.isEmpty(reward) then
    return 0
  end
  local itemData = L_DataUtil.parseRewardConfigItem(reward[1])
  local hadCount = 0
  if itemData.itemType == L_Const.resType.homeBuilding then
    local tplBuilding = _homeBuildingTpl:getTplById(itemData.itemId)
    local itemGroupId = _homeBuildingTpl:getGroupId(tplBuilding)
    hadCount = L_HomeStore:getCurNumByBuildingGroupId(itemGroupId)
  else
    hadCount = L_ItemTplManager:getItemNum(itemData.itemType, itemData.itemId)
  end
  if inProduct then
    local inProductNum = self:onGetInFastProductCount(productId)
    hadCount = hadCount + inProductNum
  end
  return hadCount
end

function this:playProductHarvestVoice(reward)
  if reward and not table.isEmpty(reward.rewards) then
    local rewards = reward.rewards
    local itemType
    for i, v in pairs(rewards) do
      itemType = v.itemtype
      break
    end
    if itemType then
      local voiceKey = ""
      local voiceIndex = 0
      if itemType == L_Const.resType.homeBuilding then
        voiceKey = "Home_ProductionDoneBuilding"
      elseif itemType == L_Const.resType.accessory then
        voiceKey = "Home_ProductionDoneEquipment"
      elseif itemType == L_Const.resType.commonItem then
        local quality = 0
        for i, v in pairs(rewards) do
          local itemId = v.itemid
          local tpl = _commonItemTpl:getTplById(itemId)
          local type = _commonItemTpl:getType(tpl)
          if type ~= L_BagConst.bagItemType.food then
            voiceKey = "Home_ProductionDoneBuilding"
            break
          end
          voiceKey = "Home_ProductionDoneFood"
          quality = _productsMultiQualityTpl:containsConfigId(itemId) and _productsMultiQualityTpl:getProductRarityByConfigId(itemId) or 0
        end
        if voiceKey == "Home_ProductionDoneFood" then
          local voiceTpl = _SystemVoiceUnitruleTpl:getTplByKey(voiceKey)
          for i, v in pairs(_SystemVoiceUnitruleTpl:getEventParameters(voiceTpl)) do
            if v == quality then
              voiceIndex = i - 1
              break
            end
          end
        end
      end
      if not string.isEmpty(voiceKey) then
        C_AliveVoiceManager.PlayEntityVoice(voiceKey, true, voiceIndex)
      end
    end
  end
end

function this:checkIsNeedInsertEndSaddleType(saddleTypeProductData)
  local itemId = saddleTypeProductData.itemData.itemId
  local isHas = AzurWorld.mountMgr:GetIdMountSaddleUnlock(itemId)
  return isHas
end

function this:checkElementCurrencyExceed(buildingGuid)
  local queueDataList = L_ProductManager:getProduceQueueForBuilding(buildingGuid)
  if queueDataList and next(queueDataList) ~= nil then
    local productIdList = {}
    local finishNumList = {}
    for index, queueItemData in ipairs(queueDataList) do
      if queueItemData.isEmpty == false and queueItemData.csHomeBuildProductData and queueItemData.csHomeBuildProductData.productId then
        local csHomeBuildProductData = queueItemData.csHomeBuildProductData
        local finishCount = csHomeBuildProductData.finishCount
        if 0 < finishCount and csHomeBuildProductData.productId then
          table.insert(productIdList, csHomeBuildProductData.productId)
          table.insert(finishNumList, finishCount)
        end
      end
    end
    local exceedIndexList = L_ProductStore:checkProductCurrencyNumExceed(productIdList, finishNumList)
    if next(exceedIndexList) ~= nil then
      return true
    end
  end
  return false
end

function this:getProductSatietyScore(productId)
  local accessoryProductTpl = _accessoryProductTpl:getTplById(productId)
  if accessoryProductTpl then
    return _accessoryProductTpl:getSatietyScore(accessoryProductTpl)
  end
  local productTpl = _productsTpl:getTplById(productId)
  if productTpl then
    return _productsTpl:getSatietyScore(productTpl)
  end
  return 0
end

return this
