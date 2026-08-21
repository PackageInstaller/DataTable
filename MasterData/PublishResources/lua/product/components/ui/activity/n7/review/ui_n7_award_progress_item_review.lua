_class("UIN7AwardProgressItemReview", UICustomWidget)
UIN7AwardProgressItemReview = UIN7AwardProgressItemReview

function UIN7AwardProgressItemReview:OnShow()
  self.anim = self:GetUIComponent("Animation", "UIN7AwardProgressItemReview")
  self.go = self:GetGameObject("UIN7AwardProgressItemReview")
  self.got = self:GetGameObject("got")
  self.canGet = self:GetGameObject("canGet")
  self.goNot = self:GetGameObject("goNot")
  self.ImgIcon = self:GetUIComponent("RawImageLoader", "ImgIcon")
  self.txtPercentLow = self:GetUIComponent("UILocalizationText", "txtPercentLow")
  self.txtPercent = self:GetUIComponent("UILocalizationText", "txtPercent")
end

function UIN7AwardProgressItemReview:OnHide()
  self.ImgIcon:DestoryLastImage()
end

function UIN7AwardProgressItemReview:Flush(progress, callback, itemCallbacl)
  self.progress = progress
  self.callback = callback
  self.itemCallbacl = itemCallbacl
  local icon, name, desc = progress:IconNameDesc()
  self.ImgIcon:LoadImage(icon)
  local percent = progress:GetProgressPercentString()
  self.txtPercentLow:SetText(percent)
  self.txtPercent:SetText(percent)
  local state = progress:State()
  if state == CampaignPointProgressStatus.CPPS_Accepted then
    self.got:SetActive(false)
    self.canGet:SetActive(false)
    self.goNot:SetActive(true)
  elseif state == CampaignPointProgressStatus.CPPS_Completed then
    self.got:SetActive(false)
    self.canGet:SetActive(true)
    self.goNot:SetActive(false)
  elseif state == CampaignPointProgressStatus.CPPS_Taken then
    self.got:SetActive(true)
    self.canGet:SetActive(false)
    self.goNot:SetActive(false)
  else
    Log.fatal("### invalid CampaignPointProgressStatus")
  end
end

function UIN7AwardProgressItemReview:ImgCanGetOnClick(go)
  if self.callback then
    self.callback()
  end
end

function UIN7AwardProgressItemReview:ImgIconOnClick(go)
  if self.itemCallbacl then
    self.itemCallbacl()
  end
end

function UIN7AwardProgressItemReview:PlayAnim()
  self.anim:Play("uieff_N7_AwardProgressReview1")
end

function UIN7AwardProgressItemReview:ShowHideGo(isShow)
  self.go:SetActive(isShow)
end
