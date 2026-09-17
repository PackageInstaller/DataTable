local this = class("commonItemTypeTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getId(tpl)
  return tpl.id
end

function this:getDesc(tpl)
  return tpl.desc
end

function this:getIcon(tpl)
  return tpl.icon
end

return this
