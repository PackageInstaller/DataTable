local this = class("homeDecoration")

function this:ctor(guid)
  self.guid = nil
  self.itemID = 0
  self.yRot = 0
  self.fguid = 0
  self.pos = {
    x = 0,
    y = 0,
    z = 0
  }
end

return this
