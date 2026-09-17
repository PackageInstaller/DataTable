local this = class("eggIncubateGroupTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getDropId(tpl)
  return tpl.dropId
end

function this:getchildren(tpl)
  return tpl._children
end

return this
