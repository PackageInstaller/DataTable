local this = class("gameEventsRewardGroupTpl")

function this:init(config)
  self.data = config
end

function this:getData()
  return self.data
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

return this
