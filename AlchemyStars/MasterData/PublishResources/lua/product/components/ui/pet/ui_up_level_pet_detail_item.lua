_class("UIUpLevelPetDetailItem", UICustomWidget)
UIUpLevelPetDetailItem = UIUpLevelPetDetailItem

function UIUpLevelPetDetailItem:Constructor()
  self._isCurrent = false
  self._index = 0
  self._controllerName = "UIUpLevelInterfaceController"
end

function UIUpLevelPetDetailItem:OnShow(uiParams)
  self._cg = self:GetUIComponent("RawImageLoader", "cg")
  self._rawImage = self:GetUIComponent("RawImage", "cg")
  self._cgGo = self:GetGameObject("cg")
  self._center = self:GetUIComponent("RectTransform", "center")
  self._rect3 = self:GetUIComponent("RectTransform", "CenterAnchor")
  self._group3 = self:GetUIComponent("CanvasGroup", "CenterAnchor")
  self:AttachEvents()
end

function UIUpLevelPetDetailItem:OnHide()
  self:RemoveEvents()
end

function UIUpLevelPetDetailItem:OnHideCallBack()
end

function UIUpLevelPetDetailItem:SetData(index, pet, curridx)
  self._index = index
  self:UpLevelCheckIsCurrent(curridx)
  self._petInfo = pet
  self._pstid = self._petInfo:GetPstID()
  local size = Cfg.cfg_global.ui_interface_common_size.ArrayValue
  self._cgGo:GetComponent("RectTransform").sizeDelta = Vector2(size[1], size[2])
  self:LoadCgSync(self._petInfo:GetPetStaticBody(PetSkinEffectPath.BODY_LEVLE_UP))
end

function UIUpLevelPetDetailItem:LoadCgSync(matName)
  self._cg:LoadImage(matName)
  UICG.SetTransform(self._cgGo.transform, self._controllerName, matName)
  local alpha = 1
  if not self._isCurrent then
    alpha = 0
  end
  self._group3.alpha = alpha
end

function UIUpLevelPetDetailItem:AttachEvents()
  self:AttachEvent(GameEventType.UpLevelCheckIsCurrent, self.UpLevelCheckIsCurrent)
end

function UIUpLevelPetDetailItem:RemoveEvents()
  self:DetachEvent(GameEventType.UpLevelCheckIsCurrent, self.UpLevelCheckIsCurrent)
end

function UIUpLevelPetDetailItem:UpLevelCheckIsCurrent(idx)
  self._isCurrent = self._index == idx
end

function UIUpLevelPetDetailItem:GetC2C()
  return self._off
end

function UIUpLevelPetDetailItem:ChangeCanvasGroupAlpha(all, centerX)
  self._off = self._center.position.x - centerX
  local rate = self._off / all
  rate = tonumber(string.format("%.3f", rate))
  if 1 < rate then
    rate = 1
  elseif rate < -1 then
    rate = -1
  end
  local alpha = 1 - math.abs(rate)
  self._rect3.anchoredPosition = Vector2(-500 * rate, 0)
  self._group3.alpha = alpha
end
