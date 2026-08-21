_class("UIN20AVGBadgeProgressItem", UICustomWidget)
UIN20AVGBadgeProgressItem = UIN20AVGBadgeProgressItem

function UIN20AVGBadgeProgressItem:Constructor()
  self.mCampaign = GameGlobal.GetModule(CampaignModule)
  self.data = self.mCampaign:GetN20AVGData()
end

function UIN20AVGBadgeProgressItem:OnShow()
  self.rt = self:GetGameObject():GetComponent(typeof(UnityEngine.RectTransform))
  UICommonHelper:GetInstance():RectTransformAnchor2Left(self.rt)
  self.imgIcon = self:GetUIComponent("RawImageLoader", "imgIcon")
  self.txtCount = self:GetUIComponent("UILocalizationText", "txtCount")
  self.got = self:GetGameObject("got")
  self.canGet = self:GetGameObject("canGet")
end

function UIN20AVGBadgeProgressItem:OnHide()
  self.imgIcon:DestoryLastImage()
end

function UIN20AVGBadgeProgressItem:Flush(id, callback)
  self.callback = callback
  self.badgeStage = self.data:GetBadgeStageById(id)
  self.imgIcon:LoadImage(self.badgeStage:AwardIcon())
  self.txtCount:SetText(self.badgeStage:AwardCount())
  self:FlushState()
end

function UIN20AVGBadgeProgressItem:FlushPos(pos)
  self.rt.anchoredPosition = pos
end

function UIN20AVGBadgeProgressItem:FlushState()
  local state = self.badgeStage:State()
  if state then
    if state == AVGAwardState.CanGet then
      self.got:SetActive(false)
      self.canGet:SetActive(true)
    else
      self.got:SetActive(true)
      self.canGet:SetActive(false)
    end
  else
    self.got:SetActive(false)
    self.canGet:SetActive(false)
  end
end

function UIN20AVGBadgeProgressItem:btnOnClick(go)
  if self.callback then
    self:callback()
  end
end
