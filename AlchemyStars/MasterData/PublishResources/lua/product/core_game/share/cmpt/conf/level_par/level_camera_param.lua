_class("LevelCameraParam", Object)
LevelCameraParam = LevelCameraParam

function LevelCameraParam:Constructor()
  self._fov = 0.5
  self._near_clip_distance = 100
  self._far_clip_distance = 2000
  self._camera_position = Vector3(397.3, 506.7, -396.7)
  self._camera_rotation = Quaternion.Euler(42, -45, 0)
  self._camera_rotation_vector3 = Vector3(42, -45, 0)
  self._runType = CameraRunType.None
  self._runRotationBeginVector3 = Vector3(-10, -45, 0)
  self._runTimeLen = 2
  self._runDelayTime = 2
  self._touchMoveCameraSpeed = BattleConst.TouchMoveCameraSpeed
  self._touchMoveCameraEdgeSpeed = BattleConst.TouchMoveCameraEdgeSpeed
  self._moveCameraEdge = BattleConst.MoveCameraEdge
  self._cameraMaxHorizatalLeft = BattleConst.CameraMaxHorizatalLeft
  self._cameraMaxHorizatalRight = BattleConst.CameraMaxHorizatalRight
  self._cameraMaxVerticalUp = BattleConst.CameraMaxVerticalUp
  self._cameraMaxVerticalDown = BattleConst.CameraMaxVerticalDown
end

function LevelCameraParam:GetRunType()
  return self._runType
end

function LevelCameraParam:GetRunTimeLen()
  return self._runTimeLen
end

function LevelCameraParam:GetRunDelayTime()
  return self._runDelayTime
end

function LevelCameraParam:GetRunRotationBeginVector3()
  return self._runRotationBeginVector3
end

function LevelCameraParam:GetCameraRotationVector3()
  return self._camera_rotation_vector3
end

function LevelCameraParam:GetFov()
  return self._fov
end

function LevelCameraParam:GetNearClipDistance()
  return self._near_clip_distance
end

function LevelCameraParam:GetFarClipDistance()
  return self._far_clip_distance
end

function LevelCameraParam:GetCameraPosition()
  return self._camera_position
end

function LevelCameraParam:GetCameraRotation()
  return self._camera_rotation
end

function LevelCameraParam:GetTouchMoveCameraSpeed()
  return self._touchMoveCameraSpeed
end

function LevelCameraParam:GetTouchMoveCameraEdgeSpeed()
  return self._touchMoveCameraEdgeSpeed
end

function LevelCameraParam:GetMoveCameraEdge()
  return self._moveCameraEdge
end

function LevelCameraParam:GetCameraMaxHorizatalLeft()
  return self._cameraMaxHorizatalLeft
end

function LevelCameraParam:GetCameraMaxHorizatalRight()
  return self._cameraMaxHorizatalRight
end

function LevelCameraParam:GetCameraMaxVerticalUp()
  return self._cameraMaxVerticalUp
end

function LevelCameraParam:GetCameraMaxVerticalDown()
  return self._cameraMaxVerticalDown
end

function LevelCameraParam:ResetFov()
  self._fov = self._config_fov or 0.5
  local defaultAspect = BattleConst.CameraDefaultAspect
  local aspect = UnityEngine.Screen.width / UnityEngine.Screen.height
  if defaultAspect > aspect then
    self._fov = self._config_fov + (defaultAspect - aspect) * 6
  end
end

function LevelCameraParam:ParseCameraParam(gridConfigData)
  self._config_fov = gridConfigData.Fov
  self:ResetFov()
  self._near_clip_distance = gridConfigData.NearClipDistance
  self._far_clip_distance = gridConfigData.FarClipDistance
  local numberArray = string.split(gridConfigData.CameraPosition, ",")
  local positionX = tonumber(numberArray[1])
  local positionY = tonumber(numberArray[2])
  local positionZ = tonumber(numberArray[3])
  local cameraPos = Vector3(positionX, positionY, positionZ)
  self._camera_position = cameraPos
  local rotationNumberArray = string.split(gridConfigData.CameraRotation, ",")
  local rotationX = tonumber(rotationNumberArray[1])
  local rotationY = tonumber(rotationNumberArray[2])
  local rotationZ = tonumber(rotationNumberArray[3])
  local cameraRotation = Quaternion.Euler(rotationX, rotationY, rotationZ)
  self._camera_rotation = cameraRotation
  self._camera_rotation_vector3 = Vector3(rotationX, rotationY, rotationZ)
  if gridConfigData.TouchMoveCameraSpeed then
    self._touchMoveCameraSpeed = gridConfigData.TouchMoveCameraSpeed
  end
  if gridConfigData.TouchMoveCameraEdgeSpeed then
    self._touchMoveCameraEdgeSpeed = gridConfigData.TouchMoveCameraEdgeSpeed
  end
  if gridConfigData.MoveCameraEdge then
    self._moveCameraEdge = gridConfigData.MoveCameraEdge
  end
  if gridConfigData.CameraMaxDistance then
    self._cameraMaxHorizatalLeft = gridConfigData.CameraMaxDistance[1]
    self._cameraMaxHorizatalRight = gridConfigData.CameraMaxDistance[2]
    self._cameraMaxVerticalUp = gridConfigData.CameraMaxDistance[3]
    self._cameraMaxVerticalDown = gridConfigData.CameraMaxDistance[4]
  end
  self._runType = gridConfigData.CameraRunType
  if self._runType == CameraRunType.XRotation then
    self:_ParseXRotationParam(gridConfigData.CameraRunTypeParam)
  end
end

function LevelCameraParam:_ParseXRotationParam(param)
  local ruNumberArray = string.split(param[1], ",")
  self._runRotationBeginVector3 = Vector3(tonumber(ruNumberArray[1]), tonumber(ruNumberArray[2]), tonumber(ruNumberArray[3]))
  self._runTimeLen = tonumber(param[2])
  self._runDelayTime = tonumber(param[3])
end
