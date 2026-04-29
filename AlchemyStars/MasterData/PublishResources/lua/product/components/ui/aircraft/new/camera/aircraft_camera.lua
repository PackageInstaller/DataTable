_class("AircraftCamera", Object)
AircraftCamera = AircraftCamera

function AircraftCamera:Constructor()
  self._lerpValue = Cfg.cfg_aircraft_camera.lerpParam.Value
  self._clickPetPosZ = Cfg.cfg_aircraft_camera.clickPetPosZ.Value
  self._backPosZ = Cfg.cfg_aircraft_camera.backPosZ.Value
  self._topDistance = Cfg.cfg_aircraft_camera.mainTopDistance.Value
  self._decorateTopDistance = Cfg.cfg_aircraft_camera.decorateTopDistance.Value
  self._nearDistance = Cfg.cfg_aircraft_camera.mainNearDistance.Value
  self._dragParamFar = Cfg.cfg_aircraft_camera.mainDragParamFar.Value
  self._dragParamNear = Cfg.cfg_aircraft_camera.mainDragParamNear.Value
  self._zoomParam = Cfg.cfg_aircraft_camera.mainZoomParam.Value
  self._riseUpDistance = Cfg.cfg_aircraft_camera.riseUpDistance.Value
  self._riseUpMaxY = Cfg.cfg_aircraft_camera.riseUpMaxY.Value
  self._minFov = Cfg.cfg_aircraft_camera.minFov.Value
  self._maxFov = Cfg.cfg_aircraft_camera.maxFov.Value
  self._joyStickParam = Cfg.cfg_aircraft_camera.joyStickDragParam.Value
  self._joyStickAngleVer = Cfg.cfg_aircraft_camera.joyStickAngleVertical.Value
  self._joyStickAngleHor = Cfg.cfg_aircraft_camera.joyStickAngleHorizontal.Value
  self._clickSmeltPosZ = Cfg.cfg_aircraft_camera.uiHidePosX.Value
  self._clickBookShelfPosZ = Cfg.cfg_aircraft_camera.clickBookShelfPosZ.Value
  self._clickDispatchTaskMapPosZ = Cfg.cfg_aircraft_camera.clickDispatchTaskMapPosZ.Value
  self._fovParam = Cfg.cfg_aircraft_camera.fovScaleParam.Value
  self._minFovDragParam = Cfg.cfg_aircraft_camera.minFovDragParam.Value
  self._defaultAspect = BattleConst.CameraDefaultAspect
end

function AircraftCamera:Init(camera, input, clickCallback)
  self._camera = camera
  self._hudCamera = self._camera.transform:GetChild(0).gameObject:GetComponent(typeof(UnityEngine.Camera))
  self._input = input
  self._clickCB = clickCallback
  self._fovT = 1
  self._cameraTarget = nil
  self._distance = nil
  self._joyX = 0
  self._joyY = 0
  self._currentPos = self._camera.transform.position
  self._currentRot = self._camera.transform.rotation
  self._active = true
  self._anim = nil
  self._fov = self._maxFov
  camera.fieldOfView = self._fov
  self._hudCamera.fieldOfView = self._fov
  self._aspect = camera.aspect
  if self._defaultAspect > self._aspect then
    local widthDistance = self._topDistance * self._defaultAspect
    self._topDistance = widthDistance / self._aspect
    self._decorateTopDistance = self._decorateTopDistance * self._defaultAspect / self._aspect
  end
  self._tangent = math.tan(math.rad(self._fov / 2))
  self._horAngle = math.deg(math.atan(math.tan(math.rad(self._fov / 2) * self._aspect)))
  self._field = Vector2(self._topDistance * self._aspect, self._topDistance)
  self._farDistance = self._topDistance / self._tangent
  self._decorateDistance = self._decorateTopDistance / self._tangent
  self._targetField = Vector2.zero
  local maxTargetY = self._topDistance - self._nearDistance * self._tangent
  self._targetMaxField = Vector2(maxTargetY * self._aspect, maxTargetY)
  self:RefreshTarget()
  self._focusing = false
end

function AircraftCamera:RefreshTarget()
  local pos = self._currentPos
  local p1 = Vector3(pos.x, pos.y, 0)
  local dir = Vector3.forward * self._currentRot
  local nor = Vector3(0, 0, -1)
  local n = (nor.x * p1.x - nor.x * pos.x + nor.y * p1.y - nor.y * pos.y + nor.z * p1.z - nor.z * pos.z) / (nor.x * dir.x + nor.y * dir.y + nor.z * dir.z)
  self._cameraTarget = pos + dir * n
end

function AircraftCamera:IsOutOfField(pos, dir)
  local rot = Quaternion.LookRotation(dir)
  local rightAxis = Vector3.right * rot
  local upAxis = Vector3.up * rot
  local left = self:GetRayPoint(pos, Quaternion.AngleAxis(-self._horAngle, upAxis) * dir)
  if not self:IsInEdge(left) then
    return true
  end
  local right = self:GetRayPoint(pos, Quaternion.AngleAxis(self._horAngle, upAxis) * dir)
  if not self:IsInEdge(right) then
    return true
  end
  local top = self:GetRayPoint(pos, Quaternion.AngleAxis(-self._fov / 2, rightAxis) * dir)
  if not self:IsInEdge(top) then
    return true
  end
  local bottom = self:GetRayPoint(pos, Quaternion.AngleAxis(self._fov / 2, rightAxis) * dir)
  if not self:IsInEdge(bottom) then
    return true
  end
  return false
end

function AircraftCamera:IsInEdge(p)
  if p.x > -self._field.x and p.x < self._field.x and p.y > -self._field.y and p.y < self._field.y then
    return true
  end
  return false
end

function AircraftCamera:GetRayPoint(pos, dir)
  local p1 = Vector3(pos.x, pos.y, 0)
  local nor = Vector3.back
  local n = (nor.x * p1.x - nor.x * pos.x + nor.y * p1.y - nor.y * pos.y + nor.z * p1.z - nor.z * pos.z) / (nor.x * dir.x + nor.y * dir.y + nor.z * dir.z)
  local p = pos + dir * n
  return p
end

function AircraftCamera:SetStick(stick, onStart, focus, onEnd)
  self._stick = stick
  
  function stick.onBegin()
    self:RefreshTarget()
    self._joyX = self._camera.transform.eulerAngles.y
    self._joyY = -self._camera.transform.eulerAngles.x
    self._distance = Vector3.Distance(self._currentPos, self._cameraTarget)
    self._stickOffset = true
  end
  
  function stick.onEnd()
    return not self:IsCamareAtFarPoint()
  end
  
  function stick.onReset()
    self._stickOffset = false
    self._currentRot = Quaternion.identity
    local distance = Vector3.Distance(self._currentPos, self._cameraTarget)
    self._currentPos = self:_CalPos(Vector3(self._cameraTarget.x, self._cameraTarget.y, -distance), self._currentRot)
  end
  
  self._onFocusStart = onStart
  self._onFocusEnd = onEnd
  self._onFocuse = focus
end

function AircraftCamera:Dispose()
end

function AircraftCamera:SetActive(active)
  self._active = active
end

function AircraftCamera:Update(deltaTimeMS)
  if not self._active then
    return
  end
  if self._anim then
    self._anim:Update(deltaTimeMS)
    if self._anim:IsComplete() then
      self._anim = nil
      self:RefreshTarget()
    end
  else
    self._stick:Update(deltaTimeMS)
    local down, downPos = self._input:GetMouseDown()
    if down then
      local layers = 0
      if self._currentPos.z > self._clickSmeltPosZ then
        layers = layers | 1 << AircraftLayer.Smelt
      end
      if self._currentPos.z > self._clickDispatchTaskMapPosZ then
        layers = layers | 1 << AircraftLayer.DispatchTaskMap
      end
      if 0 < layers then
        local downRay = self._camera:ScreenPointToRay(downPos)
        local castRes, hitInfo = UnityEngine.Physics.Raycast(downRay, nil, 1000, layers)
        if castRes then
          local view = hitInfo.transform.gameObject:GetComponent(typeof(UIView))
          if view then
            local outline = view:GetUIComponent("Animation", "outline")
            if outline then
              outline:Play("eff_fengchuan_outline_show")
              self._outlineAnim = outline
            end
          end
        end
      end
    end
    local up, upPos = self._input:GetMouseUp()
    if up and self._outlineAnim then
      self._outlineAnim:Play("eff_fengchuan_outline_fade")
      self._outlineAnim = nil
    end
    local clicked, clickPos = self._input:GetClick()
    local scaling, scaleLength, scaleCenterPos = self._input:GetScale()
    local dragging, dragStartPos, dragEndPos = self._input:GetDrag()
    local sticking, offset = self._stick:GetDrag()
    if clicked then
      local clickRay = self._camera:ScreenPointToRay(clickPos)
      local layers = AircraftLayer.Default
      if self._currentPos.z > self._clickPetPosZ then
        layers = layers | 1 << AircraftLayer.Pet
      end
      if self._currentPos.z > self._clickSmeltPosZ then
        layers = layers | 1 << AircraftLayer.Smelt
        layers = layers | 1 << AircraftLayer.Tactic
      end
      if self._currentPos.z > self._clickBookShelfPosZ then
        layers = layers | 1 << AircraftLayer.BookShelf
      end
      if self._currentPos.z > self._clickDispatchTaskMapPosZ then
        layers = layers | 1 << AircraftLayer.DispatchTaskMap
        layers = layers | 1 << AircraftLayer.Award
      end
      local results = UnityEngine.Physics.RaycastAll(clickRay, 1000, layers)
      if results and 0 < results.Length then
        local t = {}
        for i = 1, results.Length do
          t[i] = results[i - 1]
        end
        table.sort(t, function(a, b)
          return a.distance < b.distance
        end)
        self._clickCB(t)
        return
      end
    end
    if scaling then
      if self._focusing then
        local delta = scaleLength * self._fovParam
        self:SetFovT(self._fovT - delta)
        self._onFocuse(self._fovT)
        if delta < 0 and 1 <= self._fovT then
          self._focusing = false
          self._onFocusEnd()
        end
      else
        local forward = Vector3.forward * self._currentRot
        local oz = self._currentPos.z
        local delta = forward * (scaleLength * self._zoomParam)
        local target = self._currentPos + delta
        if target.z > -self._nearDistance then
          target.z = -self._nearDistance
          self._currentPos = target
        elseif self:IsOutOfField(target, forward) then
          if 0 > delta.z then
            if target.z <= -self._farDistance then
              self._currentPos = Vector3(0, 0, -self._farDistance)
              self._currentRot = Quaternion.identity
            else
              target.z = Mathf.Clamp(target.z, -self._farDistance, -self._nearDistance)
              local deltaZ = math.abs(target.z - oz)
              local z = math.abs(oz)
              local t = deltaZ / (self._farDistance - z)
              self._currentRot = Quaternion.Lerp(self._currentRot, Quaternion.identity, t)
              self._currentPos = self:_CalPos(target, self._currentRot)
            end
          end
          self:RefreshTarget()
        else
          self._currentPos = target
        end
        if self._currentPos.z > -self._nearDistance - 0.1 then
          self._focusing = true
          self._onFocusStart()
        end
      end
    elseif dragging then
      local forward = Vector3.forward * self._currentRot
      local _dragParam = self:_CalDragParam(self._currentPos.z)
      local delta = (dragStartPos - dragEndPos) * _dragParam
      local target = self._currentPos + delta
      if self:IsOutOfField(target, forward) then
      else
        self._currentPos = target
        self:RefreshTarget()
      end
    elseif sticking and not self:IsCamareAtFarPoint() then
      local euler = self._currentRot.eulerAngles:Clone()
      local x = self._joyX + offset.x * self._joyStickParam
      local y = self._joyY + offset.y * self._joyStickParam
      if x < -180 then
        x = x + 360
      elseif 180 < x then
        x = x - 360
      end
      if y < -180 then
        y = y + 360
      elseif 180 < y then
        y = y - 360
      end
      x = Mathf.Clamp(x, -self._joyStickAngleHor, self._joyStickAngleHor)
      y = Mathf.Clamp(y, -self._joyStickAngleVer, self._joyStickAngleVer)
      local rot = Quaternion.Euler(-y, x, 0)
      local target = rot * Vector3(0, 0, -self._distance) + self._cameraTarget
      local forward = Vector3.forward * rot
      if self:IsOutOfField(target, forward) then
      else
        self._currentPos = target
        self._currentRot = rot
        self._joyX = x
        self._joyY = y
      end
    end
  end
  local cur = self._camera.transform.position
  cur = Vector3.Lerp(cur, self._currentPos, self._lerpValue)
  self._camera.transform.position = cur
  if cur.z > -self._nearDistance - 0.1 and not self._showFocus then
    self._onFocusStart()
    self._showFocus = true
  elseif cur.z < -self._nearDistance - 0.1 and self._showFocus then
    self._onFocusEnd()
    self._showFocus = false
  end
  local curRot = self._camera.transform.rotation
  curRot = Quaternion.Lerp(curRot, self._currentRot, self._lerpValue)
  self._camera.transform.rotation = curRot
end

function AircraftCamera:_CalRiseUp(z)
  local delta = z + self._riseUpDistance
  local riseUp = 0
  if delta < 0 then
  else
    local dis = -(z + self._nearDistance)
    riseUp = (1 - dis / (self._riseUpDistance - self._nearDistance)) * self._riseUpMaxY
  end
  return riseUp
end

function AircraftCamera:_CalDragParam(z)
  if self._fovT < 1 then
    return self._fovT * (self._dragParamNear - self._minFovDragParam) + self._minFovDragParam
  else
    local rate = (self._dragParamFar - self._dragParamNear) / (self._farDistance - self._nearDistance)
    return (math.abs(z) - self._nearDistance) * rate + self._dragParamNear
  end
end

function AircraftCamera:_CalPos(pos, rot)
  local dir = Vector3.forward * rot
  local right = Vector3.right * rot
  local up = Vector3.up * rot
  local left = self:GetRayPoint(pos, Quaternion.AngleAxis(-self._horAngle, up) * dir)
  local top = self:GetRayPoint(pos, Quaternion.AngleAxis(-self._fov / 2, right) * dir)
  local x, y = 0
  if left.x < -self._field.x then
    x = -left.x - self._field.x
  else
    local right = self:GetRayPoint(pos, Quaternion.AngleAxis(self._horAngle, up) * dir)
    if right.x > self._field.x then
      x = self._field.x - right.x
    else
    end
  end
  if top.y > self._field.y then
    y = self._field.y - top.y
  else
    local bottom = self:GetRayPoint(pos, Quaternion.AngleAxis(self._fov / 2, right) * dir)
    if bottom.y < -self._field.y then
      y = -bottom.y - self._field.y
    else
    end
  end
  return Vector3(x, y, 0) + pos
end

function AircraftCamera:IsCamareAtFarPoint()
  return self._currentPos.z <= -self._farDistance
end

function AircraftCamera:IsFocusing()
  return self._focusing
end

function AircraftCamera:OnAnimate(target)
  local riseUp = self:_CalRiseUp(target.z)
  local pos = target:Clone()
  pos.y = target.y + riseUp
  local rot = Quaternion.LookRotation(Vector3(0, -riseUp, -pos.z))
  pos = self:_CalPos(pos, rot)
  return pos, rot
end

function AircraftCamera:MoveAnim(target, callback, time)
  if self._anim then
    Log.exception("重复的相机动画:", debug.traceback())
  else
    AirLog("相机动画", debug.traceback())
  end
  local originPos = self._currentPos:Clone()
  local originRot = self._currentRot:Clone()
  local pos, rot = self:OnAnimate(target)
  if time then
    self._anim = AircraftCameraAnim:New(self, originPos, originRot, pos, rot, time, callback)
  else
    self._anim = AircraftCameraAnim:New(self, originPos, originRot, pos, rot, 700, callback)
  end
end

function AircraftCamera:SetCameraToNavMenuPos(pos)
  self._camera.transform.position = pos
  self._camera.transform.rotation = Quaternion.identity
end

function AircraftCamera:MoveBack(z)
  AirLog("相机动画，返回")
  local originPos = self._currentPos:Clone()
  local originRot = self._currentRot:Clone()
  self._currentRot = Quaternion.identity
  local target = Vector3(0, 0, z)
  local pos, rot = self:OnAnimate(target)
  self._anim = AircraftCameraAnim:New(self, originPos, originRot, pos, rot, 700)
end

function AircraftCamera:MoveToFar(callback)
  AirLog("相机动画，移向最远处")
  local originPos = self._currentPos:Clone()
  local originRot = self._currentRot:Clone()
  local pos = Vector3(0, 0, -self._farDistance)
  local rot = Quaternion.identity
  self._currentPos = pos
  self._currentRot = rot
  self._anim = AircraftCameraAnim:New(self, originPos, originRot, pos, rot, 700, callback)
end

function AircraftCamera:MoveToPosNotTime(tpos, callback)
  AirLog("相机动画，移向某处,notTime")
  local originPos = self._currentPos:Clone()
  local originRot = self._currentRot:Clone()
  local pos = tpos
  local rot = Quaternion.identity
  self._currentPos = pos
  self._currentRot = rot
  self._anim = AircraftCameraAnimNotTime:New(self, originPos, originRot, pos, rot, 700, callback)
end

function AircraftCamera:CloseFocus(callback)
  AirLog("相机动画，关闭聚焦")
  if self._onFocusEnd then
    self._onFocusEnd()
  end
  self._focusing = false
  self._anim = AircraftCameraFovAnim:New(self, 1, callback)
end

function AircraftCamera:SetFovT(t)
  self._fovT = Mathf.Clamp01(t)
  local fov = Mathf.Lerp(self._minFov, self._maxFov, self._fovT)
  self._fov = fov
  self._camera.fieldOfView = fov
  self._hudCamera.fieldOfView = fov
end

function AircraftCamera:SetHudCameraActive(active)
  self._hudCamera.gameObject:SetActive(active)
end

function AircraftCamera:SetPos(pos)
  self._currentPos = pos
end

function AircraftCamera:SetRot(rot)
  self._currentRot = rot
end

function AircraftCamera:Camera()
  return self._camera
end

function AircraftCamera:CameraFovPercent()
  return self._fovT
end

function AircraftCamera:FarPoint()
  return Vector3(0, 0, -self._farDistance)
end

function AircraftCamera:DecorateViewPoint()
  return Vector3(0, 0, -self._decorateDistance)
end

function AircraftCamera:Reset()
  self._currentPos = self._camera.transform.position
  self._currentRot = self._camera.transform.rotation
end

function AircraftCamera:ResetFov()
  self:SetFovT(1)
end

function AircraftCamera:FocusPoint()
  return self._cameraTarget
end

_class("AircraftCameraAnim", Object)
AircraftCameraAnim = AircraftCameraAnim

function AircraftCameraAnim:Constructor(camera, originPos, originRot, targetPos, targetRot, duration, onFinish)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftUILock, true, "AircraftCameraAnim")
  self._cameraManager = camera
  self._transform = self._cameraManager:Camera().transform
  self._fromPos = originPos
  self._fromRot = originRot
  self._targetPos = targetPos
  self._targetRot = targetRot
  self._duration = duration
  self._onfinish = onFinish
  self._timer = 0
  self._completed = false
  self._pos = nil
  self._rot = nil
end

function AircraftCameraAnim:Update(deltaTimeMS)
  if self._completed then
    return
  end
  if self._timer < self._duration then
    local t = self._timer / self._duration
    self._timer = self._timer + deltaTimeMS
    self._cameraManager:SetPos(Vector3.Lerp(self._fromPos, self._targetPos, t))
    self._cameraManager:SetRot(Quaternion.Lerp(self._fromRot, self._targetRot, t))
  else
    self._cameraManager:SetPos(self._targetPos)
    self._cameraManager:SetRot(self._targetRot)
    self._completed = true
    GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftUILock, false, "AircraftCameraAnim")
    if self._onfinish then
      self._onfinish()
    end
  end
end

function AircraftCameraAnim:IsComplete()
  return self._completed
end

_class("AircraftCameraFovAnim", Object)
AircraftCameraFovAnim = AircraftCameraFovAnim

function AircraftCameraFovAnim:Constructor(camera, speed, onFinish)
  self._cameraManager = camera
  self._targetFov = 1
  self._originFov = self._cameraManager:CameraFovPercent()
  self._speed = speed / 1000
  self._onFinish = onFinish
  self._completed = false
  self._current = self._originFov
  GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftUILock, true, "AircraftCameraFovAnim")
end

function AircraftCameraFovAnim:Update(deltaTimeMS)
  if self._completed then
    return
  end
  self._current = self._current + deltaTimeMS * self._speed
  if self._current < self._targetFov then
    self._cameraManager:SetFovT(self._current)
  else
    self._cameraManager:SetFovT(self._targetFov)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftUILock, false, "AircraftCameraFovAnim")
    self._completed = true
    if self._onFinish then
      self._onFinish()
    end
  end
end

function AircraftCameraFovAnim:IsComplete()
  return self._completed
end
