local UIBattleSkadaValueItem = class("UIBattleSkadaValueItem", UIBaseNode)
local base = UIBaseNode

function UIBattleSkadaValueItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UIBattleSkadaValueItem:InitSkadaValueItem(color)
  self.ui.img_Color.color = color
end

function UIBattleSkadaValueItem:SetSkadaValue(progress, value)
  self.ui.slider.value = progress
  self.ui.tex_Value:SetIndex(0, string.format("%.1f", progress * 100), tostring(value))
end

function UIBattleSkadaValueItem:OnDelete()
  base.OnDelete(self)
end

return UIBattleSkadaValueItem
