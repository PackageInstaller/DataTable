local this = class("resourceBarItemTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getIcon(tpl)
  local icon = L_Config:getPathByHash(tpl.icon)
  return icon
end

function this:getResourceID(tpl)
  return tpl.resourceID
end

function this:getSystem(tpl)
  return tpl.system
end

function this:getIsAddSign(tpl)
  return tpl.isAddSign == 1
end

function this:getNumType(tpl)
  return tpl.numType
end

function this:getId(tpl)
  return tpl.id
end

function this:getResourceType(tpl)
  return tpl.resourceType
end

function this:getName(tpl)
  return L_Config:provider(tpl.name)
end

return this
