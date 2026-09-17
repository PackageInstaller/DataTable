local this = {}

function this:init()
  this.super.init(self)
  self.data = {
    guidToPlacePointInfo = {}
  }
end

function this:getPlacePointDataByGuid(guid, isCreate)
  if isCreate and self.data.guidToPlacePointInfo[guid] == nil then
    self.data.guidToPlacePointInfo[guid] = require(L_R.store .. "placePoint.data.placePointData").new()
    self.data.guidToPlacePointInfo[guid].guid = guid
  end
  return self.data.guidToPlacePointInfo[guid]
end

function this:getPlacePointDic()
  return self.data.guidToPlacePointInfo
end

function this:getHeroListByGuid(guid)
  local pointData = self:getPlacePointDataByGuid(guid)
  return pointData and pointData.heros or {}
end

function this:getNowRewardByGuid(guid)
  local pointData = self:getPlacePointDataByGuid(guid)
  return pointData and pointData.extra_storage or {}
end

function this:getPointGuidByBuildingGuid(buildingGuid)
  for i, v in pairs(self.data.guidToPlacePointInfo) do
    if v.building_guid == buildingGuid then
      return v.guid
    end
  end
end

function this:getIsHasRewardByGuid(guid, isStand)
  local pointData = self:getPlacePointDataByGuid(guid)
  if pointData == nil then
    return false
  end
  for i, v in ipairs(pointData.storage_counts) do
    if 0 < v then
      return true
    end
  end
  if not table.isEmpty(pointData.extra_storage) and not table.isEmpty(pointData.extra_storage.rewards) then
    return true
  end
  local now = L_TimeUtil.getServerTime()
  local _placePointTpl = L_GameTpl:getHomeResourceTpl()
  local outPutList = _placePointTpl:getParseOutPut(_placePointTpl:getTplById(pointData.place_id))
  for i, v in ipairs(outPutList) do
    if now - pointData.times[i] > v.time then
      return true
    end
  end
  if not isStand then
    local dropList = _placePointTpl:getParseDrop(_placePointTpl:getTplById(pointData.place_id))
    for i, v in ipairs(dropList) do
      if now - pointData.extra_times[i] > v.time then
        return false, true
      end
    end
  end
  return false, false
end

return this
