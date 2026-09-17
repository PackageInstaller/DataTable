local this = class("subItemBagInfo")

function this:ctor()
  self.hide = false
  self.itemId = 0
  self.itemNum = 0
  self.itemType = 0
  self.guid = nil
  self.quality = 0
end

return this
