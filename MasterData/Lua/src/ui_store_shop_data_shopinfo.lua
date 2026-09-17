local this = class("shopInfo")

function this:ctor()
  self.shopId = nil
  self.endTime = nil
  self.beginTime = nil
  self.items = {}
end

return this
