local UINPeriodBattleBossResultItem = class("UINPeriodBattleBossResultItem", UIBaseNode)
local base = UIBaseNode

function UINPeriodBattleBossResultItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINPeriodBattleBossResultItem:SetNameIdxPeriodBossResultItem(idx, value1)
  self.ui.tex_Name:SetIndex(idx, tostring(value1))
end

function UINPeriodBattleBossResultItem:SetValueIdxPeriodBossResultItem(idx, value1, value2)
  self.ui.tex_Score:SetIndex(idx, tostring(value1), tostring(value2))
end

function UINPeriodBattleBossResultItem:OnDelete()
  base.OnDelete(self)
end

return UINPeriodBattleBossResultItem
