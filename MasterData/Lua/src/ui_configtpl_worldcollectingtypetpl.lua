local this = class("worldCollectingTypeTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getIcon(tpl)
  return tpl.icon
end

function this:getShow(tpl)
  return tpl.show
end

function this:getName(tpl)
  return L_Config:provider(tpl.name)
end

function this:getId(tpl)
  return tpl.id
end

function this:getAllType()
  return self.data
end

return this
