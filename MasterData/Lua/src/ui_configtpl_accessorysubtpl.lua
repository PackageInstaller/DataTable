local this = class("accessorySubTpl")

function this:init(config)
  self.data = config
  self.groupData = {}
  for i, v in pairs(config) do
    if not self.groupData[v.groupId] then
      self.groupData[v.groupId] = {}
    end
    self.groupData[v.groupId][v.parameter] = v
  end
end

function this:getTplById(id)
  return self.data[id]
end

function this:getId(tpl)
  return tpl.id
end

function this:getType(tpl)
  return tpl.type
end

function this:getMinValue(tpl)
  return tpl.minValue
end

function this:getMaxValue(tpl)
  return tpl.maxValue
end

function this:getGroupId(tpl)
  return tpl.groupId
end

function this:getWeight(tpl)
  return tpl.weight
end

function this:getIsSkill(tpl)
  return tpl.type == 2
end

function this:getParameter(tpl)
  return tpl.parameter
end

function this:getTplByGroupIdAndParameter(groupId, parameter)
  return self.groupData[groupId][parameter]
end

return this
