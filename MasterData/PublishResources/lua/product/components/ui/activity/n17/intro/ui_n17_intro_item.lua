_class("UIN17IntroItem", UICustomWidget)
UIN17IntroItem = UIN17IntroItem

function UIN17IntroItem:OnShow(uiParams)
end

function UIN17IntroItem:Flush(head, body)
  UIWidgetHelper.SetLocalizationText(self, "txtHead", head)
  UIWidgetHelper.SetLocalizationText(self, "txtBody", body)
end
