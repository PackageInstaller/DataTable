_class("UIN20AVGBadgeItem", UICustomWidget)
UIN20AVGBadgeItem = UIN20AVGBadgeItem

function UIN20AVGBadgeItem:Constructor()
  self.mCampaign = GameGlobal.GetModule(CampaignModule)
  self.data = self.mCampaign:GetN20AVGData()
end

function UIN20AVGBadgeItem:OnShow()
  self.root = self:GetUIComponent("RectTransform", "root")
  self.btn = self:GetUIComponent("RectTransform", "btn")
  self.got = self:GetGameObject("got")
  self.imgIcon = self:GetUIComponent("RawImageLoader", "imgIcon")
  self.select = self:GetGameObject("select")
end

function UIN20AVGBadgeItem:OnHide()
  self.imgIcon:DestoryLastImage()
end

function UIN20AVGBadgeItem:Flush(id, clickCallback)
  self.id = id
  local badge = self.data:GetBadgeById(id)
  self.imgIcon:LoadImage(badge.icon)
  local show = badge:HasGot() and not badge:HasNew()
  self.got:SetActive(show)
  self.clickCallback = clickCallback
end

function UIN20AVGBadgeItem:FlushPos(pos)
  self._pos = pos
  self:_Move(self._pos, self._pos)
end

function UIN20AVGBadgeItem:FlushSelect(id)
  self.select:SetActive(id == self.id)
end

function UIN20AVGBadgeItem:btnOnClick(go)
  if self.clickCallback then
    self:clickCallback()
  end
end

function UIN20AVGBadgeItem:FlushNewEffect()
  self.got:SetActive(true)
  self:_PlayAnim_1(function()
    self:btnOnClick()
    self:_PlayAnim_2()
  end)
end

function UIN20AVGBadgeItem:_PlayAnim_1(callback)
  self:_Move(self._pos, Vector2(235, 0))
  UIWidgetHelper.PlayAnimation(self, "anim", "uieff_UIN20AVGBadgeItem_01", 800, callback)
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.N20GetBadge)
end

function UIN20AVGBadgeItem:_PlayAnim_2(callback)
  self:_Move(self._pos, self._pos)
  UIWidgetHelper.PlayAnimation(self, "anim", "uieff_UIN20AVGBadgeItem_02", 700, callback)
end

function UIN20AVGBadgeItem:_Move(pos1, pos2)
  self.btn.anchoredPosition = pos1
  self.root.anchoredPosition = pos2
end
