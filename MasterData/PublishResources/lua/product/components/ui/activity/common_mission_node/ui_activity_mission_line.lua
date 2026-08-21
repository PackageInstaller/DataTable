_class("UIActivityMissionLine", UICustomWidget)
UIActivityMissionLine = UIActivityMissionLine

function UIActivityMissionLine:OnShow()
  self._go = self:GetGameObject()
  self._rect = self._go:GetComponent("RectTransform")
  self._go:SetActive(false)
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
  self:AttachEvent(GameEventType.DiscoveryNodeStateChange, self.FlushState)
end

function UIActivityMissionLine:OnHide()
  self:DetachEvent(GameEventType.DiscoveryNodeStateChange, self.FlushState)
end

function UIActivityMissionLine:Flush(sNode, eNode, isShadow)
  self._line:SetActive(not isShadow)
  self._shadow:SetActive(isShadow)
  if not sNode then
    return
  end
  if not eNode then
    return
  end
  self._sNode = sNode
  self._eNode = eNode
  local posS, posE = sNode.pos:Clone(), eNode.pos:Clone()
  if isShadow then
    local offsetY = 30
    posS.y = posS.y - offsetY
    posE.y = posE.y - offsetY
  end
  local dis = Vector2.Distance(posS, posE)
  self._rectRoot.sizeDelta = Vector2(dis, self._rectRoot.sizeDelta.y)
  self._rect.anchoredPosition = posS
  local v = posE - posS
  self._rect.localRotation = Quaternion.FromToRotation(Vector3.right, Vector3(v.x, v.y, 0))
  self:FlushState(self._sNode.campaignMissionId)
  self:Animation()
end

function UIActivityMissionLine:FlushState(nodeId)
  if nodeId ~= self._sNode.campaignMissionId then
    return
  end
  local sState = self._sNode.state
  self._go:SetActive(sState == DiscoveryStageState.Nomal)
end

function UIActivityMissionLine:Animation()
  if self._eNode.State == DiscoveryStageState.CanPlay then
    local targetWidth = self._rectRoot.sizeDelta.x
    self._rectRoot.sizeDelta = Vector2(0, self._rectRoot.sizeDelta.y)
    self._rectRoot:DOSizeDelta(Vector2(targetWidth, self._rectRoot.sizeDelta.y), 0.8)
  end
end
