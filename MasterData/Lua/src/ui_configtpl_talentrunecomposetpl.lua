local this = class("talentRuneComposeTpl")

function this:init(config)
  self.data = config
  self.composeMaterialMap = {}
  for key, v in pairs(self.data) do
    if not self.composeMaterialMap[key] then
      self.composeMaterialMap[key] = {}
    end
    for _, item in ipairs(v.items) do
      table.insert(self.composeMaterialMap[key], {
        itemType = item[1],
        itemId = item[2],
        itemNum = item[3]
      })
    end
  end
end

function this:getTplById(id)
  return self.data[id]
end

function this:getItems(tpl)
  return tpl.items
end

function this:getcomposeMaterialMap()
  return self.composeMaterialMap
end

function this:getIsComposeMaterial(itemId)
  return self.composeMaterialMap[itemId] ~= nil
end

function this:getComposeCondition(tpl)
  return tpl.condition
end

function this:getIsLeafNode(id)
  return self.composeMaterialMap[id] == nil
end

return this
