local UINCarnival22TechFinalBG = class("UINCarnival22TechFinalBG", UIBaseNode)
local base = UIBaseNode

function UINCarnival22TechFinalBG:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINCarnival22TechFinalBG:InitTechFinalBG(techLineCfg)
  self.ui.tex_TitleEN.text = LanguageUtil.GetLocaleText(techLineCfg.name_en)
  self.ui.tex_TitleCN.text = LanguageUtil.GetLocaleText(techLineCfg.intro)
end

return UINCarnival22TechFinalBG
