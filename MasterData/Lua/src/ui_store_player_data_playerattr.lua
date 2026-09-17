local this = class("playerAttr")

function this:ctor()
  self.attr_id = nil
  self.attr_val = nil
  self.deadtime = nil
  self.extraLimit = nil
end

return this
