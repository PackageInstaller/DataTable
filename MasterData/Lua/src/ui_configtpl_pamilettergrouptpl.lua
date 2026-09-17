local this = class("pamiLetterGroupTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getIcon(tpl)
  local icon = L_Config:getPathByHash(tpl.icon)
  return icon
end

function this:getId(tpl)
  return tpl.id
end

function this:getCategoryId(tpl)
  return tpl.categoryId
end

function this:getName(tpl)
  return tpl.name
end

function this:getNation(tpl)
  return tpl.groups
end

function this:getHeroId(tpl)
  return tpl.heroId
end

return this
