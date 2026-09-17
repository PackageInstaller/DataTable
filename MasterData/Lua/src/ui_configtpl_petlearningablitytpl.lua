local this = class("petLearningAblityTpl")

function this:init(config)
  self.data = config
  self.list = {}
  self.keyList = {}
  for k, v in pairs(self.data) do
    table.insert(self.list, v)
  end
  for i, v in pairs(config) do
    if self.keyList[v.enumId] == nil then
      self.keyList[v.enumId] = {}
    end
    table.insert(self.keyList[v.enumId], v)
  end
  for _, v in pairs(self.keyList) do
    table.sort(v, function(a, b)
      return a.id > b.id
    end)
  end
end

function this:getTplById(id)
  return self.data[id]
end

function this:getRange(tpl)
  return tpl.Range
end

function this:getId(tpl)
  return tpl.id
end

function this:getLevel(tpl)
  return string.lower(tpl.level)
end

function this:getScore(tpl)
  return tpl.score
end

function this:getEnumId(tpl)
  return tpl.enumId
end

function this:getGrade(tpl)
  return tpl.grade
end

function this:getAllList()
  return self.list
end

function this:getTplByEnumId(enumId)
  return self.keyList[enumId]
end

function this:getIcon(tpl)
  return tpl.icon or ""
end

return this
