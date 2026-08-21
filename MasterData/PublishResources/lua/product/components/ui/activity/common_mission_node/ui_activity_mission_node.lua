_class("UIActivityMissionNode", UICustomWidget)
UIActivityMissionNode = UIActivityMissionNode

function UIActivityMissionNode:_GetComponents()
  self._root = self:GetGameObject("root")
  self._rectTransform = self:GetGameObject():GetComponent("RectTransform")
  self._imgIcon = self:GetUIComponent("Image", "imgIcon")
  self._txtTip = self:GetUIComponent("UILocalizationText", "txtTip")
  self._starPool = self:GetUIComponent("UISelectObjectPath", "star")
  self._starPool:SpawnObjects("UIActivityMissionNodeStar", 3)
  self._imgTipBg = self:GetUIComponent("Image", "imgTipBg")
end

function UIActivityMissionNode:Constructor()
  self._nodeInfo = nil
  self._vec0_5 = Vector2(0.5, 0.5)
  self._callback = nil
end

function UIActivityMissionNode:OnShow()
  self:_GetComponents()
end

function UIActivityMissionNode:OnHide()
end

function UIActivityMissionNode:SetData(nodeInfo, callback)
  self._nodeInfo = nodeInfo
  self._callback = callback
  self:Refresh()
  self:_SetImageMatAnim()
end

function UIActivityMissionNode:Refresh()
  self:SetUIPos()
  self:SetUIName()
  self:SetUIState()
  self:SetUIStar()
end

function UIActivityMissionNode:SetUIPos()
  self._rectTransform.anchorMax = self._vec0_5
  self._rectTransform.anchorMin = self._vec0_5
  self._rectTransform.sizeDelta = Vector2(100, 100)
  self._rectTransform.anchoredPosition = self._nodeInfo.pos
end

function UIActivityMissionNode:SetUIName()
  local name = ""
  if self._nodeInfo.name then
    name = StringTable.Get(self._nodeInfo.name)
  end
  self._txtTip.text = name
end

function UIActivityMissionNode:SetUIStar()
  local uiStars = self._starPool:GetAllSpawnList()
  for i, v in ipairs(uiStars) do
    local go = v:GetGameObject()
    local star = self._nodeInfo.starCount or 0
    go:SetActive(i <= star)
  end
end

function UIActivityMissionNode:SetUIState()
  local state = self._nodeInfo.state
  local show = state and true or false
  self._root:SetActive(show)
end

function UIActivityMissionNode:btnOnClick()
  if self._callback then
    self._callback(self._nodeInfo.campaignMissionId, self._nodeInfo.type ~= DiscoveryStageType.Plot, self._rectTransform)
  end
end

function UIActivityMissionNode:_SetImageMatAnim()
  if self._nodeInfo.isSLevel then
    self:_SetImageMatAnimSLevel()
  else
    self:_SetImageMatAnimNormal()
  end
end

function UIActivityMissionNode:_SetImageMatAnimNormal()
  local imageMat = self._imgTipBg.materialForRendering
  if imageMat == nil then
    return
  end
  local var = "_DissolveFactor"
  local startVal = 1
  imageMat:SetFloat(var, startVal)
  local seq = DG.Tweening.DOTween.Sequence()
  local delayedTimer = 0.363
  seq:AppendInterval(delayedTimer)
  local endVal = 0
  local duration = 0.396
  local tween_1 = imageMat:DOFloat(endVal, var, duration)
  seq:Append(tween_1)
end

function UIActivityMissionNode:_SetImageMatAnimSLevel()
  local imageMat = self._imgTipBg.materialForRendering
  if imageMat == nil then
    return
  end
  local var = "_DissolveFactor"
  local startVal = 1
  imageMat:SetFloat(var, startVal)
  local seq = DG.Tweening.DOTween.Sequence()
  local delayedTimer = 0.264
  seq:AppendInterval(delayedTimer)
  local endVal = 0
  local duration = 0.396
  local tween_1 = imageMat:DOFloat(endVal, var, duration)
  seq:Append(tween_1)
end
