local this = class("homeItemModelTpl")

function this:init(config)
  self.data = config
  self._dataMap = {}
  for k, v in pairs(config) do
    self._dataMap[v.itemType] = self._dataMap[v.itemType] or {}
    self._dataMap[v.itemType][v.itemId] = v
  end
end

function this:getTplByMap(type, id)
  return self._dataMap[type] and self._dataMap[type][id]
end

function this:getTplById(id)
  return self.data[id]
end

function this:getItemType(tpl)
  return tpl.itemType
end

function this:getDropPath(tpl)
  return tpl.dropPath
end

function this:getItemId(tpl)
  return tpl.itemId
end

function this:getId(tpl)
  return tpl.id
end

function this:getName(tpl)
  return tpl.name
end

return this
