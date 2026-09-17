local this = class("homeTechnologyTreeTpl")

function this:init(config)
  self.data = config
  self:initDataByIndex()
end

function this:getTplById(id)
  return self.data[id]
end

function this:getName(tpl)
  return L_Config:provider(tpl.name)
end

function this:getIcon(tpl)
  return tpl.icon
end

function this:getCategory(tpl)
  return tpl.category
end

function this:getNodeType(tpl)
  return tpl.nodeType
end

function this:getPosttechnologyTypeId(tpl)
  return tpl.posttechnologyTypeId
end

function this:getType(tpl)
  return tpl.category
end

function this:getId(tpl)
  return tpl.id
end

function this:initDataByIndex()
end

function this:getNodeTypeIcon(tpl)
  return tpl.nodeTypeIcon
end

function this:getMarkIcon(tpl)
  return tpl.markIcon
end

return this
