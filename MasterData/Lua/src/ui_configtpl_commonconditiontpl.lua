local this = class("commonConditionTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getDetail(tpl)
  return tpl.detail
end

function this:getName(tpl)
  return tpl.name
end

function this:getId(tpl)
  return tpl.id
end

function this:getType(tpl)
  return tpl.type
end

function this:getDescShowKey(tpl)
  return L_Config:provider(tpl.descShow)
end

return this
