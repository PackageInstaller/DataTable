local UnityTime = CS.UnityEngine.Time
local TypeLineRenderer = typeof(CS.UnityEngine.LineRenderer)
local UIAnimationController = CS.Z1Client.UIAnimationController
local LineStartLocalPos = CS.UnityEngine.Vector3(0, 0, 0)
local LineMidLocalPos = CS.UnityEngine.Vector3(0, 250, 0)
local LineDestLocalPos = CS.UnityEngine.Vector3(0, 200, 0)
local BezierStartControlPointLocalOffset = CS.UnityEngine.Vector3(0, -200, 0)
local BezierEndControlPointLocalOffset = CS.UnityEngine.Vector3(0, 100, 0)
local TempVec4 = CS.UnityEngine.Vector4(1, 1, 0, 0)
local TempVecList
local BloodLineMotionSpeed = 80
local PropertyMaskA = CS.UnityEngine.Shader.PropertyToID("_MaskA_ST")
local PropertyMaskB = CS.UnityEngine.Shader.PropertyToID("_MaskB_ST")
local DbgEventEmbryoBloodLineBase, Super = System.NewClass("DbgEventEmbryoBloodLineBase")

function DbgEventEmbryoBloodLineBase:ctor(binder, battlePanel, lineGo, cardEffGo)
  Super.ctor(self)
  self.binder = binder
  self.battlePanel = battlePanel
  self.lineEffGo = lineGo
  self.cardEffGo = cardEffGo
  self.lineRenderer = self.lineEffGo:GetComponentInChildren(TypeLineRenderer)
end

function DbgEventEmbryoBloodLineBase:PrepareBloodLineEffect(cardUid)
  self.cardUid = cardUid
  local cardItem = self:GetCardItem()
  if cardItem then
    local parentTf = self.battlePanel.ui.uiNode.transform
    self.lineEffGo.transform:SetParent(parentTf, false)
    self.cardEffGo.transform:SetParent(parentTf, false)
    self.cardEffAnimController = cardItem.ui.uiNode:GetComponent(typeof(UIAnimationController))
  end
  self.lineEffGo:SetActive(false)
  self.cardEffGo:SetActive(false)
end

function DbgEventEmbryoBloodLineBase:GetCardItem()
  if not self.cardUid then
    return
  end
  do return self.battlePanel.GetCardItemByUid, self.battlePanel end
  return self.battlePanel.GetCardItemByUid, self.battlePanel, self.cardUid
end

function DbgEventEmbryoBloodLineBase:StartBloodLineEffect(callback)
  local cardItem = self:GetCardItem()
  if not cardItem then
    return
  end
  self.callback = callback
  cardItem.canvasGroup.alpha = 0
  self.lineAppearTime = 0
  self.isCardEffPlayed = false
  self:StopTransformTimer()
end

function DbgEventEmbryoBloodLineBase:Update()
  self:UpdateEffectTransform()
  self:UpdateLineEffect()
end

function DbgEventEmbryoBloodLineBase:UpdateEffectTransform()
  self:AddEmbryoCardEffect()
end

function DbgEventEmbryoBloodLineBase:AddEmbryoCardEffect()
  local cardItem = self:GetCardItem()
  if cardItem then
    cardItem.canvasGroup.alpha = 1
    cardItem.ui.uiNode:SetActive(true)
    if self.cardEffGo then
      self.cardEffGo.transform:SetParent(cardItem.cardBaseUI.Card_Content.transform, false)
      self.cardEffGo.transform:SetAsFirstSibling()
      self.cardEffGo:SetActive(true)
      self.cardEffGo.name = "UI_Vx_Battle_XueRou_02"
    end
  end
end

function DbgEventEmbryoBloodLineBase:ResetCardItem()
  local cardItem = self:GetCardItem()
  if not cardItem then
    return
  end
  if cardItem and not IsNil(cardItem.canvasGroup) then
    cardItem.canvasGroup.alpha = 1
  end
end

function DbgEventEmbryoBloodLineBase:UpdateLineEffect()
  self:CalLinePathInfo()
  self:UpdateLineRenderer()
end

function DbgEventEmbryoBloodLineBase:CalLinePathInfo()
  local cardItem = self:GetCardItem()
  if not cardItem then
    return
  end
  local uiNode = cardItem.ui.uiNode.transform
  local startPos = self.battlePanel.ui.uiNode.transform:TransformPoint(LineStartLocalPos)
  local ctrlPoint0 = self.battlePanel.ui.uiNode.transform:TransformPoint(LineStartLocalPos + BezierStartControlPointLocalOffset)
  local ctrlPoint1 = uiNode.transform:TransformPoint(LineMidLocalPos + BezierEndControlPointLocalOffset)
  local midPos = uiNode.transform:TransformPoint(LineMidLocalPos)
  local destPos = uiNode.transform:TransformPoint(LineDestLocalPos)
  self.lineDistance = CS.UnityEngine.Vector3.Distance(startPos, destPos)
  TempVecList = BezierUtils.GetQuadPointsList(startPos, ctrlPoint0, ctrlPoint1, midPos, math.max(50, math.ceil(self.lineDistance)), TempVecList)
  self.lineStartPos = startPos
  self.lineEndPos = destPos
end

function DbgEventEmbryoBloodLineBase:UpdateLineRenderer()
  self.lineRenderer.useWorldSpace = true
  self.lineRenderer.positionCount = #TempVecList + 2
  self.lineRenderer:SetPosition(0, self.lineStartPos)
  for i = 1, #TempVecList do
    self.lineRenderer:SetPosition(i, TempVecList[i])
  end
  self.lineRenderer:SetPosition(#TempVecList + 1, self.lineEndPos)
  local currDis = BloodLineMotionSpeed * self.lineAppearTime
  self.distanceScale = 1.0 - currDis / self.lineDistance
  if self.reversePlayed then
    self.distanceScale = -self.distanceScale
  end
  TempVec4.z = math.min(1, math.max(0.02, self.distanceScale))
  for i = 0, self.lineRenderer.materials.Length - 1 do
    self.lineRenderer.materials[i]:SetVector(PropertyMaskA, TempVec4)
  end
  TempVec4.z = math.min(-0.05, math.max(-1, self.distanceScale))
  for i = 0, self.lineRenderer.materials.Length - 1 do
    self.lineRenderer.materials[i]:SetVector(PropertyMaskB, TempVec4)
  end
  Vector3Pool.Instance:PushList(TempVecList)
  for k, v in pairs(TempVecList) do
    TempVecList[k] = nil
  end
end

function DbgEventEmbryoBloodLineBase:PlayLineMotionEffect()
  local function updateLineFunc()
    local gameSpeed = BattleEmbryoMgrClient.GetPlaybackSpeed()
    
    self.lineAppearTime = self.lineAppearTime + UnityTime.deltaTime * gameSpeed
    self:UpdateLineEffect()
  end
  
  self:StopLineTimer()
  self.timerUpdateLineId = self.binder:BindTimer(0, -1, updateLineFunc)
  self.lineEffGo:SetActive(true)
  self:UpdateLineEffect()
end

function DbgEventEmbryoBloodLineBase:StopTransformTimer()
  if self.binder and self.timerUpdateTransformId then
    self.binder:StopTimer(self.timerUpdateTransformId)
  end
  self.timerUpdateTransformId = nil
end

function DbgEventEmbryoBloodLineBase:StopLineTimer()
  if self.binder and self.timerUpdateLineId then
    self.binder:StopTimer(self.timerUpdateLineId)
  end
  self.timerUpdateLineId = nil
end

function DbgEventEmbryoBloodLineBase:Clear()
  self:StopTransformTimer()
  self:StopLineTimer()
  if not IsNil(self.lineEffGo) then
    self.lineEffGo:SetActive(false)
  end
  if not IsNil(self.cardEffGo) then
    self.cardEffGo:SetActive(false)
  end
  self.callback = nil
  self.binder = nil
  self.battlePanel = nil
  self.lineEffGo = nil
  self.cardEffGo = nil
  self.lineRenderer = nil
  self.cardUid = nil
  self.lineAppearTime = nil
  self.isCardEffPlayed = nil
  self.lineDistance = nil
  self.lineStartPos = nil
  self.lineEndPos = nil
  self.distanceScale = nil
end

function DbgEventEmbryoBloodLineBase:OnBloodLineMotionFinish()
  self:StopTransformTimer()
  self:StopLineTimer()
  if self.battlePanel then
    local parentTf = self.battlePanel.ui.uiNode.transform
    self.lineEffGo.transform:SetParent(parentTf, false)
    self.cardEffGo.transform:SetParent(parentTf, false)
  end
  self.lineEffGo:SetActive(false)
  self.cardEffGo:SetActive(false)
  local cb = self.callback
  self.callback = nil
  if cb then
    cb()
  end
end

return DbgEventEmbryoBloodLineBase
