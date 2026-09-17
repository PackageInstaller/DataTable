local this = class("foodMaterialGroupTpl")

function this:init(config)
  self.data = config
  self._group2ItemIds = {}
  for k, v in pairs(self.data) do
    self._group2ItemIds[k] = {}
    for k2, v2 in pairs(v.includeItems) do
      self._group2ItemIds[k][v2] = k2
    end
  end
end

function this:getItemId(group, ra)
  return self._group2ItemIds[group][ra]
end

function this:getGroupItemIds(group)
  return self._group2ItemIds[group]
end

function this:getTplById(id)
  return self.data[id]
end

function this:getId(tpl)
  return tpl.id
end

function this:getIncludeItems(tpl)
  return tpl.includeItems
end

return this
