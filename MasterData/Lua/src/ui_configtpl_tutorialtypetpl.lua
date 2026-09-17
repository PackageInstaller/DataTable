local this = class("tutorialTypeTpl")

function this:init(config)
  self.data = config
  self.sortData = {}
  for i, v in pairs(config) do
    table.insert(self.sortData, v)
  end
  table.sort(self.sortData, function(a, b)
    return a.id < b.id
  end)
end

function this:getTplById(id)
  return self.data[id]
end

function this:getName(tpl)
  return L_Config:provider(tpl.name)
end

function this:getId(tpl)
  return tpl.id
end

function this:getIcon(tpl)
  return tpl.icon
end

function this:getAllType()
  return self.sortData
end

return this
