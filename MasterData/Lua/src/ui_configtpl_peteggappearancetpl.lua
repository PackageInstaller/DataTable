local this = class("petEggAppearanceTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getId(tpl)
  return tpl.id
end

function this:getAppearance(tpl)
  return L_Config:provider(tpl.appearance)
end

return this
