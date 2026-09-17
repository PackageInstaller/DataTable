local this = class("accessorySubParameterTpl")

function this:init(config)
  self.data = config
  self.groupData = {}
  for i, v in pairs(config) do
    self.groupData[v.groupId] = self.groupData[v.groupId] or {}
    table.insert(self.groupData[v.groupId], v)
  end
end

function this:getTplById(id)
  return self.data[id]
end

function this:getGroupId(tpl)
  return tpl.groupId
end

function this:getParameter(tpl)
  return tpl.parameter
end

function this:getType(tpl)
  return tpl.type
end

function this:getId(tpl)
  return tpl.id
end

function this:getValue(tpl)
  return tpl.value
end

function this:getQuality(tpl)
  return tpl.quality
end

function this:getSort(tpl)
  return tpl.sort
end

function this:getSortTplByGroupId(groupId)
  local res = self.groupData[groupId]
  table.sort(res, function(a, b)
    return a.id < b.id
  end)
  return res
end

return this
