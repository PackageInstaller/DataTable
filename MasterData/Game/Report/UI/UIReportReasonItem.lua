local UIReportReasonItem = class("UIReportReasonItem", UIBaseNode)
local base = UIBaseNode

function UIReportReasonItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddValueChangedListener(self.ui.toggle_item, self, self.OnToggleValueChanged)
end

function UIReportReasonItem:InitItem(index, report_reason, checkFunc)
  self.__index = index
  self.ui.tex_item.text = LanguageUtil.GetLocaleText(report_reason)
  self.checkFunc = checkFunc
end

function UIReportReasonItem:GetReasonId()
  return self.__index
end

function UIReportReasonItem:GetIsOn()
  return self.__isOn
end

function UIReportReasonItem:OnToggleValueChanged(isOn)
  self.__isOn = isOn
  self.ui.toggle_item.group.allowSwitchOff = false
  if self.checkFunc and isOn then
    self.checkFunc()
  end
end

function UIReportReasonItem:OnDelete()
  base.OnDelete(self)
end

return UIReportReasonItem
