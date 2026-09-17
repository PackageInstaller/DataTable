local this = class("soulessenceValueTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getId(tpl)
  return tpl.id
end

function this:getBaseAttribute(tpl)
  return tpl.baseAttribute
end

return this
