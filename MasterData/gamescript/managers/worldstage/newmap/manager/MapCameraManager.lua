local MapCameraManager, Super = System.NewClass("MapCameraManager", Manager)

function MapCameraManager:ctor()
  Super.ctor(self)
  self.dragVMCamera = nil
  self.camera = nil
  self.attached = false
  self.followVMCamera = nil
  self.maxDistance = 7.3
  self.minDistance = 6.3
  self.curDistance = self.minDistance
end

function MapCameraManager:Awake(binder)
  Super.Awake(self)
  self.binder = binder
  self:InitCamera()
  binder:BindEvent(EventMgr.Instance.BattleFinish, System.fn(self, self.InitCamera))
end

function MapCameraManager:InitCamera()
  local mainCamera = UIRootMgr.GetMainCamera()
  self.dragVMCamera = self.parent.rootNode.transform:Find("dragCamera")
  self.binder:SetActive(self.dragVMCamera.gameObject, not self.parent:IsOneLineMap())
  self.sceneVMCameraGo = self.parent.bgNode.transform:Find("CinimationB").gameObject
  self.followVMState = true
  local go = mainCamera.gameObject
  local cinemachine = go:GetComponent(typeof(CS.Cinemachine.CinemachineBrain))
  cinemachine.enabled = true
  self.rayCaster = go:GetComponent(typeof(CS.UnityEngine.EventSystems.PhysicsRaycaster))
  self.rayCaster.enabled = true
  self.camera = mainCamera
end

function MapCameraManager:OnHide()
  if self.rayCaster then
    self.rayCaster.enabled = false
  end
end

function MapCameraManager:OnShow()
  if self.camera and self.rayCaster then
    local cinemachine = self.camera.gameObject:GetComponent(typeof(CS.Cinemachine.CinemachineBrain))
    cinemachine.enabled = true
    self.rayCaster.enabled = true
  end
  local mapRole = WorldStageManager.Instance:GetCurMapRole()
  local cameraTf = mapRole and mapRole.cameraTransform
  if not IsNil(self.sceneVMCameraGo) and self.sceneVMCameraGo.activeInHierarchy then
    cameraTf = self.sceneVMCameraGo.transform
  end
  if cameraTf then
    local cinemachine = self.camera.gameObject:GetComponent(typeof(CS.Cinemachine.CinemachineBrain))
    cinemachine.enabled = false
    self.camera.transform.position = cameraTf.position
    self.camera.transform.eulerAngles = cameraTf.eulerAngles
    self.cinamachineEnableTimer = TimerManager.Instance:CreateTimer(0, 0, nil, function()
      self.cinamachineEnableTimer = nil
      if self.camera then
        cinemachine.enabled = true
      end
    end)
  end
end

function MapCameraManager:SetFollowCameraState(state)
  if self.followVMState == state then
    return
  end
  self.followVMState = state
  self.binder:SetActive(self.followVMCamera.gameObject, state)
end

function MapCameraManager:GetFollowCameraState()
  return self.followVMState
end

function MapCameraManager:InitDragCameraPos()
  local pos = self.followVMCamera.position
  self:SetDragCameraPos(pos)
end

function MapCameraManager:SetDragCameraPos(pos)
  if self.dragVMCamera == nil then
    return
  end
  self.dragVMCamera.localPosition = pos
end

function MapCameraManager:AttachFollow(camera, target, pos, anim)
  if self.attached then
    return
  end
  self.attached = true
  self.followVMCamera = camera
  if anim then
    self.followVMCamera.parent = target
    self.followVMCamera:DOLocalMove(pos, 1.0):SetEase(CS.DG.Tweening.Ease.OutSine):OnComplete(function()
    end)
  else
    self.followVMCamera.parent = target
    self.followVMCamera.localPosition = pos
  end
end

function MapCameraManager:DetachFollow(_, pos)
  if self.attached == false then
    return
  end
  self.attached = false
  self.followVMCamera.parent = self.parent.rootNode.transform
  self.followVMCamera.localPosition = pos
end

function MapCameraManager:CameraZoom(scale)
  scale = -(1 - scale) / 2
  local distance = self.curDistance - scale
  if distance > self.maxDistance then
    distance = self.maxDistance
  end
  if distance < self.minDistance then
    distance = self.minDistance
  end
  self.curDistance = distance
  Logger.Info("Scale Distance>>>>", scale, distance)
  local dis = -distance
  local pos = self.followVMCamera.forward * dis
  self.followVMCamera.localPosition = pos
end

function MapCameraManager:OnDestroy()
  Super.OnDestroy(self)
  if self.camera then
    local cinemachine = self.camera.gameObject:GetComponent(typeof(CS.Cinemachine.CinemachineBrain))
    cinemachine.enabled = true
  end
  if self.cinamachineEnableTimer then
    TimerManager.Instance:StopTimer(self.cinamachineEnableTimer)
    self.cinamachineEnableTimer = nil
  end
  if self.rayCaster then
    self.rayCaster.enabled = false
  end
  self.camera = nil
end

return MapCameraManager
