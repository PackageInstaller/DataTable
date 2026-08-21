_class("AircraftDecorateCamera", Object)
AircraftDecorateCamera = AircraftDecorateCamera

function AircraftDecorateCamera:Constructor(far)
  self._farPoint = far
  self._lerpValue = Cfg.cfg_aircraft_camera.lerpParam.Value
end

function AircraftDecorateCamera:Init(camera, input)
  self._camera = camera
  self._transform = camera.transform
  self._input = input
  self._controller = AircraftCameraSphere:New(input, self._farPoint)
  self._currentPos = self._camera.transform.position
  self._currentRot = self._camera.transform.rotation
  self._worldPos = self._currentPos
  self._worldRot = self._currentRot
  self._active = true
  self._anim = nil
end

function AircraftDecorateCamera:Dispose()
  self._controller:Dispose()
end

function AircraftDecorateCamera:SetActive(active)
  self._active = active
end

function AircraftDecorateCamera:Update(deltaTimeMS)
  if not self._active then
    return
  end
  if self._anim then
    self._anim:Update(deltaTimeMS)
    self._currentPos = self._anim:Pos()
    self._currentRot = self._anim:Rot()
    if self._anim:IsComplete() then
      self._anim = nil
    end
  else
    self._currentPos = self._controller:Pos()
    self._currentRot = self._controller:Rot()
  end
  self._worldPos = Vector3.Lerp(self._worldPos, self._currentPos, self._lerpValue)
  self._transform.position = self._worldPos
  self._worldRot = Quaternion.Lerp(self._worldRot, self._currentRot, self._lerpValue)
  self._transform.rotation = self._worldRot
end

function AircraftDecorateCamera:OnScale()
  local scaling, length, centerPos = self._input:GetScale()
  if scaling then
    self._controller:OnScale(length)
  end
end

function AircraftDecorateCamera:OnDrag(delta)
  self._controller:OnDrag(-delta)
end

function AircraftDecorateCamera:MoveAnim(targetPos, callback)
  if self._anim then
    Log.exception("重复的装修相机动画:", debug.traceback())
  end
  AirLog("装修相机动画，位移")
  local originPos = self._currentPos:Clone()
  local originRot = self._currentRot:Clone()
  self._anim = AircraftDecorateCameraAnim:New(originPos, originRot, targetPos, nil, 700, callback)
  self._cameraCfg = nil
end

function AircraftDecorateCamera:SwitchCfg(cfgID, locateType, onFinish)
  if self._cameraCfg == cfgID and self._locateType == locateType then
    return
  end
  local changeTarget = false
  local useFloorTarget
  if self._cameraCfg == cfgID then
    if locateType == nil and self._locateType == LocationType.Floor then
      changeTarget = true
    elseif locateType == LocationType.Floor and self._locateType == nil then
      useFloorTarget = true
      changeTarget = true
    end
  end
  self._cameraCfg = cfgID
  self._locateType = locateType
  local cfg = Cfg.cfg_aircraft_decorate_camera[cfgID]
  if cfg == nil then
    Log.exception("找不到装修相机配置：", cfgID)
  end
  if changeTarget then
    self._controller:ChangeTarget(cfg, useFloorTarget)
  else
    self._controller:ChangeView(cfg)
  end
  local targetPos = self._controller:Pos()
  local targetRot = self._controller:Rot()
  if self._anim then
    Log.exception("重复的装修相机动画:", debug.traceback())
  end
  AirLog("装修相机动画，切换配置")
  self._anim = AircraftDecorateCameraAnim:New(self._currentPos, self._currentRot, targetPos, targetRot, 700, onFinish)
end

function AircraftDecorateCamera:MoveToFar(callback)
  AirLog("装修相机动画，移向最远处")
  local originPos = self._currentPos:Clone()
  local originRot = self._currentRot:Clone()
  local targetPos = self._farPoint
  local targetRot = Quaternion.identity
  if self._anim then
    Log.exception("重复的装修相机动画:", debug.traceback())
  end
  self._controller:Reset()
  self._anim = AircraftDecorateCameraAnim:New(originPos, originRot, targetPos, targetRot, 700, callback)
  self._cameraCfg = nil
end

function AircraftDecorateCamera:Camera()
  return self._camera
end

function AircraftDecorateCamera:CameraPosition()
  return self._transform.position
end

function AircraftDecorateCamera:RaycastAll(screenPos, layer)
  local clickRay = self._camera:ScreenPointToRay(screenPos)
  local results = UnityEngine.Physics.RaycastAll(clickRay, 1000, layer)
  if results and results.Length > 0 then
    local t = {}
    for i = 1, results.Length do
      t[i] = results[i - 1]
    end
    table.sort(t, function(a, b)
      return a.distance < b.distance
    end)
    return t
  end
end

function AircraftDecorateCamera:Raycast(screenPos, layer)
  local clickRay = self._camera:ScreenPointToRay(screenPos)
  local castRes, hitInfo = UnityEngine.Physics.Raycast(clickRay, nil, 1000, layer)
  if castRes then
    return hitInfo
  end
end

function AircraftDecorateCamera:Reset()
  self._currentPos = self._camera.transform.position
  self._currentRot = self._camera.transform.rotation
  self._worldPos = self._currentPos
  self._worldRot = self._currentRot
  self._cameraCfg = nil
end

_class("AircraftDecorateCameraAnim", Object)
AircraftDecorateCameraAnim = AircraftDecorateCameraAnim

function AircraftDecorateCameraAnim:Constructor(originPos, originRot, targetPos, targetRot, duration, onFinish)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftUILock, true, "AircraftDecorateCameraAnim")
  self._fromPos = originPos
  self._fromRot = originRot
  self._targetPos = targetPos
  if targetRot then
    self._targetRot = targetRot
  end
  self._duration = duration
  self._onfinish = onFinish
  self._timer = 0
  self._completed = false
  self._pos = originPos
  self._rot = originRot
end

function AircraftDecorateCameraAnim:Update(deltaTimeMS)
  if self._completed then
    return
  end
  if self._timer < self._duration then
    local t = self._timer / self._duration
    self._timer = self._timer + deltaTimeMS
    self._pos = Vector3.Lerp(self._fromPos, self._targetPos, t)
    if self._targetRot then
      self._rot = Quaternion.Lerp(self._fromRot, self._targetRot, t)
    end
  else
    self._pos = self._targetPos
    self._rot = self._targetRot
    self._completed = true
    GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftUILock, false, "AircraftDecorateCameraAnim")
    if self._onfinish then
      self._onfinish()
    end
  end
end

function AircraftDecorateCameraAnim:Pos()
  return self._pos
end

function AircraftDecorateCameraAnim:Rot()
  return self._rot
end

function AircraftDecorateCameraAnim:IsComplete()
  return self._completed
end
