local this = class("goodsItem")

function this:ctor()
  self.slotId = nil
  self.goodsId = nil
  self.storeNum = nil
  self.buyTimes = nil
  self.deadTime = nil
  self.unlockProgress = nil
end

return this
