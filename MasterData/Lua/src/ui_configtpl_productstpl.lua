local this = class("productsTpl")

function this:init(config)
  self.data = config
  self._groupData = {}
  self._groupIds = {}
  self._rewardTypeMap = {}
  self._rewardProductMap = {}
  self._productRewardMap = {}
  self._rewardProductMapOld = {}
  for i, v in pairs(config) do
    if v.group ~= nil then
      for groupIndex, groupId in ipairs(v.group) do
        self._groupIds[groupId] = self._groupIds[groupId] or {}
        self._groupData[groupId] = self._groupData[groupId] or {}
        table.insert(self._groupData[groupId], v)
        table.insert(self._groupIds[groupId], i)
      end
    end
    if v.rewardId and v.rewardId[1] then
      self._rewardTypeMap[v.rewardId[1][1]] = self._rewardTypeMap[v.rewardId[1][1]] or {}
      table.insert(self._rewardTypeMap[v.rewardId[1][1]], v)
      if v.group ~= nil then
        for groupIndex, groupId in ipairs(v.group) do
          if self._rewardProductMap[groupId] == nil then
            self._rewardProductMap[groupId] = {}
          end
          self._rewardProductMap[groupId][v.rewardId[1][2]] = v.id
        end
      end
      self._rewardProductMapOld[v.rewardId[1][2]] = v.id
      self._productRewardMap[v.id] = v.rewardId[1][2]
    end
  end
  for _, tplList in pairs(self._rewardTypeMap) do
    table.sort(tplList, function(a, b)
      return a.id < b.id
    end)
  end
end

function this:generateTreeMapByIds(ids)
  local treeMap, posMap, height, depth = {}, {}, 0, 0
  local config = self.data
  for _, id in ipairs(ids) do
    local tempId = id
    while not math.isEmpty(tempId) do
      local parentId = config[tempId].postIdAccessory
      if treeMap[parentId] and table.keyOf(treeMap[parentId], tempId) then
        break
      end
      treeMap[parentId] = treeMap[parentId] or {}
      table.insert(treeMap[parentId], tempId)
      tempId = parentId
    end
  end
  for _, nodeIds in pairs(treeMap) do
    table.sort(nodeIds, function(a, b)
      return config[a].sequenceAccessory < config[b].sequenceAccessory
    end)
  end
  
  local function generateNodePos(id, startPos, currDepth)
    currDepth = currDepth + 1
    depth = math.max(currDepth, depth)
    local pos = startPos
    for index, subId in ipairs(treeMap[id] or {}) do
      pos = pos + (index ~= 1 and 1 or 0)
      posMap[subId] = pos
      height = math.max(height, pos)
      pos = generateNodePos(subId, pos, currDepth)
    end
    return pos
  end
  
  generateNodePos(0, 1, 0)
  return treeMap, posMap, height, depth
end

function this:generateWeaponStationMapByIds(ids)
  local configList = self.data
  local mapTreeList = {}
  local maxRow = 0
  local maxCol = 0
  local mapIdList = {}
  for _, id in ipairs(ids) do
    local config = configList[id]
    local item = {
      curRow = 0,
      curCol = 0,
      curProductId = 0,
      lastProductId = 0,
      nextProductId = 0
    }
    local targetRow = config.sequenceAccessory
    local targetCol = config.sequenceSortAccessory
    item.curRow = targetRow
    item.curCol = targetCol
    item.curProductId = id
    item.lastProductId = config.postIdAccessory
    if maxRow < targetRow then
      maxRow = targetRow
    end
    if maxCol < targetCol then
      maxCol = targetCol
    end
    mapTreeList[item.curRow] = mapTreeList[item.curRow] or {}
    mapTreeList[item.curRow][item.curCol] = item
    mapIdList[item.curProductId] = item
  end
  for _, value in pairs(mapIdList) do
    if value.lastProductId ~= nil and mapIdList[value.lastProductId] ~= nil then
      mapIdList[value.lastProductId].nextProductId = value.curProductId
    end
  end
  return mapTreeList, mapIdList, maxRow, maxCol
end

function this:getProductByGroupAndReward(groupId, rewardId)
  return self._rewardProductMap[groupId][rewardId]
end

function this:getRewardProductMap()
  return self._rewardProductMapOld
end

function this:getRewardProductMapById(mount_saddleId)
  return self._rewardProductMapOld[mount_saddleId] or 0
end

function this:getProductRewardMap()
  return self._productRewardMap
end

function this:getTplsByGroup(groupId)
  return self._groupData[groupId] or {}
end

function this:getIdsByGroup(groupId)
  return self._groupIds[groupId]
end

function this:getTplById(id, needLog)
  local tpl = self.data[id]
  if tpl == nil and needLog ~= false then
    errorf("没有找到对应的生产配置（Products）, id = " .. tostring(id))
    return
  end
  return tpl
end

function this:checkIfHasTargetProductId(id)
  local result = self.data[id] and true or false
  return result
end

function this:getNumberLimit(tpl)
  return tpl.numberLimit
end

function this:getCastCoin(tpl)
  return tpl.castCoin
end

function this:getCastCoinOne(tpl)
  if table.isEmpty(tpl.castCoin) then
    return 0
  end
  return tpl.castCoin[2]
end

function this:getMaterial(tpl)
  return tpl.material
end

function this:getId(tpl)
  return tpl.id
end

function this:getRewardId(tpl)
  return tpl.rewardId
end

function this:getUnlockType(tpl)
  return tpl.unlockType
end

function this:getTime(tpl)
  return tpl.time
end

function this:getType(tpl)
  return tpl.buffType
end

function this:getList(tpl)
  return tpl.list
end

function this:getTimesLimit(tpl)
  return tpl.timesLimit
end

function this:getConfig()
  return self.data
end

function this:getIsNeedMaster(tpl)
  return tpl.isNeedMaster
end

function this:getNeedLabor(tpl)
  return tpl.needLabor
end

function this:getIsNeedPet(tpl)
  return tpl.isNeedPet
end

function this:getTabId(tpl)
  return tpl.tabId
end

function this:getSatietyScore(tpl)
  return tpl.satietyScore
end

function this:getUnlockCondition(tpl)
  return tpl.unlockCondition
end

function this:getSequenceQuickProduct(tpl)
  return tpl.sequenceQuickProduct
end

function this:getHomeBuildingNeedMaterialByBuildingId(buildingId)
  local tableId
  for i, v in pairs(self.data) do
    if v.rewardId and v.rewardId[1] and v.rewardId[1][2] and v.rewardId[1][2] == buildingId then
      tableId = v.id
    end
  end
  if tableId == nil then
    return {}
  end
  local tpl = self:getTplById(tableId)
  return self:getMaterial(tpl)
end

function this:getHomeBuildingUnlockConditionByBuildingId(buildingId)
  local tableId
  for i, v in pairs(self.data) do
    if v.rewardId and v.rewardId[1] and v.rewardId[1][2] and v.rewardId[1][2] == buildingId and v.rewardId[1][1] == L_Const.resType.homeBuilding then
      tableId = v.id
    end
  end
  if tableId == nil then
    return {}
  end
  local tpl = self:getTplById(tableId)
  return self:getUnlockCondition(tpl)
end

function this:getTplByReward(rewardType, rewardId)
  local list = self._rewardTypeMap[rewardType] or {}
  for _, tpl in ipairs(list) do
    if tpl.rewardId and tpl.rewardId[1] and tpl.rewardId[1][2] == rewardId then
      return tpl
    end
  end
  return {}
end

function this:getGroupList(tpl)
  return tpl.group
end

function this:getMaterialSelectList(tpl)
  return tpl.materialSelect
end

function this:getRewardDesc(tpl)
  return L_Config:provider(tpl.rewardDesc)
end

function this:getMaxProductNum(tpl)
  if tpl.maxLimit == 0 then
    return false, 0
  end
  local maxNum = tpl.maxLimit
  return true, maxNum
end

function this:getNotReleased(tpl)
  return tpl.notReleased
end

return this
