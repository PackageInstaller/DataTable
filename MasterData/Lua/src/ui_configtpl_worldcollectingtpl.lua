local this = class("worldCollectingTpl")

function this:init(config)
  self.data = config
  self.typeData = {}
  for _, v in pairs(config) do
    local type = self:getType(v)
    if self.typeData[type] == nil then
      self.typeData[type] = {}
    end
    table.insert(self.typeData[type], v)
  end
end

function this:getTplById(id)
  return self.data[id]
end

function this:getSpawnerId(tpl)
  return tpl.spawnerId
end

function this:getItemId(tpl)
  return tpl.itemId
end

function this:getType(tpl)
  return tpl.type
end

function this:getName(tpl)
  return L_Config:provider(tpl.name)
end

function this:getItemType(tpl)
  return tpl.itemType
end

function this:getId(tpl)
  return tpl.id
end

function this:getWorldCollectionByType(type)
  return self.typeData[type] or {}
end

return this
