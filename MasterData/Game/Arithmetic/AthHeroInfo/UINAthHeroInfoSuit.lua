local UINAthHeroInfoSuit = class("UINAthHeroInfoSuit", UIBaseNode)
local base = UIBaseNode

function UINAthHeroInfoSuit:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINAthHeroInfoSuit:InitAthHeroInfoSuit(suitCfg, curNum, maxNum)
  self.ui.tex_Name.text = LanguageUtil.GetLocaleText(suitCfg.name)
  self.ui.tex_Count:SetIndex(0, tostring(curNum), tostring(maxNum))
end

function UINAthHeroInfoSuit:OnDelete()
  base.OnDelete(self)
end

return UINAthHeroInfoSuit
