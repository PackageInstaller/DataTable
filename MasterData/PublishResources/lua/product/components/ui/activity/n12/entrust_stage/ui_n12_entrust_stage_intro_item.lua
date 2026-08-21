_class("UIN12EntrustStageIntroItem", UICustomWidget)
UIN12EntrustStageIntroItem = UIN12EntrustStageIntroItem

function UIN12EntrustStageIntroItem:OnShow(uiParams)
  self:_GetComponent()
end

function UIN12EntrustStageIntroItem:_GetComponent()
  self.txtHead = self:GetUIComponent("UILocalizationText", "txtHead")
  self.txtBody = self:GetUIComponent("UILocalizationText", "txtBody")
end

function UIN12EntrustStageIntroItem:Flush(head, body)
  self.txtHead:SetText(head)
  self.txtBody:SetText(body)
end
