local this = class("guideConditionTypeTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getType(tpl)
  return tpl.type
end

function this:getTypeInfo(tpl)
  return tpl.typeInfo
end

function this:getParamType(tpl)
  return tpl.paramType
end

function this:getParamInfo(tpl)
  return tpl.paramInfo
end

function this:getId(tpl)
  return tpl.id
end

function this:getIsMoment(tpl)
  return tpl.isMoment
end

return this
