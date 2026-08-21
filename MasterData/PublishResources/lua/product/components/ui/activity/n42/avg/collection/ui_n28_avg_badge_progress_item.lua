_class("UIN28AVGBadgeProgressItem", UICustomWidget)
UIN28AVGBadgeProgressItem = UIN28AVGBadgeProgressItem

function UIN28AVGBadgeProgressItem:Constructor()
  self.mCampaign = GameGlobal.GetModule(CampaignModule)
  self.data = self.mCampaign:GetN28AVGData()
end

function UIN28AVGBadgeProgressItem:OnShow()
  self.rt = self:GetGameObject():GetComponent(typeof(UnityEngine.RectTransform))
  UICommonHelper:GetInstance():RectTransformAnchor2Left(self.rt)
  self.imgIcon = self:GetUIComponent("RawImageLoader", "imgIcon")
  self.txtCount = self:GetUIComponent("UILocalizationText", "txtCount")
  self.btnImage = self:GetUIComponent("Image", "btn")
  self.got = self:GetGameObject("got")
  self.atlas = self:GetAsset("UIN28AVG.spriteatlas", LoadType.SpriteAtlas)
  self.canGet = self:GetGameObject("canGet")
end

function UIN28AVGBadgeProgressItem:OnHide()
  self.imgIcon:DestoryLastImage()
end

function UIN28AVGBadgeProgressItem:Flush(id, callback)
  self.callback = callback
  self.badgeStage = self.data:GetBadgeStageById(id)
  self.imgIcon:LoadImage(self.badgeStage:AwardIcon())
  self.txtCount:SetText(self.badgeStage:AwardCount())
  self:FlushState()
end

function UIN28AVGBadgeProgressItem:FlushPos(pos)
  self.rt.anchoredPosition = pos
end

function UIN28AVGBadgeProgressItem:FlushState()
  local state = self.badgeStage:State()
  if state then
    if state == N28AVGAwardState.CanGet then
      self.got:SetActive(false)
      self.canGet:SetActive(true)
      self.btnImage.sprite = self.atlas:GetSprite("N28_avg_sc_di04")
    else
      self.got:SetActive(true)
      self.canGet:SetActive(false)
      self.btnImage.sprite = self.atlas:GetSprite("N28_avg_sc_di04")
    end
  else
    self.got:SetActive(false)
    self.canGet:SetActive(false)
    self.btnImage.sprite = self.atlas:GetSprite("N28_avg_sc_di05")
  end
end

function UIN28AVGBadgeProgressItem:BtnOnClick(go)
  if self.callback then
    self:callback()
  end
end
