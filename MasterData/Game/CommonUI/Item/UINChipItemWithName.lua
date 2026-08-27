local base = require("Game.CommonUI.Item.UINChipItem")
local UINChipItemWithName = class("UINChipItemWithName", base)

function UINChipItemWithName:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.LuaUIBindingTable(self.ui.baseTransform, self.ui)
  base.OnInit(self)
end

function UINChipItemWithName:UpdateChipItem()
  base.UpdateChipItem(self)
  self.ui.name.text = self:GetChipData():GetName()
end

function UINChipItemWithName:OnDelete()
  base.OnDelete(self)
end

return UINChipItemWithName
