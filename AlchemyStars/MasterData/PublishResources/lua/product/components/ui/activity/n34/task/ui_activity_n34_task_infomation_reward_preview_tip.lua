_class("UIActivityN34TaskInfomationRewardPreviewTip", UIController)
UIActivityN34TaskInfomationRewardPreviewTip = UIActivityN34TaskInfomationRewardPreviewTip

function UIActivityN34TaskInfomationRewardPreviewTip:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
end

function UIActivityN34TaskInfomationRewardPreviewTip:OnShow(uiParams)
  self:InitWidget()
  local cfg = uiParams[1]
  self.petName:SetText(StringTable.Get(cfg.Name))
  self.content:SetText(StringTable.Get(cfg.Des))
end

function UIActivityN34TaskInfomationRewardPreviewTip:InitWidget()
  self.petName = self:GetUIComponent("UILocalizationText", "PetName")
  self.content = self:GetUIComponent("UILocalizationText", "Content")
end

function UIActivityN34TaskInfomationRewardPreviewTip:CloseOnClick(go)
  self:CloseDialog()
end
