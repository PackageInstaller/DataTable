local this = class("worldSpawnerTpl")

function this:init(config)
  self.data = config
  self.objectTypeData = {}
  for i, v in pairs(config) do
    if self.objectTypeData[self:getObjectType(v)] == nil then
      self.objectTypeData[self:getObjectType(v)] = {}
    end
    table.insert(self.objectTypeData[self:getObjectType(v)], v)
  end
end

function this:getTplById(id)
  return self.data[id]
end

function this:getId(tpl)
  return tpl.id
end

function this:getWorldObjId(tpl)
  return tpl.worldObj
end

function this:getWorldPropertyId(tpl)
  return tpl.property
end

function this:getInteractiveProfile(tpl)
  return tpl and tpl.interactive or 0
end

function this:getTrigger(tpl)
  return tpl and tpl.defaultTrigger or 0
end

function this:getBevTree(tpl)
  return tpl.bevTree
end

function this:getBevTreeParam(tpl)
  return tpl.bevTreeParam
end

function this:getName(tpl)
  return tpl.name
end

function this:getScale(tpl)
  return tpl and tpl.scale or 1
end

function this:getObjectType(tpl)
  return tpl and tpl.objectType or 0
end

function this:getBasicType(tpl)
  return tpl and tpl.basicType or 0
end

function this:getAllTplByObjectType(objectType)
  return self.objectTypeData[objectType] or {}
end

function this:getInteractOps(tpl)
  return tpl.interactOps or {}
end

function this:getInteractParams(tpl)
  return tpl.interactParams or {}
end

function this:getResourceId(tpl)
  return tpl.resourceId
end

function this:getWorldDifficultyObjLevel(tpl)
  if math.isEmpty(tpl.worldDifficultyObjLevel) then
    return nil
  end
  return tpl.worldDifficultyObjLevel
end

function this:getCanShowInMap(tpl)
  return tpl.icon ~= string.empty
end

function this:getIcon(tpl)
  local icon = L_Config:getPathByHash(tpl.icon)
  return icon
end

function this:getSievingType(tpl)
  return tpl.sievingType
end

function this:getTransferIcon()
  local first = self.data[1]
  return self:getIcon(first)
end

function this:getObjHeight(tpl)
  return tpl.objHeight
end

return this
