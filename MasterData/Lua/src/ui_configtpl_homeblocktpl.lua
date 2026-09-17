local this = class("homeBlockTpl")

function this:init(config)
  self.data = config
  self.worldIdMap = {}
  self.blockTypeList = {}
  for _, v in pairs(config) do
    local wId = self:getWorldMapId(v)
    self.worldIdMap[wId] = v
    self.blockTypeList[v.blockType] = self.blockTypeList[v.blockType] or {}
    table.insert(self.blockTypeList[v.blockType], v)
  end
end

function this:getTplById(id)
  return self.data[id]
end

function this:getTplByWorldMapId(mapId)
  return self.worldIdMap[mapId]
end

function this:getPetWaterPos(tpl)
  local data = tpl.petWaterPos
  if 0 < #data then
    return L_Vector3.new(data[1], data[2], data[3]), L_Vector3.new(data[4], data[5], data[6])
  end
  return L_Vector3.zero, L_Vector3.zero
end

function this:getBoxPosition(tpl)
  local data = tpl.boxPosition
  if 0 < #data then
    return L_Vector3.new(data[1], data[2], data[3])
  end
  return L_Vector3.zero
end

function this:getPetPlantPos(tpl)
  local data = tpl.petPlantPos
  if 0 < #data then
    return L_Vector3.new(data[1], data[2], data[3]), L_Vector3.new(data[4], data[5], data[6])
  end
  return L_Vector3.zero, L_Vector3.zero
end

function this:getPetHarvestPos(tpl)
  local data = tpl.petHarvestPos
  if 0 < #data then
    return L_Vector3.new(data[1], data[2], data[3]), L_Vector3.new(data[4], data[5], data[6])
  end
  return L_Vector3.zero, L_Vector3.zero
end

function this:getFieldType(tpl)
  return tpl.fieldType
end

function this:getBlockType(tpl)
  return tpl.blockType
end

function this:getId(tpl)
  return tpl.id
end

function this:getName(tpl)
  return L_Config:provider(tpl.name)
end

function this:getUnlockCondi(tpl)
  return tpl.unlockCondi
end

function this:getIcon(tpl)
  return tpl.icon
end

function this:getDesc(tpl)
  return L_Config:provider(tpl.desc)
end

function this:getGrassPath(tpl)
  return tpl.grassAsset
end

function this:getSequence(tpl)
  return tpl.sequence
end

function this:getWorldMapId(tpl)
  return tpl.worldmapId
end

function this:getBlockLens(tpl)
  return tpl.blockLens
end

function this:getBlockTypeList(blockType)
  return self.blockTypeList[blockType] or {}
end

return this
