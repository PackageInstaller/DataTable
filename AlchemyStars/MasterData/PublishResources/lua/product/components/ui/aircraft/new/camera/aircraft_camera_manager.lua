_class("AircraftCameraManager", Object)
AircraftCameraManager = AircraftCameraManager

function AircraftCameraManager:Constructor(main)
  self._main = main
  self._inputManager = self._main:Input()
  self._enable = false
  self._camera = nil
  self._majorCamera = AircraftCamera:New()
  self._showUI = true
  self._showNavMenu = true
end

function AircraftCameraManager:Init()
  self._camera = UnityEngine.GameObject.Find("Main Camera"):GetComponent("Camera")
  if not self._camera then
    Log.fatal("[aircraft] main camera not found")
    return false
  end
  self._cameraT = self._camera.transform
  self._majorCamera:Init(self._camera, self._inputManager, function(results)
    self:OnClickRoom(results)
  end)
  self._enable = true
  self._hideUIPosZ = Cfg.cfg_aircraft_camera.uiHidePosX.Value
  self._focusZ_centerroom = Cfg.cfg_aircraft_camera.focus_centerroom_dis.Value
  self._focusZ_restroom = Cfg.cfg_aircraft_camera.focus_restroom_dis.Value
  self._focusZ_workroom = Cfg.cfg_aircraft_camera.focus_workroom_dis.Value
  self._levelupZ_centerroom = Cfg.cfg_aircraft_camera.levelup_centerroom_dis.Value
  self._levelupZ_restroom = Cfg.cfg_aircraft_camera.levelup_restroom_dis.Value
  self._levelupZ_workroom = Cfg.cfg_aircraft_camera.levelup_workroom_dis.Value
  self._focusPetPosZ = Cfg.cfg_aircraft_camera.focusPetPosZ.Value
  self._hideNavMenuPosZ = Cfg.cfg_aircraft_camera.hideUIAirNavMenuPosZ.Value
  self._navMenuCamPosX = -0.03
  self._navMenuCamPosY = 0.291
  self._navMenuCamPosZ = -189
  self._petFixedY = Cfg.cfg_aircraft_camera.petFixedOffsetY.Value
  self._petDistanceRate = Cfg.cfg_aircraft_camera.petDistanceParam.Value
  self._backPosZ = Cfg.cfg_aircraft_camera.backPosZ.Value
  self._ScaleCancelPos = Cfg.cfg_aircraft_const.ScaleCancelPos.IntValue
  self._showSentence = true
  self._freeAnim = nil
  AirLog("AircraftCameraManager Init Done")
end

function AircraftCameraManager:OnClickRoom(results)
  self._main:OnClickRoom(results)
end

function AircraftCameraManager:Dispose()
  self._enable = false
  self._majorCamera:Dispose()
end

function AircraftCameraManager:Update(deltaTimeMS)
  if not self._enable then
    return
  end
  if self._freeAnim then
    self._freeAnim:Update(deltaTimeMS)
  else
    self._majorCamera:Update(deltaTimeMS)
  end
  local p = self._cameraT.position
  if p.z < self._ScaleCancelPos and self._showSentence then
    self._showSentence = false
    self._main:StopInteraction()
  elseif p.z > self._ScaleCancelPos and not self._showSentence then
    self._showSentence = true
  end
  if p.z > self._hideUIPosZ and self._showUI then
    self._showUI = false
    self._main:Set3DUIActive(false)
    self._main:SetClickTexActive(false)
    self._main:SetCamNearbyState(true)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.Active)
  elseif p.z < self._hideUIPosZ and not self._showUI then
    self._showUI = true
    self._main:Set3DUIActive(true)
    self._main:SetClickTexActive(true)
    self._main:SetCamNearbyState(false)
  end
  if p.z > self._hideNavMenuPosZ and self._showNavMenu then
    self._showNavMenu = false
    GameGlobal.EventDispatcher():Dispatch(GameEventType.UIAirNavMenuActive, false)
  elseif p.z < self._hideNavMenuPosZ and not self._showNavMenu then
    self._showNavMenu = true
    GameGlobal.EventDispatcher():Dispatch(GameEventType.UIAirNavMenuActive, true)
  end
end

function AircraftCameraManager:Check3DUI()
  local p = self._cameraT.position
  if p.z > self._hideUIPosZ then
    self._main:Set3DUIActive(false)
    self._showUI = false
  elseif p.z < self._hideUIPosZ then
    self._showUI = true
    self._main:Set3DUIActive(true)
  end
  if p.z > self._hideNavMenuPosZ then
    self._showNavMenu = false
    GameGlobal.EventDispatcher():Dispatch(GameEventType.UIAirNavMenuActive, false)
  elseif p.z < self._hideNavMenuPosZ then
    self._showNavMenu = true
    GameGlobal.EventDispatcher():Dispatch(GameEventType.UIAirNavMenuActive, true)
  end
end

function AircraftCameraManager:GetCamera()
  return self._camera
end

function AircraftCameraManager:SetActive(active)
  self._enable = active
end

function AircraftCameraManager:FocusRoom(room, callback, time)
  local pos = room:CenterPosition()
  local z
  if room:Area() == nil then
    z = self._focusZ_workroom
  elseif room:Area() == AirRestAreaType.CenterRoom then
    z = self._focusZ_centerroom
  else
    z = self._focusZ_restroom
  end
  self._majorCamera:MoveAnim(Vector3(pos.x, pos.y - 1.0, z), callback, time)
end

function AircraftCameraManager:AnimFocusRoom(room, callback, time)
  local pos = room:CenterPosition()
  local z
  if room:Area() == nil then
    z = self._levelupZ_workroom
  elseif room:Area() == AirRestAreaType.CenterRoom then
    z = self._levelupZ_centerroom
  else
    z = self._levelupZ_restroom
  end
  self._majorCamera:MoveAnim(Vector3(pos.x, pos.y - 1.0, z), callback, time)
end

function AircraftCameraManager:FocusPet(petPos, callback, time)
  local dis = petPos.z - self._focusPetPosZ
  local offsetY = dis * self._petDistanceRate + self._petFixedY
  self._majorCamera:MoveAnim(Vector3(petPos.x, petPos.y + offsetY, self._focusPetPosZ), callback, time)
end

function AircraftCameraManager:FocusPos(pos, callback)
  self._majorCamera:MoveAnim(Vector3(pos.x, pos.y, self._focusPetPosZ), callback)
end

function AircraftCameraManager:MoveToNavMenuPos(callback, movetime)
  self._majorCamera:MoveAnim(Vector3(self._navMenuCamPosX, self._navMenuCamPosY, self._navMenuCamPosZ), callback, movetime)
end

function AircraftCameraManager:SetCameraToNavMenuPos()
  self._majorCamera:SetCameraToNavMenuPos(Vector3(self._navMenuCamPosX, self._navMenuCamPosY, self._navMenuCamPosZ))
end

function AircraftCameraManager:MoveToFarest(callback)
  self._majorCamera:MoveToFar(callback)
end

function AircraftCameraManager:MoveToPosNotTime(tpos, cb)
  self._majorCamera:MoveToPosNotTime(tpos, cb)
end

function AircraftCameraManager:MoveBack()
  self._majorCamera:MoveBack(self._backPosZ)
end

function AircraftCameraManager:TryBack()
  if self._majorCamera:IsFocusing() then
    self._majorCamera:CloseFocus()
    return false
  elseif self._cameraT.position.z > self._backPosZ then
    self:MoveBack()
    return false
  else
    return true
  end
end

function AircraftCameraManager:GetPosXZ()
  local _x = self._camera.transform.position.x
  local _z = self._camera.transform.position.z
  return _x, _z
end

function AircraftCameraManager:GetCurrentCameraPos()
  return self._camera.transform.position
end

function AircraftCameraManager:GetNavMenuTargetCameraPos()
  return Vector3(self._navMenuCamPosX, self._navMenuCamPosY, self._navMenuCamPosZ)
end

function AircraftCameraManager:GetFarPoint()
  return self._majorCamera:FarPoint()
end

function AircraftCameraManager:GetDecorateViewPoint()
  return self._majorCamera:DecorateViewPoint()
end

function AircraftCameraManager:Reset()
  self._majorCamera:Reset()
end

function AircraftCameraManager:ResetFov()
  self._majorCamera:ResetFov()
end

function AircraftCameraManager:LookRandomStoryCameraAnimStart(look, duration)
  if look then
    self._beforeAnimPos = self._cameraT.position
    local targetLookStoryPos1 = Vector3(self._beforeAnimPos.x, self._beforeAnimPos.y - 0.85, self._beforeAnimPos.z + 5)
    local targetLookStoryPos2 = Vector3(self._beforeAnimPos.x, self._beforeAnimPos.y - 0.9, self._beforeAnimPos.z + 6)
    local timeLength1 = duration * 0.7
    local timeLength2 = duration * 0.2
    local targetPos = {}
    table.insert(targetPos, targetLookStoryPos1)
    table.insert(targetPos, targetLookStoryPos2)
    local timeLength = {}
    table.insert(timeLength, timeLength1)
    table.insert(timeLength, timeLength2)
    self._freeAnim = AircraftLerpMultiAnim:New(self._cameraT, self._beforeAnimPos, targetPos, timeLength, function()
      self:SetActive(false)
    end)
  else
    if self._beforeAnimPos then
      self._cameraT.position = self._beforeAnimPos
    end
    self._beforeAnimPos = nil
    self._freeAnim = nil
    self:SetActive(true)
  end
end

function AircraftCameraManager:CheckAirNavMenuCanActive()
  return self._showNavMenu
end

function AircraftCameraManager:SetJoyStick(stick, onStart, focus, onEnd)
  self._majorCamera:SetStick(stick, onStart, focus, onEnd)
end

function AircraftCameraManager:FocusPoint()
  return self._majorCamera:FocusPoint()
end

function AircraftCameraManager:SetHudCameraActive(active)
  self._majorCamera:SetHudCameraActive(active)
end

_class("AircraftFader", Object)
AircraftFader = AircraftFader

function AircraftFader:Constructor(cur, target, duration)
  self._duaration = duration * 1000
  self._timer = 0
  self._from = cur
  self._to = target
  self.Alpha = self._from
end

function AircraftFader:Update(deltaTimeMS)
  self._timer = self._timer + deltaTimeMS
  local p = math.min(self._timer / self._duaration, 1)
  if self._from < self._to then
    self.Alpha = self._from + (self._to - self._from) * p
  elseif self._from > self._to then
    self.Alpha = self._from - (self._from - self._to) * p
  end
end

function AircraftFader:Complete()
  return self._timer > self._duaration
end

_class("AircraftLerpAnim", Object)
AircraftLerpAnim = AircraftLerpAnim

function AircraftLerpAnim:Constructor(origin, target, duration, callback)
  self._origin = origin
  self._target = target
  self._duration = duration
  self._callback = callback
  self._timer = 0
end

function AircraftLerpAnim:CallBack()
  if self._callback then
    self._callback()
  end
end

function AircraftLerpAnim:Update(deltaTimeMS)
  if self._timer < self._duration then
    self._timer = self._timer + deltaTimeMS
    local t = self._timer / self._duration
    return Vector3.Lerp(self._origin, self._target, t)
  else
    return self._target
  end
end

function AircraftLerpAnim:IsComplete()
  return self._timer > self._duration
end

_class("AircraftLerpMultiAnim", Object)
AircraftLerpMultiAnim = AircraftLerpMultiAnim

function AircraftLerpMultiAnim:Constructor(transform, origin, targetTab, timeLengthTab, callback)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftUILock, true, "AircraftLerpMultiAnim")
  self._transform = transform
  self._origin = origin
  self._targetTab = targetTab
  self._timeLengthTab = timeLengthTab
  self._allTimeLength = 0
  for i = 1, #self._timeLengthTab do
    self._allTimeLength = self._allTimeLength + self._timeLengthTab[i]
  end
  self._timer = 0
  self._targetIndex = 1
  self._complete = false
  self._finishCB = callback
end

function AircraftLerpMultiAnim:Update(deltaTimeMS)
  if self._complete then
    return
  end
  if self._timer < self._timeLengthTab[self._targetIndex] then
    local t = self._timer / self._timeLengthTab[self._targetIndex]
    self._timer = self._timer + deltaTimeMS
    self._transform.position = Vector3.Lerp(self._origin, self._targetTab[self._targetIndex], t)
  else
    local returnPos = self._targetTab[self._targetIndex]
    if self._targetIndex < #self._timeLengthTab then
      self._origin = self._targetTab[self._targetIndex]
      self._targetIndex = self._targetIndex + 1
      self._timer = 0
      self._transform.position = returnPos
    else
      self._complete = true
      self._transform.position = returnPos
      if self._finishCB then
        self._finishCB()
      end
      GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftUILock, false, "AircraftLerpMultiAnim")
    end
  end
end

function AircraftLerpMultiAnim:IsComplete()
  return self._complete
end

_class("AircraftRotLerpAnim", Object)
AircraftRotLerpAnim = AircraftRotLerpAnim

function AircraftRotLerpAnim:Constructor(origin, target, duration)
  self._origin = origin
  self._target = target
  self._duration = duration
  self._timer = 0
end

function AircraftRotLerpAnim:CallBack()
  if self._callback then
    self._callback()
  end
end

function AircraftRotLerpAnim:Update(deltaTimeMS)
  if self._timer < self._duration then
    local t = self._timer / self._duration
    self._timer = self._timer + deltaTimeMS
    return Quaternion.Lerp(self._origin, self._target, t)
  else
    return self._target
  end
end

function AircraftRotLerpAnim:IsComplete()
  return self._timer > self._duration
end
