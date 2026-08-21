_class("UIN20AVGReviewItem", UICustomWidget)
UIN20AVGReviewItem = UIN20AVGReviewItem

function UIN20AVGReviewItem:Constructor()
  self.mCampaign = GameGlobal.GetModule(CampaignModule)
  self.data = self.mCampaign:GetN20AVGData()
end

function UIN20AVGReviewItem:OnShow()
  self.txtActor = self:GetUIComponent("UILocalizationText", "txtActor")
  self.txtContent = self:GetUIComponent("UILocalizationText", "txtContent")
  self.img1 = self:GetGameObject("img1")
  self.img2 = self:GetGameObject("img2")
end

function UIN20AVGReviewItem:OnHide()
end

function UIN20AVGReviewItem:Flush(speakerName, content, isPlayer, callback)
  self.callback = callback
  self.txtActor:SetText(speakerName)
  self.txtContent:SetText(content)
  self.img1:SetActive(isPlayer)
  self.img2:SetActive(not isPlayer)
end

function UIN20AVGReviewItem:BgOnClick(go)
  if self.callback then
    self.callback()
  end
end
