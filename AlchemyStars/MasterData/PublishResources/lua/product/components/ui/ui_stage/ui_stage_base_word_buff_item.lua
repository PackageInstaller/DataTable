_class("UIStageBaseWordBuffItem", UICustomWidget)
UIStageBaseWordBuffItem = UIStageBaseWordBuffItem

function UIStageBaseWordBuffItem:SetData(str)
  UIWidgetHelper.SetLocalizationText(self, "_txt", str)
end
