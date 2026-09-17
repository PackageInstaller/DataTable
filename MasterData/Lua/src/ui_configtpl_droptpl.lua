local this = class("dropTpl")

function this:init(config)
  self.data = {}
  for i, v in pairs(config) do
    if self.data[v.dropId] == nil then
      self.data[v.dropId] = {}
    end
    if not math.isEmpty(v.itemId) then
      table.insert(self.data[v.dropId], v)
    end
  end
  for _, v in pairs(self.data) do
    table.sort(v, function(a, b)
      return a.id < b.id
    end)
  end
end

function this:getTpl(dropId, id)
  local group = self.data[dropId]
  for _, v in ipairs(group) do
    if v.id == id then
      return v
    end
  end
  return group
end

function this:getTplByDropAndGroupId(dropId, id)
  local group = self.data[dropId]
  for _, v in ipairs(group) do
    if v.dropGroupId == id then
      return v
    end
  end
  return group
end

function this:getWeight(tpl)
  return tpl.weight
end

function this:getDropId(tpl)
  return tpl.dropId
end

function this:getItemId(tpl)
  return tpl.itemId
end

function this:getMaxValue(tpl)
  return tpl.maxValue
end

function this:getDropGroupId(tpl)
  return tpl.dropGroupId
end

function this:getType(tpl)
  return tpl.type
end

function this:getMinValue(tpl)
  return tpl.minValue
end

function this:getId(tpl)
  return tpl.id
end

function this:getSplitNum(tpl)
  return tpl.splitNum
end

function this:getDropGroup(dropId)
  return self.data[dropId] or {}
end

function this:getNum(tpl)
  if tpl.minValue == tpl.maxValue and tpl.minValue > 1 then
    return tpl.minValue
  end
  return 0
end

return this
