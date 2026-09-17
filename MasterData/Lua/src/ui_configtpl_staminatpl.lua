local this = class("staminaTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getId(tpl)
  return tpl.id
end

function this:getStamina(tpl)
  return tpl.stamina
end

function this:getPrice(tpl)
  return tpl.price
end

function this:getMax()
  return #self.data
end

return this
