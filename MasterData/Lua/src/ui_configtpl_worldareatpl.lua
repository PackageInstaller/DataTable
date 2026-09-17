local this = class("worldAreaTpl")

function this:init(config)
  self.data = config
  self.scene = {}
  for _, v in pairs(config) do
    local tab = self.scene[v.sceneId]
    if tab == nil then
      tab = {}
      self.scene[v.sceneId] = tab
    end
    tab[v.id] = v
  end
end

function this:getTplById(id)
  return self.data[id]
end

function this:getAllArea(sceneId)
  local result = {}
  if not self.scene[sceneId] then
    return nil
  end
  for i, v in pairs(self.scene[sceneId]) do
    if not v.mainArea or not (v.mainArea > 0) then
      result[i] = v
    end
  end
  return result
end

function this:getCurSceneAreaList(sceneId)
  if table.isEmpty(self.scene[sceneId]) then
    return {}
  end
  local data = {}
  for i, v in pairs(self.scene[sceneId]) do
    table.insert(data, v)
  end
  table.sort(data, function(a, b)
    return a.id < b.id
  end)
  return data
end

function this:getCurSceneAreaListFirstId(sceneId)
  return self:getCurSceneAreaList(sceneId)[1].id
end

function this:getAreaPos(tpl, isV3)
  local pos = tpl.areaPos
  if isV3 then
    return L_Vector3.new(pos[1], pos[2], pos[3])
  else
    return pos
  end
end

function this:getEnterFocusPoint(tpl, isV3)
  local pos = tpl.enterFocusPoint
  if isV3 then
    return L_Vector3.new(pos[1], pos[2], pos[3])
  else
    return pos
  end
end

function this:getMapOffset(tpl, isV3)
  local offset = tpl.mapOffset
  if isV3 then
    return L_Vector3.new(offset[1], offset[2])
  else
    return offset
  end
end

function this:getMapSize(tpl, isV3)
  local size = tpl.mapSize
  if isV3 then
    return L_Vector3.new(size[1], size[2])
  else
    return size
  end
end

function this:getMiniMapResolution(tpl, isV3)
  local size = tpl.miniMapResolution
  if isV3 then
    return L_Vector3.new(size[1], size[2])
  else
    return size
  end
end

function this:getName(tpl)
  return L_Config:provider(tpl.name)
end

function this:getRawName(tpl)
  return tpl.name
end

function this:getId(tpl)
  return tpl.id
end

function this:getVertices(tpl)
  return tpl.vertices
end

function this:getSceneId(tpl)
  return tpl.sceneId
end

function this:getMapRotation(tpl)
  return tpl.mapRotation
end

function this:getType(tpl)
  return tpl.type
end

function this:getSceneSize(tpl)
  return tpl.sceneSize
end

function this:getAreaMap(tpl)
  return tpl.areaMap
end

function this:getHeight(tpl)
  return tpl.height or 50
end

function this:getIsCut(tpl)
  return not table.isEmpty(tpl.cellInfo)
end

function this:getUseMap(tpl)
  return not string.isEmpty(tpl.areaMap)
end

function this:getHasMainArea(tpl)
  return not math.isEmpty(tpl.mainArea)
end

function this:getSceneToMapScale(tpl)
  local mapSize = self:getMapSize(tpl)
  return mapSize[1] / tpl.sceneSize[1]
end

function this:getSceneToMiniMapScale(tpl)
  local miniMapResolution = self:getMiniMapResolution(tpl)
  return miniMapResolution[1] / tpl.sceneSize[1]
end

function this:getMapMaxScale(scale)
  local plottingScale = 0.09259259259259259
  local maxScale = 1 / (plottingScale * scale)
  if maxScale < 1.5 then
    maxScale = 1.5
  end
  return maxScale
end

function this:getMiniMapMaxScale(scale)
  local plottingScale = 0.23255813953488372
  local maxScale = 1 / (plottingScale * scale)
  return maxScale
end

function this:getRowAndColumn(tpl)
  local x = tpl.cellInfo[1] or 8
  local y = tpl.cellInfo[2] or 8
  return L_Vector3.new(x, y)
end

function this:getCellSize(tpl)
  return tpl.cellInfo[3]
end

function this:getDefaultScale(tpl)
  local size = self:getMapSize(tpl)
  local min = math.min(size[1], size[2])
  local val = math.min(1, 2048 / min)
  return val
end

function this:getTeleportaion(tpl)
  return tpl.teleportation
end

function this:getEnterScale(tpl)
  return tpl.enterScale or 1
end

function this:getMiniMapInitScale(tpl)
  return tpl.miniMapInitScale
end

function this:getNorthAngle(tpl)
  return tpl.northAngle or 0
end

function this:getMapBoundary(tpl)
  local icon = L_Config:getPathByHash(tpl.mapMaskIcon)
  return icon
end

function this:getAllScene()
  local sceneIds = {}
  for id, _ in pairs(self.scene) do
    table.insert(sceneIds, id)
  end
  table.sort(sceneIds, function(a, b)
    return a < b
  end)
  return sceneIds
end

return this
