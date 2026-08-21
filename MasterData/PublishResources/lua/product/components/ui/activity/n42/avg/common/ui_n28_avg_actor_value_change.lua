_class("UIN28AVGActorValueChange", UICustomWidget)
UIN28AVGActorValueChange = UIN28AVGActorValueChange

function UIN28AVGActorValueChange:Constructor()
  self.mCampaign = GameGlobal.GetModule(CampaignModule)
  self.data = self.mCampaign:GetN28AVGData()
end

function UIN28AVGActorValueChange:OnShow()
  self.imgIcon = self:GetUIComponent("RawImageLoader", "imgIcon")
  self.up = self:GetGameObject("up")
  self.down = self:GetGameObject("down")
end

function UIN28AVGActorValueChange:OnHide()
  self.imgIcon:DestoryLastImage()
end

function UIN28AVGActorValueChange:Flush(index, influenceValueChange)
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
