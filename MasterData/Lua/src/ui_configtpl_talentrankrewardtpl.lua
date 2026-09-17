local this = class("talentRankRewardTpl")

function this:init(config)
  self.data = config
  self.sortedData = self:sortData()
end

function this:getTplById(id)
  return self.data[id]
end

function this:getLevel(tpl)
  return tpl.level
end

function this:getItem(tpl)
  return L_DataUtil.parseRewardConfig(tpl.item)
end

function this:getAllData()
  return self.data
end

function this:getIcon(tpl)
  return tpl.icon
end

function this:sortData()
  local data = {}
  for k, reward in pairs(self.data) do
    table.insert(data, reward)
  end
  table.sort(data, function(a, b)
    return a.id < b.id
  end)
  return data
end

function this:getSortedData()
  return self.sortedData
end

return this
