local GoldenSpyBaseItem = require("Game.UI.Activity.GoldenSpy.GoldenSpyBaseItem")
local GoldenSpyPatrolItem = class("GoldenSpyPatrolItem", GoldenSpyBaseItem)
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
local VisionAngle = 45
local VisionRadius = 250
GoldenSpyPatrolItem._mapNodeConfig = {
  trDrone = {
    sNodeName = "Drone",
    sComponentName = "RectTransform"
  },
  StartPoint = {
    sNodeName = "StartPoint",
    sComponentName = "RectTransform"
  },
  EndPoint = {
    sNodeName = "EndPoint",
    sComponentName = "RectTransform"
  },
  VisionPoint = {
    sNodeName = "VisionPoint",
    sComponentName = "RectTransform"
  },
  img_normal = {},
  img_warning = {},
  HitArea = {
    sNodeName = "HitArea",
    sComponentName = "RectTransform"
  },
  animator = {sNodeName = "Icon", sComponentName = "Animator"},
  flash = {},
  imgIce = {},
  IceRoot = {
    sComponentName = "RectTransform"
  }
}
GoldenSpyPatrolItem._mapEventConfig = {
  GoldenSpyHookStartExtend = "OnEvent_GoldenSpyHookStartExtend",
  GM_GoldenSpy_Show = "OnEvent_GM_GoldenSpy_Show"
}
GoldenSpyPatrolItem._mapRedDotConfig = {}

function GoldenSpyPatrolItem:Awake()
  self._moveTweener = nil
  self._visionUpdateTimer = nil
  self._mapNode.img_normal:SetActive(true)
  self._mapNode.img_warning:SetActive(false)
  self.bTrigger = true
  self._mapNode.flash:SetActive(false)
  self._mapNode.imgIce:SetActive(false)
  self._mapNode.IceRoot.gameObject:SetActive(false)
end

function GoldenSpyPatrolItem:OnEnable()
end

function GoldenSpyPatrolItem:OnDisable()
end

function GoldenSpyPatrolItem:OnDestroy()
  self:StopMove()
end

function GoldenSpyPatrolItem:Init()
  self.nUid = nil
  self.nItemId = nil
  self.bDirection = true
  self.nBagItemPrice = 0
  local startPoint = self._mapNode.StartPoint.anchoredPosition
  self.vStartPoint = Vector3(startPoint.x, startPoint.y, 0)
  local endPoint = self._mapNode.EndPoint.anchoredPosition
  self.vEndPoint = Vector3(endPoint.x, endPoint.y, 0)
  local visionPoint = self._mapNode.VisionPoint.anchoredPosition
  self.vVisionPoint = Vector3(visionPoint.x, visionPoint.y, 0)
  self.bDirection = self.vEndPoint.x > self.vStartPoint.x
  self.bDestination = false
  self.trParent = self.gameObject.transform.parent
  self.bFrozen = false
end

function GoldenSpyPatrolItem:InitData()
  self.nVisionAngle = self.itemCfg.Params[3] or VisionAngle
  self.nVisionRadius = self.itemCfg.Params[4] or VisionRadius
end

function GoldenSpyPatrolItem:StartFloor()
  self:StartMove()
end

function GoldenSpyPatrolItem:FinishFloor()
  self:StopMove()
end

function GoldenSpyPatrolItem:GetHitArea()
  local tr = self.gameObject:GetComponent("RectTransform")
  local hitArea = {
    nType = self.nHitAreaType,
    center = self._mapNode.HitArea.anchoredPosition + tr.anchoredPosition + self._mapNode.trDrone.anchoredPosition,
    width = self._mapNode.HitArea.sizeDelta.x,
    height = self._mapNode.HitArea.sizeDelta.y
  }
  return hitArea
end

function GoldenSpyPatrolItem:Boom(callback)
  if callback then
    callback()
  end
  self.gameObject:SetActive(false)
end

function GoldenSpyPatrolItem:GetVisionArea()
  local visionArea = {
    center = self._mapNode.VisionPoint.anchoredPosition + self.gameObject.transform.anchoredPosition,
    radius = self._mapNode.VisionPoint.sizeDelta.x * 0.5,
    direction = self.bDirection
  }
  return visionArea
end

function GoldenSpyPatrolItem:Pause()
  if self._moveTweener ~= nil then
    self._moveTweener:Pause()
  end
  if self._visionUpdateTimer ~= nil then
    self._visionUpdateTimer:Pause(true)
  end
end

function GoldenSpyPatrolItem:Resume()
  if self.bFrozen then
    return
  end
  if self._moveTweener ~= nil then
    self._moveTweener:Play()
  end
  if self._visionUpdateTimer ~= nil then
    self._visionUpdateTimer:Pause(false)
  end
end

function GoldenSpyPatrolItem:onCatch(callback)
  self:StopMove()
  self._mapNode.trDrone.anchoredPosition = Vector2.zero
  if self.visionTimer ~= nil then
    self.visionTimer:Cancel()
    self.visionTimer = nil
  end
  self._mapNode.img_warning:SetActive(false)
  self._mapNode.img_normal:SetActive(false)
  self._mapNode.animator:Play("Companion_out")
  if callback then
    callback()
  end
end

function GoldenSpyPatrolItem:OnSkill_Boom(callback)
  self:StopMove()
  if callback then
    callback()
  end
  if self.gameObject then
    self.gameObject:SetActive(false)
  end
end

function GoldenSpyPatrolItem:OnSkill_Frozen(callback)
  self.bFrozen = true
  self._mapNode.imgIce:SetActive(true)
  self._mapNode.img_normal:SetActive(false)
  self._mapNode.img_warning:SetActive(false)
  self._mapNode.animator:Play("Companion_out")
  self:Pause()
  if callback then
    callback()
  end
end

function GoldenSpyPatrolItem:OnSkill_Frozen_Resume(callback)
  self.bFrozen = false
  self._mapNode.imgIce:SetActive(false)
  self._mapNode.IceRoot:SetParent(self.gameObject.transform)
  self._mapNode.IceRoot.anchoredPosition = self._mapNode.trDrone.anchoredPosition
  self._mapNode.IceRoot.gameObject:SetActive(true)
  self._mapNode.img_normal:SetActive(true)
  self._mapNode.animator:Play("Companion_idle")
  if self._moveTweener ~= nil then
    self._moveTweener:Play()
  end
  if self._visionUpdateTimer ~= nil then
    self._visionUpdateTimer:Pause(false)
  end
  self:AddTimer(1, 0.5, function()
    self._mapNode.IceRoot.gameObject:SetActive(false)
    self._mapNode.IceRoot:SetParent(self._mapNode.trDrone)
  end, true, true, true)
  if callback then
    callback()
  end
end

function GoldenSpyPatrolItem:StartMove()
  self:StopMove()
  self.bDirection = self.vEndPoint.x > self.vStartPoint.x
  self:_ApplyForwardRotation()
  self:_StartMoveTween()
  self:_StartVisionCheck()
end

function GoldenSpyPatrolItem:_StartMoveTween()
  local tr = self._mapNode.trDrone
  if tr == nil then
    return
  end
  local from = tr.anchoredPosition
  local to = self.bDestination and self.vStartPoint or self.vEndPoint
  local dist = to.x - from.x
  local duration = math.abs(dist / (self.itemCfg.Params[1] or 100))
  if duration <= 0 then
    self:_OnReachTarget()
    return
  end
  if self._moveTweener ~= nil then
    self._moveTweener:Kill(false)
    self._moveTweener = nil
  end
  self._moveTweener = tr:DOAnchorPosX(to.x, duration):SetEase(Ease.Linear):SetUpdate(true):OnUpdate(function()
  end):OnComplete(function()
    self:_OnReachTarget()
  end):OnKill(function()
  end)
end

function GoldenSpyPatrolItem:StopMove()
  self:_KillMoveTween()
  self:_StopVisionCheck()
end

function GoldenSpyPatrolItem:_OnReachTarget()
  self.bDirection = not self.bDirection
  self.bDestination = not self.bDestination
  self:_ApplyForwardRotation()
  self:_StartMoveTween()
end

function GoldenSpyPatrolItem:_ApplyForwardRotation()
  local tr = self._mapNode.trDrone
  if tr then
    if self.bDirection then
      tr.localEulerAngles = Vector3(0, 0, 0)
    else
      tr.localEulerAngles = Vector3(0, 180, 0)
    end
  end
end

function GoldenSpyPatrolItem:_KillMoveTween()
  if self._moveTweener ~= nil then
    self._moveTweener:Kill(false)
    self._moveTweener = nil
  end
  if self._mapNode.trDrone ~= nil then
    self._mapNode.trDrone:DOKill(false)
  end
end

function GoldenSpyPatrolItem:GetForwardAngle()
  if self.bDirection then
    return 0
  else
    return 180
  end
end

function GoldenSpyPatrolItem:_PointInSector(px, py, cx, cy, forwardAngle, visionAngle, radius)
  local dx, dy = px - cx, py - cy
  local dist2 = dx * dx + dy * dy
  if dist2 > radius * radius then
    return false
  end
  local angle = math.deg(math.atan(dy, dx))
  local lo = forwardAngle - visionAngle
  local hi = forwardAngle + visionAngle
  while angle < lo do
    angle = angle + 360
  end
  while angle > hi + 360 do
    angle = angle - 360
  end
  if lo <= angle and hi >= angle then
    return true
  end
  if angle >= lo - 360 and angle <= hi - 360 then
    return true
  end
  return false
end

function GoldenSpyPatrolItem:_HitAreaInSector(hitArea, vx, vy, forwardAngle, halfAngle, radius)
  if not (hitArea and vx) or not vy then
    return false
  end
  local cx, cy = vx, vy
  local ix, iy
  if hitArea.position then
    ix, iy = hitArea.position.x, hitArea.position.y
  else
    return false
  end
  local itemR = hitArea.radius or 0
  return self:_CircleSectorIntersect(ix, iy, itemR, cx, cy, forwardAngle, halfAngle, radius)
end

function GoldenSpyPatrolItem:_PointToSectorDist(px, py, cx, cy, forwardAngle, halfAngle, radius)
  local dx, dy = px - cx, py - cy
  local dist = math.sqrt(dx * dx + dy * dy)
  local angleDeg = math.deg(math.atan(dy, dx))
  local lo = forwardAngle - halfAngle
  local hi = forwardAngle + halfAngle
  while angleDeg < lo - 180 do
    angleDeg = angleDeg + 360
  end
  while angleDeg > hi + 180 do
    angleDeg = angleDeg - 360
  end
  if lo <= angleDeg and hi >= angleDeg and radius >= dist then
    return 0
  end
  local radLo = math.rad(lo)
  local radHi = math.rad(hi)
  local clampAngle = angleDeg
  if lo > clampAngle then
    clampAngle = lo
  end
  if hi < clampAngle then
    clampAngle = hi
  end
  local radClamp = math.rad(clampAngle)
  local ax = cx + radius * math.cos(radClamp)
  local ay = cy + radius * math.sin(radClamp)
  local dArc = math.sqrt((px - ax) ^ 2 + (py - ay) ^ 2)
  
  local function distToRay(angleRay)
    local rad = math.rad(angleRay)
    local rx, ry = math.cos(rad), math.sin(rad)
    local t = dx * rx + dy * ry
    if t <= 0 then
      return math.sqrt(dx * dx + dy * dy)
    end
    if t >= radius then
      local ex = cx + radius * rx
      local ey = cy + radius * ry
      return math.sqrt((px - ex) ^ 2 + (py - ey) ^ 2)
    end
    local nx = cx + t * rx
    local ny = cy + t * ry
    return math.sqrt((px - nx) ^ 2 + (py - ny) ^ 2)
  end
  
  local dRay1 = distToRay(lo)
  local dRay2 = distToRay(hi)
  return math.min(dArc, dRay1, dRay2)
end

function GoldenSpyPatrolItem:_CircleSectorIntersect(circleCx, circleCy, circleR, sectorCx, sectorCy, sectorForward, sectorHalfAngle, sectorRadius)
  local dist = self:_PointToSectorDist(circleCx, circleCy, sectorCx, sectorCy, sectorForward, sectorHalfAngle, sectorRadius)
  return circleR >= dist
end

function GoldenSpyPatrolItem:_CheckVision()
  local tr = self.gameObject:GetComponent("RectTransform")
  local vp = self._mapNode.VisionPoint.anchoredPosition + tr.anchoredPosition + self._mapNode.trDrone.anchoredPosition
  if vp == nil then
    return
  end
  local vx, vy = vp.x, vp.y
  local forwardAngle = self:GetForwardAngle()
  local halfAngle = self.nVisionAngle
  local radius = self.nVisionRadius
  local hitArea = {
    position = self.floorCtrl:GetHookEndPos(),
    radius = self.floorCtrl:GetHookRadius()
  }
  if hitArea and self:_HitAreaInSector(hitArea, vx, vy, forwardAngle, halfAngle, radius) and self.bTrigger then
    if self.floorCtrl:CheckCanDropItem() then
      self.floorCtrl:DropItem()
      self.floorCtrl:DoStartRetract()
    end
    WwiseAudioMgr:PostEvent("Mode_steal_error")
    self.floorCtrl:SubTime(self.itemCfg.Params[2])
    self._mapNode.img_normal:SetActive(false)
    self._mapNode.img_warning:SetActive(true)
    self.visionTimer = self:AddTimer(1, 0.5, function()
      self._mapNode.img_normal:SetActive(true)
      self._mapNode.img_warning:SetActive(false)
    end, true, true, true)
    self.bTrigger = false
  else
  end
end

function GoldenSpyPatrolItem:_StartVisionCheck()
  self:_StopVisionCheck()
  self._visionUpdateTimer = self:AddTimer(0, 0, "OnVisionUpdate", true, true, true)
end

function GoldenSpyPatrolItem:OnVisionUpdate()
  self:_CheckVision()
end

function GoldenSpyPatrolItem:_StopVisionCheck()
  if self._visionUpdateTimer ~= nil then
    self._visionUpdateTimer:Cancel()
    self._visionUpdateTimer = nil
  end
end

function GoldenSpyPatrolItem:OnEvent_GoldenSpyHookStartExtend()
  self.bTrigger = true
end

function GoldenSpyPatrolItem:OnEvent_GM_GoldenSpy_Show()
  local img = self._mapNode.HitArea:GetComponent("Image")
  if img then
    img.enabled = true
  end
end

return GoldenSpyPatrolItem
