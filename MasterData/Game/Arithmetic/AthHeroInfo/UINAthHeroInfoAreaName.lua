local UINAthHeroInfoAreaName = class("UINAthHeroInfoAreaName", UIBaseNode)
local base = UIBaseNode

function UINAthHeroInfoAreaName:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINAthHeroInfoAreaName:InitAthHeroInfoAreaName(name, anchoredPosition, nameIndex)
  self.transform.anchoredPosition = anchoredPosition or Vector2.zero
  self.ui.tex_AreaName:SetIndex(nameIndex, name)
end

function UINAthHeroInfoAreaName:OnDelete()
  base.OnDelete(self)
end

return UINAthHeroInfoAreaName
