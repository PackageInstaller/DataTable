local this = class("gameActItem")

function this:ctor()
  self.id = nil
  self.name = ""
  self.describe = nil
  self.type = 0
  self.joinStart = ""
  self.joinDuration = ""
  self.value = nil
  self.sort = 0
end

return this
