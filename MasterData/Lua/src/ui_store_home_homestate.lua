local this = {}
local _homeBuildingTpl = L_GameTpl:getHomeBuildingTpl()
local _productsTpl = L_GameTpl:getProductsTpl()
local _homeBuildingGroupTpl = L_GameTpl:getHomeBuildingGroupTpl()
local _BlockTpl = L_GameTpl:getHomeBlockTpl()
local _homeFreeWorkPositionTpl = L_GameTpl:getHomeFreeWorkPositionTpl()

function this:init()
  this.super.init(self)
  self.data = {
    buildingBag = {},
    buildingDatas = {},
    currMapId = 0,
    oldBeltItems = {},
    beltItems = {},
    beltPage = {1, 1},
    homeName = "",
    tempUnlockBlock = {}
  }
end

function this:getHomeName()
  print("self.data.homeName", self.data.homeName, string.isEmpty(self.data.homeName))
  return string.isEmpty(self.data.homeName) and L_GameTpl:getWordsTpl():getTplById("ui_home_default_name") or self.data.homeName
end

function this:getBeltItems(type)
  local list = self.data.beltItems[type] or {}
  local count = #list
  local totalNum = self:getBeltTotalMaxNum()
  if count < totalNum then
    for i = count, totalNum do
      list[i] = 0
    end
  end
  return list
end

function this:getOldBeltItems(type)
  return self.data.oldBeltItems[type] or {}
end

function this:updateOldBeltItems(beltType)
  local function deepClone(object)
    local lookup_table = {}
    
    local function _copy(object)
      if type(object) ~= "table" then
        return object
      elseif lookup_table[object] then
        return lookup_table[object]
      end
      local new_table = {}
      lookup_table[object] = new_table
      for key, value in pairs(object) do
        new_table[_copy(key)] = _copy(value)
      end
      return setmetatable(new_table, getmetatable(object))
    end
    
    return _copy(object)
  end
  
  self.data.oldBeltItems[beltType] = deepClone(self.data.beltItems[beltType])
end

function this:getBeltPage(type)
  return self.data.beltPage[type]
end

function this:setBeltPage(type, num)
  if type == nil or self:getCurrHomeMainModeOfPlayer() == L_HomeConst.homeMainMode.NONE then
    return
  end
  local beltGridNum = self:getBeltMaxPage()
  self.data.beltPage[type] = (num - 1) % beltGridNum + 1
  self:call(self.event.refreshBelt)
end

function this:getBeltMaxPage()
  local pageNum = L_DeviceTpl:getIsPc() and L_GameConstTpl:getData("HOME_BELT_PAGE_PC", L_Const.GameTplType.int) or L_GameConstTpl:getData("HOME_BELT_PAGE_MOBILE", L_Const.GameTplType.int)
  return pageNum
end

function this:getBeltTotalMaxNum()
  local totalNumPc = L_GameConstTpl:getData("HOME_BELT_NUM_PC", L_Const.GameTplType.int)
  local totalGridMobile = L_GameConstTpl:getData("HOME_BELT_NUM_MOBILE", L_Const.GameTplType.int)
  local maxNum = totalNumPc > totalGridMobile and totalNumPc or totalGridMobile
  return maxNum
end

function this:getBeltTotalNum()
  local totalGridNum = L_DeviceTpl:getIsPc() and L_GameConstTpl:getData("HOME_BELT_NUM_PC", L_Const.GameTplType.int) or L_GameConstTpl:getData("HOME_BELT_NUM_MOBILE", L_Const.GameTplType.int)
  return totalGridNum
end

function this:getLineGridNum()
  local total = self:getBeltTotalNum()
  local pageNum = self:getBeltMaxPage()
  local lineGridNum = math.floor(total / pageNum)
  return lineGridNum
end

function this:getCurrHomeMainModeOfPlayer()
  local HomeMainMode = L_HomeConst.homeMainMode
  local currMode = HomeMainMode.NONE
  local currBlockId, currGridId = AzurWorld.HomeMgr:GetInteractBlockIdAndGridIdWithPlayerByOffset()
  local blockTpl = _BlockTpl:getTplById(currBlockId)
  if L_PlayerStore:getPlayerStatus() == L_Const.WorldMapPlayerStatusType.WMPST_NORMAL and blockTpl and _BlockTpl:getBlockType(blockTpl) == L_HomeConst.blockType.BUILD then
    local buildGuid = L_HomeManager:getCurrInteractId()
    local buildingEntity = AzurWorld.HomeMgr and AzurWorld.HomeMgr:GetHomeBuild(buildGuid)
    if buildingEntity and buildingEntity:GetStoreData():GetGroupConfig().type == 15 then
      currMode = HomeMainMode.CROP
    else
      currMode = C_HomeUtil.GetIsBlockUnlock(currBlockId) and HomeMainMode.BUILD or HomeMainMode.BUILD_LOCK
    end
  end
  return currMode
end

function this:getAllBagBuilding()
  return self.data.buildingBag
end

function this:getBuildingInBag(buildingId)
  return self.data.buildingBag[buildingId]
end

function this:getHomeBuildingByGuid(guid)
  return self.data.buildingDatas[guid]
end

function this:getHomeBuildingByConfigId(configId)
  local data
  for i, v in pairs(self.data.buildingDatas) do
    if v.build_id == configId then
      data = v
      break
    end
  end
  return data
end

function this:getTotalNumByBuildingId(buildingId)
  local building = self:getBuildingInBag(buildingId)
  return building and building.total_num or 0
end

function this:getCurNumByBuildingGroupId(groupId)
  local totalNum = 0
  local tpls = _homeBuildingTpl:getGroupData(groupId)
  for i, v in pairs(tpls) do
    totalNum = totalNum + self:getTotalNumByBuildingId(_homeBuildingTpl:getId(v))
  end
  local productsMap = L_ProductStore:getHomeProductMap()
  for _, csHomeBuildProductList in pairs(productsMap) do
    for i = 0, csHomeBuildProductList.Count - 1 do
      local csHomeBuildProduct = csHomeBuildProductList[i]
      local tpl_pro = _productsTpl:getTplById(csHomeBuildProduct.productId, false)
      if tpl_pro ~= nil then
        local reward = _productsTpl:getRewardId(tpl_pro)
        if reward[1] then
          local itemData = L_DataUtil.parseRewardConfigItem(reward[1])
          if itemData.itemType == L_Const.resType.homeBuilding then
            local tplBuilding = _homeBuildingTpl:getTplById(itemData.itemId)
            local itemGroupId = _homeBuildingTpl:getGroupId(tplBuilding)
            if groupId == itemGroupId then
              totalNum = totalNum + csHomeBuildProduct.totalCount + csHomeBuildProduct.finishCount
            end
          end
        end
      end
    end
  end
  return totalNum
end

function this:getBuildingDatasByBlockId(blockIndex)
  local res = {}
  for k, v in pairs(self.data.buildingDatas) do
    if v.locate.block_id == blockIndex then
      res[v.guid] = v
    end
  end
  return res
end

function this:getBlockIdList()
  return table.keys(L_GameTpl:getHomeBlockTpl().data)
end

function this:getStatusByGuid(guid)
  local homeBuilding = self:getHomeBuildingByGuid(guid)
  return homeBuilding.status
end

function this:getBuildingEndTime(guid)
  local buildData = self:getHomeBuildingByGuid(guid)
  local allTime
  if buildData.status == L_Const.WorldMapBuildStatusType.WMBST_BUILDING then
    allTime = _homeBuildingTpl:getTime(_homeBuildingTpl:getTplById(buildData.build_id))
  else
    allTime = _homeBuildingTpl:getTime(_homeBuildingTpl:getTplById(_homeBuildingTpl:getNextLevel(_homeBuildingTpl:getTplById(buildData.build_id))))
  end
  return allTime + buildData.start_time
end

function this:checkSetLimit(groupId)
  local limitSet = self:getBuildingLimitCount(groupId)
  if not limitSet then
    return true, nil, nil
  end
  local setCount = self:getCurNumByBuildingGroupId(groupId)
  return limitSet > setCount, setCount, limitSet
end

function this:getBuildingLimitCount(groupId)
  local buildingNumTpl = L_GameTpl:getHomeBuildingNumTpl()
  local num = 0
  local has = false
  for _, v in pairs(buildingNumTpl.data) do
    if buildingNumTpl:getGroupId(v) == groupId then
      has = true
      local upgradeCondition = buildingNumTpl:getUnlockCondition(v)
      local isSatisfy, _ = L_ConditionManager:isComplete(upgradeCondition)
      if isSatisfy then
        num = num + buildingNumTpl:getAddNum(v)
      end
    end
  end
  if has then
    return num
  end
end

function this:getHomeBuildingGroupId(bldId)
  local tbl = _homeBuildingTpl:getTplById(bldId)
  local groupId = 0
  if tbl ~= nil then
    groupId = _homeBuildingTpl:getGroupId(tbl)
  end
  return groupId
end

function this:getHomeBuildingUidsByGroupId(homeGroupId)
  local guids = {}
  for guid, v in pairs(self.data.buildingDatas) do
    if v.build_id ~= 0 then
      local groupId = self:getHomeBuildingGroupId(v.build_id)
      if groupId == homeGroupId then
        table.insert(guids, guid)
      end
    end
  end
  return guids
end

function this:getHomeBuildingLevel(bldGuid)
  local bldData = self:getHomeBuildingByGuid(bldGuid)
  local tbl = _homeBuildingTpl:getTplById(bldData.build_id)
  return _homeBuildingTpl:getLevel(tbl)
end

function this:getHomeBuildingName(bldGuid)
  local bldData = self:getHomeBuildingByGuid(bldGuid)
  local tpl = _homeBuildingTpl:getTplById(bldData.build_id)
  local groupId = _homeBuildingTpl:getGroupId(tpl)
  local tpl_buildingGroup = _homeBuildingGroupTpl:getTplById(groupId)
  return _homeBuildingGroupTpl:getName(tpl_buildingGroup)
end

function this:checkHomeBuildingMaxLv(bldGuid)
  local bldData = self:getHomeBuildingByGuid(bldGuid)
  if not bldData then
    return false
  end
  local tpl = _homeBuildingTpl:getTplById(bldData.build_id)
  return _homeBuildingTpl:getIsFullLevel(tpl)
end

function this:checkHomeBuildingNextLvIsMaxLv(bldGuid)
  local bldData = self:getHomeBuildingByGuid(bldGuid)
  if not bldData then
    return false
  end
  local tpl = _homeBuildingTpl:getTplById(bldData.build_id)
  local nextTpl = _homeBuildingTpl:getTplById(_homeBuildingTpl:getNextLevel(tpl))
  return _homeBuildingTpl:getIsFullLevel(nextTpl)
end

function this:getBuildingDatasByGroupId(groupId)
  local res = {}
  local buildingTpl = L_GameTpl:getHomeBuildingTpl()
  for _, v in pairs(self.data.buildingDatas) do
    if buildingTpl:checkHomeBuildingIdIsValid(v.build_id) then
      local tpl = buildingTpl:getTplById(v.build_id)
      if buildingTpl:getGroupId(tpl) == groupId then
        table.insert(res, v)
      end
    end
  end
  return res
end

function this:getBuildingUseNumByGroupId(groupId)
  local num = 0
  local buildingTpl = L_GameTpl:getHomeBuildingTpl()
  if groupId == L_HomeConst.HomeBuildGroupID.DRY_FARMLAND then
    local csHomeStore = self:getCsHomeStore()
    num = csHomeStore:GetBuildNumOfPlow()
  elseif groupId == L_HomeConst.HomeBuildGroupID.DRY_FERTILE_FARMLAND then
    local csHomeStore = self:getCsHomeStore()
    num = csHomeStore:GetBuildNumById(L_Const.HomeBuildingID.GOOD_FIELD_BULDING)
  else
    for _, v in pairs(self.data.buildingBag) do
      local tpl = buildingTpl:getTplById(v.build_id)
      if tpl and buildingTpl:getGroupId(tpl) == groupId then
        num = num + v.used_num
      end
    end
  end
  return num
end

function this:getTempUnlockBlock()
  local data = table.merge({}, self.data.tempUnlockBlock)
  self.data.tempUnlockBlock = {}
  return data
end

function this:getCsHomeStore()
  self.csHomeStore = self.csHomeStore or AzurWorld.HomeMgr:GetHomeStore()
  return self.csHomeStore
end

function this:getCsHomeStoreProductData()
  self.csHomeStore = self.csHomeStore or AzurWorld.HomeMgr:GetHomeStore()
  return self.csHomeStore:GetHomeStoreProductData()
end

function this:getCsHomeManager()
  return AzurWorld.HomeMgr
end

function this:getAllCsHomeBuildData()
  local csHomeStore = self:getCsHomeStore()
  local csHomeBuildDataDic = csHomeStore:GetBuildDatas()
  local result = {}
  for _, csHomeBuildData in pairs(csHomeBuildDataDic) do
    table.insert(result, csHomeBuildData)
  end
  return result
end

function this:getCsHomeBuildDataByGuid(buildingGuid)
  local csHomeStore = self:getCsHomeStore()
  return csHomeStore:GetBuildData(buildingGuid) or nil
end

function this:getHomeBuildingConfigId(csHomeBuildData)
  return csHomeBuildData:GetBuildingConfigId()
end

function this:getHomeBuildingType(csHomeBuildData)
  local buildingConfigId = self:getHomeBuildingConfigId(csHomeBuildData)
  local homeBuildingTpl = _homeBuildingTpl:getTplById(buildingConfigId)
  local groupId = _homeBuildingTpl:getGroupId(homeBuildingTpl)
  local homeBuildingGroupTpl = _homeBuildingGroupTpl:getTplById(groupId)
  local buildingType = _homeBuildingGroupTpl:getType(homeBuildingGroupTpl)
  return buildingType
end

function this:getHomeBuildingStationedPetGuidList(csHomeBuildData)
  local stationedPetGuidList = {}
  local csStationedPetGuidList = csHomeBuildData:GetStationedPetGuidList()
  for i = 0, csStationedPetGuidList.Count - 1 do
    local stationedPetGuid = csStationedPetGuidList[i]
    table.insert(stationedPetGuidList, stationedPetGuid)
  end
  return stationedPetGuidList
end

function this:getHomeBuildProductDataList(csHomeBuildData)
  local list = {}
  for i = 0, csHomeBuildData.products.Count - 1 do
    table.insert(list, csHomeBuildData.products[i])
  end
  return list
end

function this:getCsWorldCollectBuildDataByGuid(collectBuildId)
  local csHomeStore = self:getCsHomeStore()
  return csHomeStore.WorldCollectModule:OnGetDataByCollectBuildId(collectBuildId)
end

function this:getCsWorldCollectBuildDataByBuildGuid(buildingGuid)
  local csHomeStore = self:getCsHomeStore()
  return csHomeStore.WorldCollectModule:OnGetDataByBuildId(buildingGuid)
end

function this:getHomeHubStationedPetGuidList()
  local csHomeStore = self:getCsHomeStore()
  local homeHubStationedPetGuidList = csHomeStore:GetHomeHubStationedPetGuidList()
  local result = {}
  for i = 0, homeHubStationedPetGuidList.Count - 1 do
    local petGuid = homeHubStationedPetGuidList[i]
    table.insert(result, petGuid)
  end
  return result
end

function this:checkPetIsInHomeHub(petGuid)
  local homeHubStationedPetGuidList = self:getHomeHubStationedPetGuidList()
  for _, petGuidInHomeHub in pairs(homeHubStationedPetGuidList) do
    if petGuid == petGuidInHomeHub then
      return true
    end
  end
  return false
end

function this:getCurPetStationedNum()
  local csHomeStore = self:getCsHomeStore()
  local curPetStationedNum = csHomeStore:GetHomeHubStationedPetGuidList().Count
  return curPetStationedNum
end

function this:getUnlockedPetStationedNum()
  local unlockedPetStationedNum = 0
  local freeWorkPosId2UnlockConditionList = _homeFreeWorkPositionTpl:getFreeWorkPosId2UnlockConditionList()
  for freeWorkPositionId, unlockConditionList in pairs(freeWorkPosId2UnlockConditionList) do
    if L_ConditionManager:isComplete(unlockConditionList) and freeWorkPositionId > unlockedPetStationedNum then
      unlockedPetStationedNum = freeWorkPositionId
    end
  end
  return unlockedPetStationedNum
end

function this:getHomeHubWorkingBuildingInfoListByTabType(homeHubTabType)
  local csHomeStore = self:getCsHomeStore()
  local csHomeHubWorkingBuildingInfoList = csHomeStore:GetHomeHubWorkingBuildingInfoListByTabType(homeHubTabType)
  if csHomeHubWorkingBuildingInfoList == nil then
    return {}
  end
  local homeHubWorkingBuildingInfoList = {}
  for i = 0, csHomeHubWorkingBuildingInfoList.Count - 1 do
    local csHomeHubWorkingBuildingInfo = csHomeHubWorkingBuildingInfoList[i]
    local homeHubWorkingBuildingInfo = {}
    homeHubWorkingBuildingInfo.guid = csHomeHubWorkingBuildingInfo.guid
    homeHubWorkingBuildingInfo.index = csHomeHubWorkingBuildingInfo.index
    homeHubWorkingBuildingInfo.homeHubTabType = csHomeHubWorkingBuildingInfo.homeHubTabType:GetHashCode()
    table.insert(homeHubWorkingBuildingInfoList, homeHubWorkingBuildingInfo)
  end
  return homeHubWorkingBuildingInfoList
end

function this:updateBuildPetCanteenFood(guid, foodItems, isAdd)
  local buildData = self:getHomeBuildingByGuid(guid)
  if not (buildData and buildData.pet_canteen) or not buildData.pet_canteen.foods then
    return
  end
  for _, itemData in ipairs(foodItems) do
    local data, index = table.find(buildData.pet_canteen.foods, function(value)
      return value.itemid == itemData.itemid
    end)
    if isAdd then
      if not data then
        table.insert(buildData.pet_canteen.foods, itemData)
      else
        data.itemnum = data.itemnum + itemData.itemnum
      end
    elseif data then
      data.itemnum = math.max(0, data.itemnum - itemData.itemnum)
      if data.itemnum == 0 and index then
        table.remove(buildData.pet_canteen.foods, index)
      end
    end
  end
end

return this
