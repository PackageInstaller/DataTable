_class("UICampaignSeniorSkinLable", UICustomWidget)
UICampaignSeniorSkinLable = UICampaignSeniorSkinLable

function UICampaignSeniorSkinLable:OnShow()
  self._title = self:GetUIComponent("UILocalizedTMP", "title")
  self._title.color = Color.white
  local mat = self:GetAsset("ui_campaign_senior_skin.mat", LoadType.Mat)
  local old = self._title.fontMaterial
  self._title.fontMaterial = mat
  self._title.fontMaterial:SetTexture("_MainTex", old:GetTexture("_MainTex"))
end
