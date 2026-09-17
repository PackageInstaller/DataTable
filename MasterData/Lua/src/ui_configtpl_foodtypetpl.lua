local this = class("foodTypeTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getTypeIcon(tpl)
  local typeIcon = L_Config:getPathByHash(tpl.typeIcon)
  return typeIcon
end

function this:getTitleIcon(tpl)
  local titleIcon = L_Config:getPathByHash(tpl.titleIcon)
  return titleIcon
end

function this:getButtonIcon(tpl)
  local buttonIcon = L_Config:getPathByHash(tpl.buttonIcon)
  return buttonIcon
end

function this:getTypeName(tpl)
  return L_Config:provider(tpl.typeName)
end

function this:getId(tpl)
  return tpl.id
end

function this:getData(tpl)
  return self.data
end

return this
