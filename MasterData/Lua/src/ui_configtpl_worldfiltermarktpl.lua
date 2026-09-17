local this = class("worldFilterMarkTpl")

function this:init(config)
  self.data = config
  self.idToList = {}
  self.markTypeToList = nil
  self.worldIdWorldMapIdToId = nil
  for _, v in pairs(self.data) do
    local worldId = self:getWorldId(v)
    if self.idToList[worldId] == nil then
      self.idToList[worldId] = {}
    end
    table.insert(self.idToList[worldId], v)
  end
end

function this:getTplById(id)
  return self.data[id]
end

function this:getTplListByMarkType(markType)
  if not self.markTypeToList then
    self.markTypeToList = {}
  end
  if not self.markTypeToList[markType] then
    local tplList = {}
    for _, list in pairs(self.idToList) do
      for _, v in ipairs(list) do
        if v.markType == markType and math.isEmpty(self:getShowIf(v)) then
          table.insert(tplList, v)
        end
      end
    end
    self.markTypeToList[markType] = tplList
  end
  return self.markTypeToList[markType]
end

function this:getTplListByWorldId(id, markType)
  local result = self.idToList[id]
  if table.isEmpty(result) then
    return {}
  end
  if markType then
    local list = {}
    for _, v in ipairs(result) do
      if v.markType == markType and math.isEmpty(self:getShowIf(v)) then
        table.insert(list, v)
      end
    end
    return list
  else
    local filter_result = {}
    for i, v in pairs(result) do
      if math.isEmpty(self:getShowIf(v)) then
        table.insert(filter_result, v)
      end
    end
    return filter_result
  end
end

function this:getTplByWorldId(worldLstId, markType)
  local list = {}
  local count = 1
  for _, v in pairs(self.data) do
    if list[count] == nil and v.markType == markType and math.isEmpty(self:getShowIf(v)) then
      local bool = true
      for i, id in pairs(worldLstId) do
        if v.worldId == id then
          bool = false
        end
      end
      if bool then
        list[count] = v.worldId
        count = count + 1
      end
    end
  end
  return list
end

function this:getId(tpl)
  return tpl.id
end

function this:getWorldId(tpl)
  return tpl.worldId
end

function this:getName(tpl)
  return L_Config:provider(tpl.name)
end

function this:getMarkType(tpl)
  return tpl.markType
end

function this:getTrackMarkType(tpl)
  return tpl.trackType
end

function this:getDes(tpl)
  return L_Config:provider(tpl.des)
end

function this:getIcon(tpl)
  local icon = L_Config:getPathByHash(tpl.icon)
  return icon
end

function this:getIconBg(tpl)
  local icon = L_Config:getPathByHash(tpl.iconBg)
  return icon
end

function this:getPosId(tpl)
  return tpl.posId
end

function this:getRewardShow(tpl)
  return tpl.rewardShow
end

function this:getAngle(tpl)
  return tpl.angle
end

function this:getWorldmapId(tpl)
  return tpl.worldmapId
end

function this:getParam(tpl)
  return tpl.param
end

function this:getShowIf(tpl)
  return tpl.showIf
end

function this:getMapMaskIcon(tpl)
  local icon = L_Config:getPathByHash(tpl.mapMaskIcon)
  return icon
end

function this:getMapMaskLock(tpl)
  return tpl.mapMaskLock
end

function this:getUnlockCondition(tpl)
  return tpl.unlockCondition
end

function this:getFilterMarkIdByWorldIdAndWorldMapId(worldId, worldMapId)
  if worldId == nil or worldMapId == nil then
    return nil
  end
  if not self.worldIdWorldMapIdToId then
    self.worldIdWorldMapIdToId = {}
  end
  if not self.worldIdWorldMapIdToId[worldId] then
    self.worldIdWorldMapIdToId[worldId] = {}
  end
  local cached = self.worldIdWorldMapIdToId[worldId][worldMapId]
  if cached ~= nil then
    return cached
  end
  local list = self.idToList[worldId]
  if table.isEmpty(list) then
    self.worldIdWorldMapIdToId[worldId][worldMapId] = nil
    return nil
  end
  local resultId
  for _, tpl in ipairs(list) do
    if self:getWorldmapId(tpl) == worldMapId and math.isEmpty(self:getShowIf(tpl)) then
      local id = self:getId(tpl)
      if resultId == nil or resultId > id then
        resultId = id
      end
    end
  end
  self.worldIdWorldMapIdToId[worldId][worldMapId] = resultId
  return resultId
end

return this
