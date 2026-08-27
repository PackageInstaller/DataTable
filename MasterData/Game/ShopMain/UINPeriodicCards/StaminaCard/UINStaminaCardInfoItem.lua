local base = UIBaseNode
local UINStaminaCardInfoItem = class("UINStaminaCardInfoItem", base)

function UINStaminaCardInfoItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINStaminaCardInfoItem:InitStaminaCardInfoItem(infoStr)
  self.ui.tex_Info.text = infoStr
end

function UINStaminaCardInfoItem:OnDelete()
  base.OnDelete(self)
end

return UINStaminaCardInfoItem
