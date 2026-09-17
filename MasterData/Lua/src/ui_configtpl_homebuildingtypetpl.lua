local this = class("homeBuildingTypeTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getId(tpl)
  return tpl.id
end

function this:getLaborDesc(tpl)
  return tpl.labordesc
end

function this:getTypeIcon(tpl)
  local typeIcon = L_Config:getPathByHash(tpl.typeIcon)
  return typeIcon
end

function this:getTypeName(tpl)
  return L_Config:provider(tpl.typeName)
end

function this:getConfig()
  return self.data
end

return this
