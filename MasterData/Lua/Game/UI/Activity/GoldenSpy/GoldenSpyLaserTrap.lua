local GoldenSpyBaseTrap = require("Game.UI.Activity.GoldenSpy.GoldenSpyBaseTrap")
local GoldenSpyLaserTrap = class("GoldenSpyLaserTrap", GoldenSpyBaseTrap)
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
local LoopType = CS.DG.Tweening.LoopType
local Ease = CS.DG.Tweening.Ease.Linear
GoldenSpyLaserTrap._mapNodeConfig = {
  TriggerArea = {
    sNodeName = "TriggerArea",
    sComponentName = "RectTransform"
  },
  trRotatePivot = {
    sNodeName = "RotatePivot",
    sComponentName = "Transform"
  },
  imgIce = {},
  IceRoot = {
    sComponentName = "RectTransform"
  }
}
GoldenSpyLaserTrap._mapEventConfig = {
  GoldenSpyHookStartExtend = "OnEvent_GoldenSpyHookStartExtend",
  GM_GoldenSpy_Show = "OnEvent_GM_GoldenSpy_Show"
}
GoldenSpyLaserTrap._mapRedDotConfig = {}
GoldenSpyLaserTrap.LASER_ROTATE_EASE = "Linear"
GoldenSpyLaserTrap.TRIGGER_CHECK_INTERVAL = 0.03

function GoldenSpyLaserTrap:Awake()
  self._rotateTweener = nil
  self._triggerTimer = nil
  self._lastLaserAngle = nil
  self._rotateHeadingToMax = nil
  self.bTrigger = true
  self._mapNode.imgIce:SetActive(false)
  self._mapNode.IceRoot.gameObject:SetActive(false)
end

function GoldenSpyLaserTrap:OnEnable()
end

function GoldenSpyLaserTrap:OnDisable()
end

function GoldenSpyLaserTrap:OnDestroy()
  self:_StopRotate()
  self:_StopTriggerCheck()
end

function GoldenSpyLaserTrap:InitData()
  self.LASER_ANGLE_MIN = self.trapCfg.Params[1]
  self.LASER_ANGLE_MAX = self.trapCfg.Params[2]
  self.LASER_ROTATE_DURATION = self.trapCfg.Params[3]
  self.SUBTIME = self.trapCfg.Params[4]
end

function GoldenSpyLaserTrap:GetTriggerArea()
  local rt = self._mapNode.TriggerArea
  if rt == nil or rt:IsNull() then
    return {}
  end
  return {
    nType = AllEnum.GoldenSpyHitAreaType.Rectangle,
    center = rt.position,
    width = rt.sizeDelta.x,
    height = rt.sizeDelta.y
  }
end

function GoldenSpyLaserTrap:FinishFloor()
  self:_StopRotate()
  self:_StopTriggerCheck()
end

function GoldenSpyLaserTrap:_StartRotate()
  self:_StopRotate()
  local pivot = self._mapNode.trRotatePivot
  if pivot == nil or pivot:IsNull() then
    pivot = self.transform
  end
  if pivot == nil then
    return
  end
  local angleMin = self.LASER_ANGLE_MIN or -90
  local angleMax = self.LASER_ANGLE_MAX or 90
  local duration = self.LASER_ROTATE_DURATION or 3
  local fullRange = math.max(0.001, angleMax - angleMin)
  local tweenAngleMin = angleMin
  local tweenAngleMax = angleMax
  if 0.001 > math.abs(fullRange - 180) then
    tweenAngleMax = angleMax - 0.01
  end
  local currentZ = pivot.localEulerAngles.z
  if 180 < currentZ then
    currentZ = currentZ - 360
  end
  self._lastLaserAngle = currentZ
  local RotateMode = CS.DG.Tweening.RotateMode.Fast
  local headingToMax = self._rotateHeadingToMax ~= false
  if currentZ >= angleMax - 0.01 then
    self._rotateHeadingToMax = false
    self._rotateTweener = pivot:DOLocalRotate(Vector3(0, 0, tweenAngleMin), duration, RotateMode):SetEase(Ease):SetLoops(-1, LoopType.Yoyo):SetUpdate(true)
  elseif currentZ <= angleMin + 0.01 then
    self._rotateHeadingToMax = true
    self._rotateTweener = pivot:DOLocalRotate(Vector3(0, 0, tweenAngleMax), duration, RotateMode):SetEase(Ease):SetLoops(-1, LoopType.Yoyo):SetUpdate(true)
  elseif headingToMax then
    self._rotateHeadingToMax = true
    local ratio = math.abs(angleMax - currentZ) / fullRange
    local durationFirst = duration * math.max(0.01, ratio)
    local seq = DOTween.Sequence()
    seq:SetUpdate(true)
    seq:Append(pivot:DOLocalRotate(Vector3(0, 0, tweenAngleMax), durationFirst, RotateMode):SetEase(Ease))
    seq:Append(pivot:DOLocalRotate(Vector3(0, 0, tweenAngleMin), duration, RotateMode):SetEase(Ease):SetLoops(-1, LoopType.Yoyo))
    self._rotateTweener = seq
  else
    self._rotateHeadingToMax = false
    local ratio = math.abs(currentZ - angleMin) / fullRange
    local durationFirst = duration * math.max(0.01, ratio)
    local seq = DOTween.Sequence()
    seq:SetUpdate(true)
    seq:Append(pivot:DOLocalRotate(Vector3(0, 0, tweenAngleMin), durationFirst, RotateMode):SetEase(Ease))
    seq:Append(pivot:DOLocalRotate(Vector3(0, 0, tweenAngleMax), duration, RotateMode):SetEase(Ease):SetLoops(-1, LoopType.Yoyo))
    self._rotateTweener = seq
  end
end

function GoldenSpyLaserTrap:_StopRotate()
  if self._rotateTweener ~= nil then
    self._rotateTweener:Kill()
    self._rotateTweener = nil
  end
end

function GoldenSpyLaserTrap:_IsHookInTriggerArea(hookPos, hookRadius)
  if hookPos == nil then
    return false
  end
  local rt = self._mapNode.TriggerArea
  if rt == nil or rt:IsNull() then
    return false
  end
  local radius = hookRadius ~= nil and hookRadius or self.HOOK_TRIGGER_RADIUS_DEFAULT or 0
  local w = rt.sizeDelta.x
  local h = rt.sizeDelta.y
  local hw = w * 0.5
  local hh = h * 0.5
  local x, y = hookPos.x, hookPos.y
  local dx = math.max(0, math.abs(x) - hw)
  local dy = math.max(0, math.abs(y) - hh)
  local distSq = dx * dx + dy * dy
  return distSq <= radius * radius
end

function GoldenSpyLaserTrap:_OnTriggerCheck()
  local pivot = self._mapNode.trRotatePivot
  if pivot == nil or pivot:IsNull() then
    pivot = self.transform
  end
  if pivot ~= nil then
    local z = pivot.localEulerAngles.z
    if 180 < z then
      z = z - 360
    end
    if self._lastLaserAngle ~= nil then
      if z > self._lastLaserAngle then
        self._rotateHeadingToMax = true
      elseif z < self._lastLaserAngle then
        self._rotateHeadingToMax = false
      end
    end
    self._lastLaserAngle = z
  end
  local bInvincible = self.floorCtrl:GetHookIsInvincible()
  if bInvincible then
    return
  end
  local hookPos = self.floorCtrl:GetHookEndPos()
  local localPos = self.floorCtrl:GetHookEndPosInRectLocal(self._mapNode.TriggerArea)
  local hookRadius = self.floorCtrl:GetHookRadius()
  if self:_IsHookInTriggerArea(localPos, hookRadius) and self.bTrigger then
    if self.floorCtrl:CheckCanDropItem() then
      self.floorCtrl:DropItem()
      self.floorCtrl:DoStartRetract()
    end
    WwiseAudioMgr:PostEvent("Mode_steal_error")
    self.floorCtrl:SubTime(self.SUBTIME)
    self.bTrigger = false
  end
end

function GoldenSpyLaserTrap:_StartTriggerCheck()
  self:_StopTriggerCheck()
  local interval = self.TRIGGER_CHECK_INTERVAL or 0.03
  self._triggerTimer = self:AddTimer(0, interval, function()
    self:_OnTriggerCheck()
  end, true, true, true)
end

function GoldenSpyLaserTrap:_StopTriggerCheck()
  if self._triggerTimer ~= nil then
    self._triggerTimer:Cancel()
    self._triggerTimer = nil
  end
end

function GoldenSpyLaserTrap:StartFloor()
  self:_StartRotate()
  self:_StartTriggerCheck()
end

function GoldenSpyLaserTrap:Pause()
  self:_StopRotate()
  self:_StopTriggerCheck()
end

function GoldenSpyLaserTrap:Resume()
  if self.bFrozen then
    return
  end
  self:_StartRotate()
  self:_StartTriggerCheck()
end

function GoldenSpyLaserTrap:OnSkill_Frozen(callback)
  self.bFrozen = true
  self:_StopRotate()
  self:_StopTriggerCheck()
  self._mapNode.imgIce:SetActive(true)
  if callback then
    callback()
  end
end

function GoldenSpyLaserTrap:OnSkill_Frozen_Resume(callback)
  self.bFrozen = false
  self:_StartRotate()
  self:_StartTriggerCheck()
  self._mapNode.imgIce:SetActive(false)
  self:AddTimer(1, 0.5, function()
    self._mapNode.IceRoot.gameObject:SetActive(false)
  end, true, true, true)
  if callback then
    callback()
  end
end

function GoldenSpyLaserTrap:OnBtnClick_AAA()
end

function GoldenSpyLaserTrap:OnEvent_GoldenSpyHookStartExtend()
  self.bTrigger = true
end

function GoldenSpyLaserTrap:OnEvent_GM_GoldenSpy_Show()
  local img = self._mapNode.TriggerArea:GetComponent("Image")
  if img then
    img.enabled = true
  end
end

return GoldenSpyLaserTrap
