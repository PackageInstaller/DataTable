local this = class("libraryBranchTpl")

function this:init(config)
  self.data = config
end

function this:getAllData()
  return self.data
end

function this:getTplById(id)
  return self.data[id]
end

function this:getBranchIdList()
  local res = {}
  for i, v in pairs(self.data) do
    table.insert(res, v.id)
  end
  table.sort(res, function(a, b)
    return a < b
  end)
  return res
end

function this:getName(tpl)
  return L_Config:provider(tpl.name)
end

function this:getSeriesId(tpl)
  return tpl.seriesId
end

return this
