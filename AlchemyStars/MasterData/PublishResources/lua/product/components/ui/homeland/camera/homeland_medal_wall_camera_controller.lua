_class("HomelandMedalWallCameraController", Object)
HomelandMedalWallCameraController = HomelandMedalWallCameraController

function HomelandMedalWallCameraController:Constructor()
  self._resName = "HomelandMedalWallCamControl"
  self._minX = MedalWallConfig.XMin
  self._maxX = MedalWallConfig.XMax
  self._minY = MedalWallConfig.YMin
  self._maxY = MedalWallConfig.YMax
  self._minScale = MedalWallConfig.ScaleMin
  self._maxScale = MedalWallConfig.ScaleMax
  self._defaultFocusTime = MedalWallConfig.CameraResetPosTime
  self._camInitPos = nil
end

function HomelandMedalWallCameraController:Init(homelandClient)
  self._resReq = ResourceManager:GetInstance():SyncLoadAsset(self._resName .. ".prefab", LoadType.GameObject)
  self._camRootGO = self._resReq.Obj
  self._camRootTrans = self._camRootGO.transform
  self._camTrans = self._camRootTrans:GetChild(0)
  self._camRootGO:SetActive(false)
  self._cam = self._camRootGO:GetComponentInChildren(typeof(UnityEngine.Camera), false)
end

function HomelandMedalWallCameraController:Dispose()
  self._resReq:Dispose()
  self._resReq = nil
  self._camRootGO = nil
  self._camRootTrans = nil
  self._camTrans = nil
end

function HomelandMedalWallCameraController:SetActive(active)
  self._camRootGO:SetActive(active)
end

function HomelandMedalWallCameraController:CameraCmp()
  return self._cam
end

function HomelandMedalWallCameraController:CameraFowardRay()
  local camTrans = self._cam.transform
  return Ray.New(camTrans.forward, camTrans.position)
end

function HomelandMedalWallCameraController:GetFocusPos()
  return self._camRootTrans.position
end

function HomelandMedalWallCameraController:UpdateCameraTransform(cameraTransform)
  self._camRootTrans.position = cameraTransform.position
  self._camRootTrans.rotation = cameraTransform.rotation
  self._camTrans.localPosition = Vector3(0, 0, 0)
end

function HomelandMedalWallCameraController:UpdatePos(x, y, z)
  self._camRootTrans.position = Vector3(x, y, z)
end

function HomelandMedalWallCameraController:HandleMove(x, y)
  if x ~= 0 then
    local deltaX = x
    if self._camTrans.localPosition.x + x < self._minX then
      deltaX = self._minX - self._camTrans.localPosition.x
    elseif self._camTrans.localPosition.x + x > self._maxX then
      deltaX = self._maxX - self._camTrans.localPosition.x
    end
    self._camTrans.localPosition = self._camTrans.localPosition + Vector3(deltaX, 0, 0)
  end
  if y ~= 0 then
    local deltaY = y
    if self._camTrans.localPosition.y + y < self._minY then
      deltaY = self._minY - self._camTrans.localPosition.y
    elseif self._camTrans.localPosition.y + y > self._maxY then
      deltaY = self._maxY - self._camTrans.localPosition.y
    end
    self._camTrans.localPosition = self._camTrans.localPosition + Vector3(0, deltaY, 0)
  end
end

function HomelandMedalWallCameraController:HandleScale(scale)
  local delta = scale
  if self._camTrans.localPosition.z + scale < self._minScale then
    delta = self._minScale - self._camTrans.localPosition.z
  elseif self._camTrans.localPosition.z + scale > self._maxScale then
    delta = self._maxScale - self._camTrans.localPosition.z
  end
  self._camTrans.localPosition = self._camTrans.localPosition + Vector3(0, 0, delta)
end

function HomelandMedalWallCameraController:ResetInitPos(callBackFun)
  local focusTime = self._defaultFocusTime
  GameGlobal.UIStateManager():Lock("HomelandMedalWallCameraController:Reset")
  self._camTrans:DOLocalMove(Vector3(0, 0, 0), focusTime, false):OnComplete(function()
    if callBackFun then
      callBackFun()
    end
    GameGlobal.UIStateManager():UnLock("HomelandMedalWallCameraController:Reset")
  end)
end

function HomelandMedalWallCameraController:ScalePercent()
  local percent = (self._maxScale - self._camTrans.localPosition.z) / (self._maxScale - self._minScale)
  return percent
end
