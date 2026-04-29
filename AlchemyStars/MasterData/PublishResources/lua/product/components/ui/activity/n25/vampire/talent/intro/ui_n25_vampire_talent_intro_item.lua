_class("UIN25VampireTalentIntroItem", UICustomWidget)
UIN25VampireTalentIntroItem = UIN25VampireTalentIntroItem

function UIN25VampireTalentIntroItem:Constructor()
end

function UIN25VampireTalentIntroItem:OnShow(uiParams)
end

function UIN25VampireTalentIntroItem:OnHide()
end

function UIN25VampireTalentIntroItem:Flush(head, body)
  UIWidgetHelper.SetLocalizationText(self, "txtHead", head)
  UIWidgetHelper.SetLocalizationText(self, "txtBody", body)
end
