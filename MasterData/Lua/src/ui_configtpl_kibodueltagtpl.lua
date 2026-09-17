local this = class("kiboDuelTagTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getId(tpl)
  return tpl.id
end

function this:getTagName(tpl)
  return L_Config:provider(tpl.tagName)
end

function this:getTagIcon(tpl)
  return L_Config:getPathByHash(tpl.tagIcon)
end

function this:getTagDesc(tpl)
  return L_Config:provider(tpl.tagDesc)
end

return this
