local this = class("battleDamagetextTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getElement(tpl)
  return tpl.element
end

function this:getType(tpl)
  return tpl.type
end

function this:getId(tpl)
  return tpl.id
end

return this
