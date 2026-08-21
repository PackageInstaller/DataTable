_class("AircraftInteractiveCameraController", Object)
AircraftInteractiveCameraController = AircraftInteractiveCameraController

function AircraftInteractiveCameraController:Constructor()
  self._mainCamera = nil
  self._targetPet = nil
  self._initCamRot = nil
  self._initCamPos = nil
  self._initCamOffsetY = nil
  self._initCamOffsetZ = nil
end

function AircraftInteractiveCameraController:Init(camera, aircraft3DManager)
  self._mainCamera = camera
  self._aircraft3DManager = aircraft3DManager
  self._cameraMng = self._aircraft3DManager:CameraManager()
end

function AircraftInteractiveCameraController:SetActive(active)
end

function AircraftInteractiveCameraController:Update(deltaTimeMS)
  local clicked, clickPos = self._aircraft3DManager:InputManager():GetClick()
  if clicked then
    local clickRay = self._mainCamera:ScreenPointToRay(clickPos)
    local castRes, hitInfo = UnityEngine.Physics.Raycast(clickRay, nil)
    if castRes and self._targetPet and hitInfo.transform.gameObject == self._targetPet:PetGameObject() then
      self._targetPet:InteractiveClick()
    end
  end
  local dragging, dragStartPos, dragEndPos = self._aircraft3DManager:InputManager():GetDrag()
  if dragging then
    self:HandleDragCamera(dragStartPos, dragEndPos)
  end
  self:HandleFadeObjects()
  self._cameraMng:HandleWallFade(deltaTimeMS, self.targetPos)
end

function AircraftInteractiveCameraController:HandleDragCamera(dragStartPos, dragEndPos)
  local rotVec = (dragEndPos - dragStartPos) * self.rotateSpeed
  local x = self.x + rotVec.x
  local y = self.y - rotVec.y
  x = self:_HandleX(x)
  if y > self.maxAngleY then
    y = self.maxAngleY
  end
  local rotation = Quaternion.Euler(y, x, 0)
  local target = self.targetPos + rotation * Vector3(0, 0, -self.distance)
  if target.y < self.bottomY then
    y = self.y
    rotation = Quaternion.Euler(y, x, 0)
    target = self.targetPos + rotation * Vector3(0, 0, -self.distance)
  end
  self.x = x
  self.y = y
  self._mainCamera.transform.position = target
  self._mainCamera.transform.rotation = rotation
end

function AircraftInteractiveCameraController:_HandleX(x)
  if self.minAngle < self.maxAngle then
    if 180 < x then
      x = x - 360
    elseif x < -180 then
      x = x + 360
    end
    x = Mathf.Clamp(x, self.minAngle, self.maxAngle)
  elseif self.minAngle > self.maxAngle then
    if x < 0 then
      x = x + 360
    elseif 360 < x then
      x = x - 360
    end
    x = Mathf.Clamp(x, self.minAngle, self.maxAngle + 360)
  else
    x = self.minAngle
  end
  return x
end

function AircraftInteractiveCameraController:FadeIn(TT)
  local totalTime = Cfg.cfg_aircraft_camera.translateTime.Value * 1000
  local duration = 0
  local startTime = GameGlobal:GetInstance():GetCurrentTime()
  local camOrgPos = self._mainCamera.transform.position
  local camOrgRot = self._mainCamera.transform.rotation
  while totalTime > duration do
    duration = GameGlobal:GetInstance():GetCurrentTime() - startTime
    if totalTime < duration then
      duration = totalTime
    end
    self._mainCamera.transform.position = Vector3.Lerp(camOrgPos, self._initCamPos, duration / totalTime)
    self._mainCamera.transform.rotation = Quaternion.Lerp(camOrgRot, self._initCamRot, duration / totalTime)
    self:HandleFadeObjects()
    YIELD(TT)
  end
end

function AircraftInteractiveCameraController:SetTargetPet(room, pet)
  self._targetPet = pet
  self.targetPos = pet:PetGameObject().transform.position + Vector3(0, 0.8, 0)
  local dir = Vector3.Normalize(self._mainCamera.transform.position - self.targetPos)
  local cfg = Cfg.cfg_aircraft_room_camera[room:GetRoomLogicData():SpaceId()]
  local distance = cfg.InteractDistance
  self._initCamPos = self.targetPos + dir * distance
  self._initCamRot = Quaternion.LookRotation(self.targetPos - self._initCamPos, Vector3.up)
  self.distance = Vector3.Distance(self.targetPos, self._initCamPos)
  self.x = self._initCamRot.eulerAngles.y
  self.y = self._initCamRot.eulerAngles.x
  local minHeight = 0
  self.bottomY = self.targetPos.y + minHeight
  self.maxAngleY = Cfg.cfg_aircraft_camera.interCameraMaxX.Value
  self.rotateSpeed = Cfg.cfg_aircraft_camera.interCameraRotateSpeed.Value
  self.angleRange = Cfg.cfg_aircraft_camera.interCameraAngleRange.Value
  local _y = self._initCamRot.eulerAngles.y
  if 180 < _y then
    _y = _y - 360
  end
  self.minAngle = _y - self.angleRange / 2
  if self.minAngle < -180 then
    self.minAngle = self.minAngle + 360
  end
  self.maxAngle = _y + self.angleRange / 2
  if 180 < self.maxAngle then
    self.maxAngle = self.maxAngle - 360
  end
  local fadeObjects = {}
  if cfg.FadeObjects then
    for i = 1, #cfg.FadeObjects do
      local data = cfg.FadeObjects[i]
      local fo = {}
      fo.position = Vector3(data.pos[1], data.pos[2], data.pos[3])
      fo.minRadius = data.radius[1]
      fo.maxRadius = data.radius[2]
      fadeObjects[i] = fo
    end
  end
  self.fadeObjectsCfg = fadeObjects
  local objs = room:GetFadeObjects()
  self.fadeObjects = {}
  if objs then
    for idx, obj in pairs(objs) do
      self.fadeObjects[idx] = obj:AddComponent(typeof(FadeComponent))
    end
  end
end

function AircraftInteractiveCameraController:HandleFadeObjects()
  if self.fadeObjectsCfg then
    local pos = self._mainCamera.transform.position
    for idx, fadeCpt in pairs(self.fadeObjects) do
      local cfg = self.fadeObjectsCfg[idx]
      local min = cfg.minRadius ^ 2
      local max = cfg.maxRadius ^ 2
      local sqrMagnitude = (pos - cfg.position).sqrMagnitude
      if max < sqrMagnitude and fadeCpt.Alpha < 1 then
        fadeCpt.Alpha = 1
      elseif min > sqrMagnitude and fadeCpt.Alpha > 0 then
        fadeCpt.Alpha = 0
      elseif min < sqrMagnitude and max > sqrMagnitude then
        fadeCpt.Alpha = (sqrMagnitude - min) / (max - min)
      end
    end
  end
end
