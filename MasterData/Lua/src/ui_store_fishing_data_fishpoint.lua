local this = class("fishPoint")

function this:ctor()
  self.pond_id = 0
  self.count = 0
  self.refresh_time = 0
end

return this
