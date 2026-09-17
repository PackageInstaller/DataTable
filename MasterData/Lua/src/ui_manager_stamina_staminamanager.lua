local this = class("staminaManager")

function this:ctor()
  self.id = 1
end

function this:setSelectId(selectId)
  self.id = selectId
end

function this:getSelectId()
  return self.id
end

return this
