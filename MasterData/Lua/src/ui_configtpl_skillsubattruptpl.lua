local this = class("skillsubAttrupTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getAttributeList(tpl)
  return tpl.attributeList
end

function this:getId(tpl)
  return tpl.id
end

return this
