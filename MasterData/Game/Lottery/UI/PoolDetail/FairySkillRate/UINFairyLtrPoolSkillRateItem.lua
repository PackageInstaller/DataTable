local UINFairyLtrPoolSkillRateItem = class("UILtrPoolDetailRateReward", UIBaseNode)
local base = UIBaseNode

function UINFairyLtrPoolSkillRateItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINFairyLtrPoolSkillRateItem:InitFairyLtrPoolSkillRateItem(skillRarityCfg)
  self.ui.tex_Name.text = LanguageUtil.GetLocaleText(skillRarityCfg.name)
  self.ui.tex_Rate:SetIndex(0, GetPreciseDecimalStr(skillRarityCfg.rate_show / 100, 2))
end

function UINFairyLtrPoolSkillRateItem:OnDelete()
  base.OnDelete(self)
end

return UINFairyLtrPoolSkillRateItem
