_class("UIN20AVGActorValueChange", UICustomWidget)
UIN20AVGActorValueChange = UIN20AVGActorValueChange

function UIN20AVGActorValueChange:Constructor()
  self.mCampaign = GameGlobal.GetModule(CampaignModule)
  self.data = self.mCampaign:GetN20AVGData()
end

function UIN20AVGActorValueChange:OnShow()
  self.imgIcon = self:GetUIComponent("RawImageLoader", "imgIcon")
  self.up = self:GetGameObject("up")
  self.down = self:GetGameObject("down")
end

function UIN20AVGActorValueChange:OnHide()
  self.imgIcon:DestoryLastImage()
end

function UIN20AVGActorValueChange:Flush(index, influenceValueChange)
  local actor = self.data:GetActorByIndex(index)
  self.imgIcon:LoadImage(actor.iconOption)
  if 0 < influenceValueChange then
    self.up:SetActive(true)
    self.down:SetActive(false)
  else
    self.up:SetActive(false)
    self.down:SetActive(true)
  end
end
