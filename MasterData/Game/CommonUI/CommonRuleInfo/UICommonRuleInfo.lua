local UICommonRuleInfo = class("UICommonRuleInfo", UIBaseWindow)
local base = UIBaseWindow

function UICommonRuleInfo:OnInit()
  UIUtil.SetTopStatus(self, self.__CloseUI)
  UIUtil.AddButtonListener(self.ui.background, self, self.__OnClickBackgroup)
end

function UICommonRuleInfo:InitCommonRule(ruleId)
  local ruleCfg = ConfigData.system_rule[ruleId]
  if ruleCfg == nil then
    error("system_rule MISS ruleId is " .. tostring(ruleId))
    return
  end
  self.ui.tex_MainTile.text = LanguageUtil.GetLocaleText(ruleCfg.maintitle)
  self.ui.tex_SubTile.text = LanguageUtil.GetLocaleText(ruleCfg.subtitle)
  self.ui.tex_En.text = LanguageUtil.GetLocaleText(ruleCfg.text_en)
  self.ui.tex_Des1Title.text = LanguageUtil.GetLocaleText(ruleCfg.title)
  self.ui.tex_Des1Rule.text = LanguageUtil.GetLocaleText(ruleCfg.rule_text)
end

function UICommonRuleInfo:__OnClickBackgroup()
  UIUtil.OnClickBackByUiTab(self)
end

function UICommonRuleInfo:__CloseUI()
  self:Delete()
end

return UICommonRuleInfo
