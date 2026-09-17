local this = class("photographPicTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getIcon(tpl)
  return tpl.icon
end

function this:getSystemUnlock(tpl)
  return tpl.systemUnlock
end

function this:getId(tpl)
  return tpl.id
end

return this
