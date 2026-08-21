_class("UIConveneDesc", UIController)
UIConveneDesc = UIConveneDesc

function UIConveneDesc:OnShow(uiParams)
  self.txtTitle = self:GetUIComponent("UILocalizationText", "txtTitle")
  self.txtInfo = self:GetUIComponent("UILocalizationText", "txtInfo")
  self.txtTitle:SetText(StringTable.Get("str_tale_pet_convene_desc_title"))
  self.txtInfo:SetText(StringTable.Get("str_tale_pet_convene_desc_info"))
end

function UIConveneDesc:bgOnClick()
  self:CloseDialog()
end
