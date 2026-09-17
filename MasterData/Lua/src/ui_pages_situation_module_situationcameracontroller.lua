local this = class("situationCameraController")
local rotSpeed = 0.3
local rotYSpeed = 0.1
local rotLerpSpeed = 50
local pinchSpeedPc = 0.8
local pinchSpeedMobile = 0.005
local moveLerpSpeed = 15
local lerpSpeed = 20
local moveSpeed = 5

function this:init(camera, lookTargetTransform)
  self.controlMoveHandle = self.controlMoveHandle or L_CommonUtil.handle(self.controlMove, self)
  self.camera = camera
  self.cameraTransform = camera.transform
  self.lookTargetTransform = lookTargetTransform
  self.targetMovePos = self.cameraTransform.localPosition
  self.onTouchStartHandle = self.onTouchStartHandle or L_CommonUtil.handle(self.on_touchStartHandle, self)
  self.onTouchDownHandle = self.onTouchDownHandle or L_CommonUtil.handle(self.on_touchDownHandle, self)
  self.onTouchUpHandle = self.onTouchUpHandle or L_CommonUtil.handle(self.on_touchUpHandle, self)
  self.onPinchHandle = self.onPinchHandle or L_CommonUtil.handle(self.on_Pinch, self)
  self:registListener()
  self.distance = C_Vector3.Distance(self.cameraTransform.localPosition, self.lookTargetTransform.localPosition)
  self.targetDistance = self.distance
  self.minDistance = 1
  self.maxDistance = 8
  local p1 = C_Vector3(self.lookTargetTransform.localPosition.x, 0, self.lookTargetTransform.localPosition.z)
  local p2 = C_Vector3(self.cameraTransform.localPosition.x, 0, self.cameraTransform.localPosition.z)
  self.planeDir = C_Vector3.Normalize(p2 - p1)
  self.targetPlaneDir = self.planeDir
  local dir = C_Vector3.Normalize(self.cameraTransform.localPosition - self.lookTargetTransform.localPosition)
  self.pitch = C_Vector3.Angle(self.planeDir, dir)
  self.targetPitch = self.pitch
  self.minPitch = 5
  self.maxPitch = 80
  self.targetPos = lookTargetTransform.localPosition
  self.isPC = L_DeviceTpl:getIsPc()
end

function this:registListener()
  C_ScreenTouch.On_DragStart("+", self.onTouchStartHandle)
  C_ScreenTouch.On_Drag("+", self.onTouchDownHandle)
  C_ScreenTouch.On_DragEnd("+", self.onTouchUpHandle)
  C_ScreenTouch.On_Pinch("+", self.onPinchHandle)
  C_InputManager.AddAxisListener(L_Const.axisType.emainMoveMent, self.controlMoveHandle)
end

function this:release()
  self.camera = nil
  self.moveDir = nil
  C_ScreenTouch.On_DragStart("-", self.onTouchStartHandle)
  C_ScreenTouch.On_Drag("-", self.onTouchDownHandle)
  C_ScreenTouch.On_DragEnd("-", self.onTouchUpHandle)
  C_ScreenTouch.On_Pinch("-", self.onPinchHandle)
  C_InputManager.RemoveAxisListener(L_Const.axisType.emainMoveMent, self.controlMoveHandle)
end

function this:update()
  if self.camera then
    if self.camera and self.moveDir and self.moveDir.magnitude > 1.0E-7 then
      local forward = C_Vector3(self.cameraTransform.forward.x, 0, self.cameraTransform.forward.z)
      local right = C_Vector3(self.cameraTransform.right.x, 0, self.cameraTransform.right.z)
      forward = C_Vector3.Normalize(forward)
      right = C_Vector3.Normalize(right)
      local moveWorld = forward * self.moveDir.y + right * self.moveDir.x
      moveWorld = C_Vector3.Normalize(moveWorld) * moveSpeed * C_Time.deltaTime
      self.targetPos = self.targetPos + moveWorld
      self.targetPos.x = math.clamp(self.targetPos.x, -10, 10)
      self.targetPos.z = math.clamp(self.targetPos.z, -10, 10)
      L_SituationManager:changeCameraTargetPos(self.targetPos, true)
    end
    local pos = C_Vector3.Lerp(self.lookTargetTransform.localPosition, self.targetPos, moveLerpSpeed * C_Time.deltaTime)
    self.lookTargetTransform.localPosition = pos
    self.distance = math.lerp(self.distance, self.targetDistance, lerpSpeed * C_Time.deltaTime)
    self.planeDir = C_Vector3.Lerp(self.planeDir, self.targetPlaneDir, rotLerpSpeed * C_Time.deltaTime)
    self.pitch = math.lerp(self.pitch, self.targetPitch, rotLerpSpeed * C_Time.deltaTime)
    local horizontalDir = C_Vector3.Normalize(self.planeDir)
    local dir = C_Quaternion.AngleAxis(self.pitch, C_Vector3.Cross(horizontalDir, C_Vector3.up)) * horizontalDir
    dir = C_Vector3.Normalize(dir)
    local offset = dir * self.distance
    local targetPos = self.lookTargetTransform.localPosition + offset
    L_SituationManager:changeCameraPos(targetPos)
  end
end

function this:on_touchStartHandle(gesture)
  if gesture.go == nil or gesture.go.layer == 0 then
    self.isDragging = true
  end
end

function this:on_touchDownHandle(gesture)
  if not self.isDragging then
    return
  end
  local deltaPos = gesture.deltaPosition
  local offset = self.targetPlaneDir
  local angle = deltaPos.x * rotSpeed
  local rotation = C_Quaternion.Euler(0, angle, 0)
  self.targetPlaneDir = rotation * self.targetPlaneDir
  local yAngle = deltaPos.y * rotYSpeed
  self.targetPitch = self.targetPitch - yAngle
  self.targetPitch = math.clamp(self.targetPitch, self.minPitch, self.maxPitch)
end

function this:on_touchUpHandle(gesture)
  self.isDragging = false
end

function this:on_Pinch(gesture)
  local delta = gesture.deltaPinch
  if self.isPC then
    self.targetDistance = self.targetDistance - delta * pinchSpeedPc
  else
    self.targetDistance = self.targetDistance - delta * pinchSpeedMobile
  end
  self.targetDistance = math.clamp(self.targetDistance, self.minDistance, self.maxDistance)
end

function this:controlMove(v2)
  self.moveDir = v2
  if v2.x == 0 and v2.y == 0 then
    return
  end
end

return this
