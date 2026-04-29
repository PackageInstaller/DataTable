_class("UIN28AVGBadgeItem", UICustomWidget)
UIN28AVGBadgeItem = UIN28AVGBadgeItem

function UIN28AVGBadgeItem:Constructor()
  self.mCampaign = GameGlobal.GetModule(CampaignModule)
  self.data = self.mCampaign:GetN28AVGData()
end

function UIN28AVGBadgeItem:OnShow()
  self.root = self:GetUIComponent("RectTransform", "root")
  self.imgIconObj = self:GetGameObject("imgIcon")
  self.btn = self:GetUIComponent("RectTransform", "btn")
  self.got = self:GetGameObject("got")
  self.imgIcon = self:GetUIComponent("RawImageLoader", "imgIcon")
  self.select = self:GetGameObject("select")
end

function UIN28AVGBadgeItem:OnHide()
  self.imgIcon:DestoryLastImage()
end

function UIN28AVGBadgeItem:Flush(id, clickCallback)
  self.id = id
  local badge = self.data:GetBadgeById(id)
  self.imgIcon:LoadImage(badge.icon)
  local show = badge:HasGot() and not badge:HasNew()
  self.got:SetActive(show)
  self.clickCallback = clickCallback
end

function UIN28AVGBadgeItem:FlushPos(pos)
  self._pos = pos
  self:_Move(self._pos, self._pos)
end

function UIN28AVGBadgeItem:FlushSelect(id)
  local select = id == self.id
  self.select:SetActive(select)
  self.imgIconObj.transform.localScale = select and Vector3(1.1, 1.1, 1.1) or Vector3.one
end

function UIN28AVGBadgeItem:BtnOnClick(go)
  if self.clickCallback then
    self:clickCallback()
  end
end

function UIN28AVGBadgeItem:FlushNewEffect()
  self.got:SetActive(true)
  self:_PlayAnim_1(function()
    self:BtnOnClick()
    self:_PlayAnim_2()
  end)
end

function UIN28AVGBadgeItem:_PlayAnim_1(callback)
  self:_Move(self._pos, Vector2(235, 0))
  UIWidgetHelper.PlayAnimation(self, "anim", "uieff_UIN28AVGBadgeItem_01", 800, callback)
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.N20GetBadge)
end

function UIN28AVGBadgeItem:_PlayAnim_2(callback)
  self:_Move(self._pos, self._pos)
  UIWidgetHelper.PlayAnimation(self, "anim", "uieff_UIN28AVGBadgeItem_02", 700, callback)
end

function UIN28AVGBadgeItem:_Move(pos1, pos2)
  self.btn.anchoredPosition = pos1
  self.root.anchoredPosition = pos2
end
