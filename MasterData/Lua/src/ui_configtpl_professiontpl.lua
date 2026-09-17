local this = class("professionTpl")

function this:init(config)
  self.data = config
  self.professions = {}
  for _, v in pairs(self.data) do
    table.insert(self.professions, v)
  end
  table.sort(self.professions, function(a, b)
    return a.id < b.id
  end)
end

function this:getProfessions()
  return self.professions
end

function this:getTplById(id)
  return self.data[id]
end

function this:getIcon(tpl, index)
  if index == nil then
    index = 2
  end
  local icon = L_Config:getPathByHash(tpl.icon[index])
  return icon
end

function this:getName(tpl)
  return L_Config:provider(tpl.name)
end

function this:getId(tpl)
  return tpl.id
end

function this:getDesc(tpl)
  return L_Config:provider(tpl.desc)
end

return this
