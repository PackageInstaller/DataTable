local this = class("petFeatureTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getId(tpl)
  return tpl.id
end

function this:getFeature(tpl)
  return L_Config:provider(tpl.feature)
end

return this
