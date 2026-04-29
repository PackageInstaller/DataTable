_class("UIDiffPathItem", UICustomWidget)
UIDiffPathItem = UIDiffPathItem

function UIDiffPathItem:OnShow()
  self._rect = self:GetGameObject():GetComponent("RectTransform")
  local vec0_5 = Vector2(0.5, 0.5)
  self._rect.anchorMax = vec0_5
  self._rect.anchorMin = vec0_5
  self._rectRoot = self:GetGameObject("shape"):GetComponent("RectTransform")
  self._line = self:GetGameObject("line")
  self._line:SetActive(false)
  self._shadow = self:GetGameObject("shadow")
  self._shadow:SetActive(false)
  self._sNode = nil
  self._eNode = nil
end

function UIDiffPathItem:OnHide()
end

function UIDiffPathItem:SetData(posS, posE)
  self._line:SetActive(not isShadow)
  self._shadow:SetActive(isShadow)
  if not posS then
    return
  end
  local posS = posS
  local posE = posE
  local dis = Vector2.Distance(posS, posE)
  self._rectRoot.sizeDelta = Vector2(dis, self._rectRoot.sizeDelta.y)
  self._rect.anchoredPosition = posS
  local v = posE - posS
  self._rect.localRotation = Quaternion.FromToRotation(Vector3.right, Vector3(v.x, v.y, 0))
end

function UIDiffPathItem:Animation()
  if self._eNode:State() == DiscoveryStageState.CanPlay and self._eNode:IsFirstShow() then
    local targetWidth = self._rectRoot.sizeDelta.x
    self._rectRoot.sizeDelta = Vector2(0, self._rectRoot.sizeDelta.y)
    self._rectRoot:DOSizeDelta(Vector2(targetWidth, self._rectRoot.sizeDelta.y), 0.8)
  end
end
