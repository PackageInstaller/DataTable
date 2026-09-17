local this = class("commonPlayerInformationTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getName(tpl)
  if not tpl then
    return ""
  end
  return L_Config:provider(tpl.name)
end

function this:getTypes(tpl)
  local parames = {}
  for i, v in pairs(tpl.type) do
    table.insert(parames, v)
  end
  return parames
end

function this:getShow(tpl)
  return tpl.show
end

return this
