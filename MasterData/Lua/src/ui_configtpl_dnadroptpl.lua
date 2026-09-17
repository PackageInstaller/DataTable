local this = class("dnaDropTpl")

function this:init(config)
  self.data = config
  self.groupData = {}
  for i, v in pairs(config) do
    if self.groupData[v.petId] == nil then
      self.groupData[v.petId] = {}
    end
    table.insert(self.groupData[v.petId], v)
  end
end

function this:getTplById(id)
  return self.data[id]
end

function this:getId(tpl)
  return tpl.id
end

function this:getPetGroupId(tpl)
  return tpl.petGroupId
end

function this:getRarity(tpl)
  return tpl.rarity
end

function this:getLength(tpl)
  return tpl.length
end

function this:getDnaPoolId(tpl)
  return tpl.dnaPoolId
end

function this:getWeight(tpl)
  return tpl.weight
end

function this:getRareDnaDropGroup(id, rarity)
  local groupData = self.groupData[id]
  if groupData == nil then
    return nil
  end
  local selectedGroup = {}
  for i, v in pairs(groupData) do
    if v.rarity == rarity then
      table.insert(selectedGroup, v)
    end
  end
  return selectedGroup
end

return this
