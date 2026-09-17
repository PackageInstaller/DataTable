local this = class("accessorySetTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getId(tpl)
  return tpl.id
end

function this:getSkill(tpl)
  return tpl.skill
end

function this:getName(tpl)
  return L_Config:provider(tpl.name)
end

return this
