local this = class("commonItemChangeTpl")

function this:init(config)
  self.data = config
  self.typeData = {}
  for i, v in pairs(config) do
    self.typeData[v.itemType] = self.typeData[v.itemType] or {}
    self.typeData[v.itemType][v.itemId] = v
  end
end

function this:getTplById(id)
  return self.data[id]
end

function this:getItemNum(tpl)
  return tpl.itemNum
end

function this:getItemId(tpl)
  return tpl.itemId
end

function this:getId(tpl)
  return tpl.id
end

function this:getChange(tpl)
  return tpl.change
end

function this:getItemType(tpl)
  return tpl.itemType
end

function this:getTplByTypeAndId(type, id)
  return self.typeData[type][id]
end

function this:getTitle(tpl)
  return L_Config:provider(tpl.title)
end

return this
