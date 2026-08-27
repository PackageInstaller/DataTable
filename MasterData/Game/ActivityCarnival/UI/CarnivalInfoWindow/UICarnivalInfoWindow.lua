local base = UIBaseWindow
local UICarnivalInfoWindow = class("UICarnivalInfoWindow", base)

function UICarnivalInfoWindow:OnInit()
  UIUtil.AddButtonListener(self.ui.btn_BG, self, self._OnClickClose)
  UIUtil.AddButtonListener(self.ui.btn_Cancle, self, self._OnClickClose)
end

function UICarnivalInfoWindow:InitCarnivalTaskIntroRule(ruleId)
  UIUtil.SetTopStatus(self, self.Delete, nil, nil, nil, true)
  local ruleCfg = ConfigData.system_rule[ruleId]
  if ruleCfg == nil then
    error("rule is NIL " .. tostring(ruleId))
    return
  end
  self.ui.tex_Des1Rule.text = LanguageUtil.GetLocaleText(ruleCfg.rule_text)
end

function UICarnivalInfoWindow:InitCarnivalInfoWindow(ruleId)
  UIUtil.SetTopStatus(self, self.Delete, nil, nil, nil, true)
  local ruleCfg = ConfigData.system_rule[ruleId]
  if ruleCfg == nil then
    error("rule is NIL " .. tostring(ruleId))
    return
  end
  self.ui.tex_Des1Rule.text = LanguageUtil.GetLocaleText(ruleCfg.rule_text)
  self.ui.tex_Title.text = LanguageUtil.GetLocaleText(ruleCfg.maintitle)
end

function UICarnivalInfoWindow:_OnClickClose()
  UIUtil.OnClickBackByUiTab(self)
end

function UICarnivalInfoWindow:OnDelete()
  base.OnDelete(self)
end

return UICarnivalInfoWindow
