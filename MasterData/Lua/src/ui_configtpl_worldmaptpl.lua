local this = class("worldMapTpl")

function this:init()
  self.worldDic = {}
end

function this:getTplById(worldId, id)
  local tpl = C_TDWorldmapTable.GetData(id, worldId)
  return tpl
end

function this:getAllTpl(worldId)
  local worldDatas = C_TDWorldmapTable.GetAllData(worldId)
  local result = {}
  local count = worldDatas.Count - 1
  for i = 0, count do
    table.insert(result, worldDatas[i])
  end
  return result
end

function this:getAllTplByBlockId(worldId, blockId)
  local worldDatas = C_TDWorldmapTable.GetAllData(worldId)
  local result = {}
  local count = worldDatas.Count - 1
  for i = 0, count do
    if not worldDatas[i].AlwaysShow and self:getBlockId(worldDatas[i]) == blockId then
      table.insert(result, worldDatas[i])
    end
  end
  return result
end

function this:getAllTplBySpawnerId(worldId, spawnerId)
  local spawnerGroup = C_TDWorldmapTable.GetAllDataBySpawnerId(worldId, spawnerId)
  local result = {}
  if spawnerGroup then
    local count = spawnerGroup.Count - 1
    for i = 0, count do
      table.insert(result, spawnerGroup[i])
    end
  end
  return result
end

function this:getAllBlockShowTpl(worldId)
  local worldDatas = C_TDWorldmapTable.GetAllData(worldId)
  local result = {}
  local count = worldDatas.Count - 1
  for i = 0, count do
    if worldDatas[i].AlwaysShow then
      table.insert(result, worldDatas[i])
    end
  end
  return result
end

function this:getId(tpl)
  return tpl.id
end

function this:getCityId(tpl)
  return tpl.cityId
end

function this:getBlockId(tpl)
  local x = math.floor(tpl.Position.x / L_Const.blockSize)
  local z = math.floor(tpl.Position.z / L_Const.blockSize)
  return (z + 500) * 1000 + x + 500
end

function this:getPosition(tpl)
  if TableIsNull(tpl) then
    return L_Vector3.new(0, 0, 0)
  end
  local pos = L_Vector3.new(tpl.Position.x, tpl.Position.y, tpl.Position.z)
  return pos
end

function this:getRotation(tpl)
  return L_Vector3.new(tpl.Rotation.x, tpl.Rotation.y, tpl.Rotation.z)
end

function this:getExpandId(tpl)
  return tpl.expandId
end

function this:getInitStatus(tpl)
  return tpl.initStatus
end

function this:getAllBlockShow(tpl)
  return tpl.AlwaysShow
end

function this:getTriggerId(tpl)
  return tpl.worldTrigger
end

function this:getStatusReward(tpl)
  return tpl.statusReward
end

function this:getSpawnerId(tpl)
  return tpl and tpl.spawnerId or 0
end

function this:getInteractOptions(tpl)
  local interacts = tpl.GetInteractList
  local count = interacts.Count - 1
  local result = {}
  for i = 0, count do
    table.insert(result, interacts[i])
  end
  return result
end

function this:getAITree(tpl)
  return tpl and tpl.aiTree or 0
end

function this:getFilterMark(tpl)
  return tpl.filterMark
end

function this:keepOnComplete(tpl)
  return tpl.KeepOnComplete
end

function this:getRandomEvtId(tpl)
  return tpl.randomEvtId
end

function this:getExpandParams(tpl, key)
  return tpl:GetExpandParam(key)
end

function this:getScale(tpl)
  if tpl.scale == nil or tpl.scale <= 0.01 then
    return L_Vector3.new(0, 0, 0)
  end
  return L_Vector3.new(tpl.scale, tpl.scale, tpl.scale)
end

function this:isOverrideScale(tpl)
  if tpl.scale == nil or tpl.scale <= 0.01 then
    return false
  end
  return true
end

return this
