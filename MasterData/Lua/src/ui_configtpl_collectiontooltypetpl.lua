local this = class("collectionToolTypeTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getIcon(tpl)
  return tpl.icon
end

function this:getTypeIcon(tpl)
  return tpl.typeIcon
end

function this:getTypeName(tpl)
  return L_Config:provider(tpl.name)
end

return this
