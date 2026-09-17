local this = class("homeCollectionWorldTpl")

function this:init(config)
  self.data = config
  self.obj2Id = {}
  self.domainGroup = {}
  self.typeGroup = {}
  for i, v in pairs(config) do
    self.obj2Id[v.worldMapObjectUnfixed] = v.id
    for i1, v1 in pairs(v.worldMapObjectFixed) do
      self.obj2Id[v1[2]] = v.id
    end
    if self.domainGroup[self:getDomainId(v)] == nil then
      self.domainGroup[self:getDomainId(v)] = {}
    end
    if self.typeGroup[self:getCollectionType(v)] == nil then
      self.typeGroup[self:getCollectionType(v)] = {}
    end
    table.insert(self.domainGroup[self:getDomainId(v)], v)
    table.insert(self.typeGroup[self:getCollectionType(v)], v)
  end
end

function this:getTplById(id)
  return self.data[id]
end

function this:getId(tpl)
  return tpl.id
end

function this:getType(tpl)
  return tpl.type
end

function this:getDomainId(tpl)
  return tpl.domainId
end

function this:getWorldMapObjectUnfixed(tpl)
  return tpl.worldMapObjectUnfixed
end

function this:getGroupId(tpl)
  return tpl.groupId
end

function this:getAllTpl()
  local tpls = {}
  for i, v in pairs(self.data) do
    table.insert(tpls, v)
  end
  return tpls
end

function this:getIdByWorldMapId(worldMapId)
  return self.obj2Id[worldMapId]
end

function this:getName(tpl)
  return L_Config:provider(tpl.name)
end

function this:getCollectionType(tpl)
  return tpl.collectionType
end

function this:getAllTplByDomainKey()
  return self.domainGroup
end

function this:getAllTplByType()
  return self.typeGroup
end

function this:getLocalName(tpl)
  return L_Config:provider(tpl.localName)
end

function this:getWorkingIcon(tpl)
  local icon = L_Config:getPathByHash(tpl.workingIcon)
  return icon
end

function this:getIdleIcon(tpl)
  local icon = L_Config:getPathByHash(tpl.idleIcon)
  return icon
end

function this:getPixelIcon(tpl)
  local icon = L_Config:getPathByHash(tpl.pixelIcon)
  return icon
end

function this:getControlbenchShow(tpl)
  local icon = L_Config:getPathByHash(tpl.controlbenchShow)
  return icon
end

return this
