local UINLtrPoolUpRule = class("UINLtrPoolUpRule", UIBaseNode)
local base = UIBaseNode

function UINLtrPoolUpRule:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINLtrPoolUpRule:InitLtrPoolUpRule(poolCfg)
  self.ui.tex_Des1Title.text = LanguageUtil.GetLocaleText(poolCfg.up_title)
  self.ui.tex_Des1Rule.text = LanguageUtil.GetLocaleText(poolCfg.up_des)
end

function UINLtrPoolUpRule:OnDelete()
  base.OnDelete(self)
end

return UINLtrPoolUpRule
