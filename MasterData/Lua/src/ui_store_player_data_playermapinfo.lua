local this = class("playerMapInfo")

function this:ctor()
  self.status = nil
  self.mount_status = nil
  self.reason = nil
  self.speed = nil
  self.jump = false
  self.mount = nil
  self.group = {
    heros = {},
    control = nil
  }
end

return this
