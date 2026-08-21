_class("CameraService", BaseService)
CameraService = CameraService

function CameraService:Constructor(world)
  self.world = world
  self._timeService = self.world:GetService("Time")
end

function CameraService:PlayCameraShake(shakeParam)
  GameGlobal.TaskManager():CoreGameStartTask(self.UpdateCameraShake, self, shakeParam)
end

function CameraService:UpdateCameraShake(TT, shakeParam)
  local delay = shakeParam.delay
  local duration = shakeParam.duration
  local timeElapsed = 0
  while 0 < delay do
    if delay < self._timeService:GetDeltaTimeMs() then
      duration = duration - delay
      timeElapsed = timeElapsed + delay
    end
    delay = delay - self._timeService:GetDeltaTimeMs()
    YIELD(TT)
  end
  local mainCameraCmpt = self.world:MainCamera()
  local oriPos = mainCameraCmpt:Camera().transform.position
  while 0 < duration do
    local offset = self:CalcShake(timeElapsed, shakeParam)
    mainCameraCmpt:ShakeCamera(oriPos, offset)
    timeElapsed = timeElapsed + self._timeService:GetDeltaTimeMs()
    duration = duration - self._timeService:GetDeltaTimeMs()
    YIELD(TT)
  end
end

function CameraService:CalcShake(timeElapsed, shakeParam)
  local damp = self:Damp(shakeParam, timeElapsed)
  local offset = self:LinearVib(shakeParam.period, timeElapsed)
  local dir = Quaternion.Euler(0, 0, shakeParam.mainVibAngle):MulVec3(Vector3(1, 0, 0))
  local mainVib = dir * shakeParam.intenseRandomness * offset
  local randomVib = Vector3(0, 0, 0)
  if Mathf.Abs(shakeParam.intenseRandomness) > 1.0E-6 then
    randomVib = self:EmitRandomVib(shakeParam)
  end
  return (mainVib + randomVib) * damp
end

function CameraService:Damp(shakeParam, timeElapsed)
  local periodElapsed = 0
  while timeElapsed > shakeParam.period do
    timeElapsed = timeElapsed - shakeParam.period
    periodElapsed = periodElapsed + 1
  end
  return Mathf.Pow(1 - shakeParam.decayRate, periodElapsed)
end

function CameraService:LinearVib(period, timeElapsed)
  while period < timeElapsed do
    timeElapsed = timeElapsed - period
  end
  local offset
  if timeElapsed < 0.25 * period then
    offset = 4 / period * timeElapsed
  elseif timeElapsed < 0.75 * period then
    offset = 2 - 4 / period * timeElapsed
  else
    offset = -4 + 4 / period * timeElapsed
  end
  return offset
end

function CameraService:EmitRandomVib(shakeParam)
  local randomSvc = self._world:GetService("RandomRender")
  local angle = randomSvc:RenderRand(-shakeParam.angleRandomness, shakeParam.angleRandomness)
  local intense = randomSvc:RenderRand(-shakeParam.intenseRandomness, shakeParam.intenseRandomness)
  if 0 < intense then
    angle = shakeParam.mainVibAngle + 90 + angle
  else
    angle = shakeParam.mainVibAngle - 90 + angle
  end
  return Quaternion.Euler(0, 0, angle):MulVec3(Vector3(1, 0, 0)) * Mathf.Abs(intense)
end

function CameraService:_InitSceneCamera()
  local levelConfigData = self._configService:GetLevelConfigData()
  local cameraParam = levelConfigData:GetCameraParam()
  local camera_cmpt = self._world:MainCamera()
  local main_camera = camera_cmpt:Camera()
  main_camera.fieldOfView = cameraParam:GetFov()
  main_camera.nearClipPlane = cameraParam:GetNearClipDistance()
  main_camera.farClipPlane = cameraParam:GetFarClipDistance()
  main_camera.transform.position = cameraParam:GetCameraPosition()
  main_camera.transform.rotation = cameraParam:GetCameraRotation()
end

function CameraService:InitializeSceneCamera()
  self:_InitSceneCamera()
  local mainCameraCmpt = self._world:MainCamera()
  mainCameraCmpt:LoadHUDCamera()
  mainCameraCmpt:LoadDarkCamera()
  mainCameraCmpt:LoadEffectCamera()
  mainCameraCmpt:LoadSceneCamera()
  mainCameraCmpt:LoadAuroraTimeFx()
  mainCameraCmpt:AttachScreenEffPoint()
  self:ReplacePostProcessingProfile()
  HelperProxy:GetInstance():InitCameraShake()
end

function CameraService:CameraFollowHero(oldPos, newPos)
  local camera_cmpt = self._world:MainCamera()
  local main_camera = camera_cmpt:Camera()
  local camPos = main_camera.transform.position
  local diff = newPos - oldPos
  local tarPos = Vector3(camPos.x + diff.x, camPos.y, camPos.z + diff.y)
  Log.error("board center " .. tostring(oldPos) .. "->" .. tostring(newPos))
  self._world:MainCamera():SetCameraPos(tarPos)
  local trans = main_camera.transform
  trans:DOMove(tarPos, 0.5)
end

function CameraService:BlinkMainCamera(enabled)
  local cMainCamera = self._world:MainCamera()
  local camera = cMainCamera:Camera()
  camera.enabled = enabled
end

function CameraService:ReplacePostProcessingProfile()
  local postObjName = "PostTemp"
  local tmpObj = UnityEngine.GameObject.Find(postObjName)
  if not tmpObj then
    return
  end
  local tmpPostProcessingCmpt = tmpObj:GetComponent("UnityEngine.H3DPostProcessing.PostProcessing")
  local tmpProfile = tmpPostProcessingCmpt.profile
  local mainCameraCmpt = self._world:MainCamera()
  mainCameraCmpt:SetPostProcessingProfile(tmpProfile)
  local goEffRuchangActorpoint = UnityEngine.GameObject.Find(GameResourceConst.EffRuchangActorpoint)
  if goEffRuchangActorpoint then
    local camera = goEffRuchangActorpoint:GetComponentInChildren(typeof(UnityEngine.Camera), true)
    if camera then
      local pp = camera.gameObject:GetComponent("UnityEngine.H3DPostProcessing.PostProcessing")
      if pp then
        pp.profile = tmpProfile
      end
    end
  end
  tmpObj:SetActive(false)
end

function CameraService:ResetFov_ForFoldableDevice()
  local levelConfigData = self._configService:GetLevelConfigData()
  local cameraParam = levelConfigData:GetCameraParam()
  cameraParam:ResetFov()
  local camera_cmpt = self._world:MainCamera()
  local main_camera = camera_cmpt:Camera()
  main_camera.fieldOfView = cameraParam:GetFov()
  local camera_cmp = self._world:MainCamera()
  camera_cmp:ResetFov_ForFoldableDevice()
end

_class("CameraShakeParams", Object)
CameraShakeParams = CameraShakeParams

function CameraShakeParams:Constructor(delay, intensity, mainVibAngle, duration, vibrato, decayRate, angleRandomness, intenseRandomness)
  self.delay = delay
  self.intensity = intensity
  self.mainVibAngle = mainVibAngle
  self.duration = duration
  self.vibrato = vibrato
  self.period = duration / vibrato
  self.decayRate = decayRate
  if self.decayRate > 1 and self.decayRate < 100 then
    self.decayRate = self.decayRate / 100
  end
  self.angleRandomness = angleRandomness
  self.intenseRandomness = intenseRandomness
end
