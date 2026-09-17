local this = class("homeBuildingRemoteUpTpl")

function this:init(config)
  self.data = config
  self.sortData = {}
  for i, v in pairs(self.data) do
    table.insert(self.sortData, v)
  end
  table.sort(self.sortData, function(a, b)
    return a.groupId < b.groupId
  end)
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

function this:getRemoteUp(tpl)
  return tpl.remoteUp
end

function this:getRemoteUpMap(tpl)
  local map = {}
  for i, v in pairs(tpl.remoteUp) do
    map[v] = v
  end
  return map
end

function this:getSortData()
  return self.sortData
end

return this
