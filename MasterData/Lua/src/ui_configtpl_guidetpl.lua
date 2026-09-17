local this = class("guideTpl")

function this:init(config)
  self.data = config
  self.groups = {}
  for _, v in pairs(self.data) do
    self.groups[v.groupId] = self.groups[v.groupId] or {}
    table.insert(self.groups[v.groupId], v)
  end
  for _, v in pairs(self.groups) do
    table.sort(v, function(a, b)
      return a.id < b.id
    end)
  end
end

function this:getGroup(groupId)
  return self.groups[groupId]
end

function this:getTplById(id)
  return self.data[id]
end

function this:getId(tpl)
  return tpl.id
end

function this:getGroupId(tpl)
  return tpl.groupId
end

return this
