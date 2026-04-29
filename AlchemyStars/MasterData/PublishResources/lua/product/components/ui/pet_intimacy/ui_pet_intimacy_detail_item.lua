_class("UIPetIntimacyDetailItem", UICustomWidget)
UIPetIntimacyDetailItem = UIPetIntimacyDetailItem

function UIPetIntimacyDetailItem:Constructor()
  self._index = 0
  self._isCurrent = false
  self._module = GameGlobal.GetModule(PetModule)
  self._controllerName = "UIPetIntimacyMainController"
end

function UIPetIntimacyDetailItem:OnShow(uiParams)
  self._cg = self:GetUIComponent("RawImageLoader", "cg")
  self._rawImage = self:GetUIComponent("RawImage", "cg")
  self._cgGo = self:GetGameObject("cg")
  self._center = self:GetUIComponent("RectTransform", "center")
  self._rect1 = self:GetUIComponent("RectTransform", "rect1")
  self._group1 = self:GetUIComponent("CanvasGroup", "rect1")
  self:AttachEvents()
end

function UIPetIntimacyDetailItem:AttachEvents()
  self:AttachEvent(GameEventType.BreakCheckIsCurrent, self.BreakCheckIsCurrent)
end

function UIPetIntimacyDetailItem:RemoveEvents()
  self:DetachEvent(GameEventType.BreakCheckIsCurrent, self.BreakCheckIsCurrent)
end

function UIPetIntimacyDetailItem:BreakCheckIsCurrent(idx)
  self._isCurrent = self._index == idx
end

function UIPetIntimacyDetailItem:OnHide()
  self._index = 0
  self:RemoveEvents()
end

function UIPetIntimacyDetailItem:OnHideCallBack()
end

function UIPetIntimacyDetailItem:SetData(index, pet, curridx)
  self._index = index
  self:BreakCheckIsCurrent(curridx)
  self._pet = pet
  self._pstid = self._pet:GetPstID()
  local size = Cfg.cfg_global.ui_interface_common_size.ArrayValue
  self._cgGo:GetComponent("RectTransform").sizeDelta = Vector2(size[1], size[2])
  self:LoadCgSync(self._pet:GetPetStaticBody(PetSkinEffectPath.BODY_PET_INTIMACY))
end

function UIPetIntimacyDetailItem:LoadCgSync(matName)
  self._cg:LoadImage(matName)
  UICG.SetTransform(self._cgGo.transform, self._controllerName, matName)
  local alpha = 1
  if not self._isCurrent then
    alpha = 0
  end
  self._group1.alpha = alpha
end

function UIPetIntimacyDetailItem:GetC2C()
  return self._off
end

function UIPetIntimacyDetailItem:ChangeCanvasGroupAlpha(all, centerX)
  self._off = self._center.position.x - centerX
  local rate = self._off / all
  rate = tonumber(string.format("%.3f", rate))
  if 1 < rate then
    rate = 1
  elseif rate < -1 then
    rate = -1
  end
  local alpha = 1 - math.abs(rate)
  self._rect1.anchoredPosition = Vector2(-1200 * rate, 0)
  self._group1.alpha = alpha
end
