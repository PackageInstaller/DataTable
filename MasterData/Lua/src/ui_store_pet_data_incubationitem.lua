local this = class("incubationItem")

function this:ctor()
  self.guid = nil
  self.eggGuid = nil
  self.endTime = nil
  self.use_num = nil
end

return this
