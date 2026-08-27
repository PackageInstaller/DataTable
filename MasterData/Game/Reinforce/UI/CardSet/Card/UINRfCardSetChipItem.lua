local base = UIBaseNode
local UINRfCardSetChipItem = class("UINRfCardSetChipItem", base)
local UINChipItem = require("Game.CommonUI.Item.UINChipItem")

function UINRfCardSetChipItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.chip = UINChipItem.New()
  self.chip:Init(self.ui.uINChipItem)
end

function UINRfCardSetChipItem:InitRfCardSetChipItem(chipData, isLock)
  self.chip:InitChipItem(chipData, nil, nil, true)
  self.ui.obj_Lock:SetActive(isLock)
end

function UINRfCardSetChipItem:OnDelete()
  self.chip:Delete()
end

return UINRfCardSetChipItem
