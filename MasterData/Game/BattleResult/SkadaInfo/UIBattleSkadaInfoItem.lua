local UIBattleSkadaInfoItem = class("UIBattleSkadaInfoItem", UIBaseNode)
local base = UIBaseNode

function UIBattleSkadaInfoItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UIBattleSkadaInfoItem:InitSkadaInfoItem(color, name, count, value, proportion)
  self.ui.img_Color.color = color
  self.ui.tex_SkillName.text = name
  self.ui.tex_SkillCount.text = count and tostring(count) or ""
  self.ui.tex_SkillHurt.text = tostring(value)
  self.ui.proportion.text = string.format("%.1f", proportion * 100)
end

function UIBattleSkadaInfoItem:OnDelete()
  base.OnDelete(self)
end

return UIBattleSkadaInfoItem
