local this = class("photographTypeTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getSequence(tpl)
  return tpl.sequence
end

function this:getId(tpl)
  return tpl.id
end

function this:getTypeName(tpl)
  return L_Config:provider(tpl.typeName)
end

function this:getTypeId(tpl)
  return tpl.typeId
end

return this
