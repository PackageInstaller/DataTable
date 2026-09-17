local this = class("fishGroupTpl")

function this:init(config)
  self.data = config
  self.groupData = {}
  for i, v in pairs(config) do
    if not self.groupData[v.fishGroup] then
      self.groupData[v.fishGroup] = {}
    end
    self.groupData[v.fishGroup][v.id] = v
  end
end

function this:getTplById(id)
  return self.data[id]
end

function this:getSubFishGroup(tpl)
  return tpl.subFishGroup
end

function this:getId(tpl)
  return tpl.id
end

function this:getFishId(tpl)
  return tpl.fishId
end

function this:getWeight(tpl)
  return tpl.weight
end

function this:getFishGroup(tpl)
  return tpl.fishGroup
end

function this:getGroupData(groupId)
  return self.groupData[groupId]
end

function this:getGroupFish(groupId)
  local group = self.groupData[groupId]
  local tmp = {}
  for i, v in pairs(group) do
    if not math.isEmpty(v.fishId) then
      tmp[v.fishId] = v.fishId
    end
  end
  return tmp
end

return this
