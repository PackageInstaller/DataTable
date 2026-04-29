_class("UIN28AVGReviewItem", UICustomWidget)
UIN28AVGReviewItem = UIN28AVGReviewItem

function UIN28AVGReviewItem:Constructor()
  self.mCampaign = GameGlobal.GetModule(CampaignModule)
  self.data = self.mCampaign:GetN28AVGData()
end

function UIN28AVGReviewItem:OnShow()
  self.txtActor = self:GetUIComponent("UILocalizationText", "txtActor")
  self.txtActor1 = self:GetUIComponent("UILocalizationText", "txtActor1")
  self.txtActor2 = self:GetUIComponent("UILocalizationText", "txtActor2")
  self.txtActor3 = self:GetUIComponent("UILocalizationText", "txtActor3")
  self.txtContent = self:GetUIComponent("UILocalizationText", "txtContent")
  self.img1 = self:GetGameObject("img1")
  self.img2 = self:GetGameObject("img2")
end

function UIN28AVGReviewItem:OnHide()
end

function UIN28AVGReviewItem:Flush(speakerName, content, isPlayer, callback)
  self.callback = callback
  self.txtActor:SetText(speakerName)
  self.txtActor1:SetText(speakerName)
  self.txtActor2:SetText(speakerName)
  self.txtActor3:SetText(speakerName)
  self.txtContent:SetText(content)
  self.img1:SetActive(isPlayer)
  self.img2:SetActive(not isPlayer)
end

function UIN28AVGReviewItem:BgOnClick(go)
  if self.callback then
    self.callback()
  end
end
