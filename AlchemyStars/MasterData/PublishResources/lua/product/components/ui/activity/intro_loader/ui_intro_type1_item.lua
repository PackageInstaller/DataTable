_class("UIIntroType1Item", UICustomWidget)
UIIntroType1Item = UIIntroType1Item

function UIIntroType1Item:SetData(head, body)
  UIWidgetHelper.SetLocalizationText(self, "txtHead", head)
  UIWidgetHelper.SetLocalizationText(self, "txtBody", body)
  local txtBodyBk = self:GetUIComponent("UILocalizationText", "txtBodyBk")
  if txtBodyBk ~= nil then
    txtBodyBk:SetText(body)
  end
end

function UIIntroType1Item:SetDataWithHeadTmp(head, body)
  UIWidgetHelper.SetLocalizedTMPText(self, "txtHead", head)
  UIWidgetHelper.SetLocalizationText(self, "txtBody", body)
end
