local this = class("guideConditionTpl")

function this:init(config)
  self.data = config
  self.typeDict = {}
  for _, v in pairs(self.data) do
    if not self.typeDict[v.type] then
      self.typeDict[v.type] = {}
    end
    table.insert(self.typeDict[v.type], v)
  end
end

function this:getConditionsByType(type)
  return self.typeDict[type]
end

function this:getTplById(id)
  return self.data[id]
end

function this:getParam(tpl)
  return tpl.param
end

function this:getParamType(tpl)
  return tpl.paramType
end

function this:getId(tpl)
  return tpl.id
end

function this:getTypeInfo(tpl)
  return tpl.typeInfo
end

function this:getType(tpl)
  return tpl.type
end

return this
