_class("UIN18Intro2Item", UICustomWidget)
UIN18Intro2Item = UIN18Intro2Item

function UIN18Intro2Item:OnShow(uiParams)
end

function UIN18Intro2Item:Flush(head, body)
  UIWidgetHelper.SetLocalizationText(self, "txtHead", head)
  UIWidgetHelper.SetLocalizationText(self, "txtBody", body)
end
