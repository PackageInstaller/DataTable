local this = class("worldInteractivetypeTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getId(tpl)
  return tpl.id
end

function this:getIcon(tpl)
  if not string.isEmpty(tpl.icon) then
    return tpl.icon .. ".png"
  end
end

function this:getType(tpl)
  return tpl.id
end

function this:getName(tpl)
  return nil
end

return this
