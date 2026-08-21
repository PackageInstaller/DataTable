_class("HomeStoryEntityCameraVC", HomeStoryEntity)
HomeStoryEntityCameraVC = HomeStoryEntityCameraVC

function HomeStoryEntityCameraVC:Constructor(ID, gameObject, resRequest, storyManager, cfg)
  HomeStoryEntityCameraVC.super.Constructor(self, ID, gameObject, resRequest, storyManager)
  self._type = HomeStoryEntityType.CameraVC
  self._subType = cfg.SubType
  self._isSmoothPath = false
  self._vc = gameObject:GetComponentInChildren(typeof(Cinemachine.CinemachineVirtualCamera))
  self:ResetTr()
  if self._subType == CameraVCSubType.Cart then
    self._cart = gameObject:GetComponentInChildren(typeof(Cinemachine.CinemachineDollyCart))
    self._cart.m_Speed = 0
    self._cart.m_Position = 0
    self._path = gameObject:GetComponentInChildren(typeof(Cinemachine.CinemachineSmoothPath))
    if self._path then
      self._isSmoothPath = true
    else
      self._path = gameObject:GetComponentInChildren(typeof(Cinemachine.CinemachinePath))
      if self._path then
        self._isSmoothPath = false
      else
        Log.error("###[HomeStoryEntityCameraVC] path vc not find path ! ID --> ", ID)
      end
    end
    self._path.transform.localPosition = Vector3(0, 0, 0)
  end
  self._active = false
end

function HomeStoryEntityCameraVC:ResetTr()
  if self._vc then
    local tr = self._vc.transform
    tr.localPosition = Vector3(0, 0, 0)
    tr.localScale = Vector3(1, 1, 1)
    self._vc.Priority = 0
  end
end

function HomeStoryEntityCameraVC:_SetPosition(pos)
  self._gameObject.transform.localPosition = pos
end

function HomeStoryEntityCameraVC:_SetRotation(rot)
  self._gameObject.transform.localRotation = rot
end

function HomeStoryEntityCameraVC:_TriggerKeyframe(keyframeData)
  HomeStoryEntityCameraVC.super._TriggerKeyframe(self, keyframeData)
  if keyframeData.Active ~= nil then
    self:SetActive(keyframeData.Active)
  end
  if keyframeData.Position3D ~= nil then
    self:_SetPosition(Vector3(keyframeData.Position3D[1], keyframeData.Position3D[2], keyframeData.Position3D[3]))
  end
  if keyframeData.Rotation3D ~= nil then
    self:_SetRotation(Quaternion.Euler(keyframeData.Rotation3D[1], keyframeData.Rotation3D[2], keyframeData.Rotation3D[3]))
  end
  if keyframeData.Shake ~= nil then
    local shakeData = keyframeData.Shake
    self:ShakeCamera(shakeData)
  elseif keyframeData.StartShake ~= nil then
    local shakeData = keyframeData.StartShake
    self:StartShake(shakeData)
  elseif keyframeData.StopShake ~= nil then
    self:StopShake()
  end
  if keyframeData.Look then
    local lookid = keyframeData.Look
    self:LookEntity(lookid)
  end
  if keyframeData.Fov then
    self:SetFov(keyframeData.Fov)
  end
  if keyframeData.OpenPath then
    self:OpenPath(keyframeData.OpenPath)
  end
end

function HomeStoryEntityCameraVC:OpenPath(data)
  local duration = data.Duration
  local ease = data.Ease
  self._cart.m_Speed = 0
  self._cart.m_Position = 0
  if not duration or duration <= 0 then
    Log.error("###[HomeStoryEntityCameraVC] Open Path bug duration is nil or <= 0 ! id --> ", self._ID)
  else
    self._pathing = true
    self._pathStartTime = 0
    self._pathNormalized = 0
    self._pathDuration = duration
    self._ease = self:GetEase(ease)
  end
end

function HomeStoryEntityCameraVC:GetEase(type)
  local ease = DG.Tweening.Ease.Linear
  if not type then
    return ease
  end
  if type == 0 then
    ease = DG.Tweening.Ease.Linear
  elseif type == 1 then
    ease = DG.Tweening.Ease.InSine
  elseif type == 2 then
    ease = DG.Tweening.Ease.OutSine
  elseif type == 3 then
    ease = DG.Tweening.Ease.InOutSine
  elseif type == 4 then
    ease = DG.Tweening.Ease.InQuad
  elseif type == 5 then
    ease = DG.Tweening.Ease.OutQuad
  elseif type == 6 then
    ease = DG.Tweening.Ease.InOutQuad
  elseif type == 7 then
    ease = DG.Tweening.Ease.InCubic
  elseif type == 8 then
    ease = DG.Tweening.Ease.OutCubic
  elseif type == 9 then
    ease = DG.Tweening.Ease.InOutCubic
  elseif type == 10 then
    ease = DG.Tweening.Ease.InQuart
  elseif type == 11 then
    ease = DG.Tweening.Ease.OutQuart
  elseif type == 12 then
    ease = DG.Tweening.Ease.InOutQuart
  elseif type == 13 then
    ease = DG.Tweening.Ease.InQuint
  elseif type == 14 then
    ease = DG.Tweening.Ease.OutQuint
  elseif type == 15 then
    ease = DG.Tweening.Ease.InOutQuint
  elseif type == 16 then
    ease = DG.Tweening.Ease.InExpo
  elseif type == 17 then
    ease = DG.Tweening.Ease.OutExpo
  elseif type == 18 then
    ease = DG.Tweening.Ease.InOutExpo
  elseif type == 19 then
    ease = DG.Tweening.Ease.InCirc
  elseif type == 20 then
    ease = DG.Tweening.Ease.OutCirc
  elseif type == 21 then
    ease = DG.Tweening.Ease.InOutCirc
  elseif type == 22 then
    ease = DG.Tweening.Ease.InBack
  elseif type == 23 then
    ease = DG.Tweening.Ease.OutBack
  elseif type == 24 then
    ease = DG.Tweening.Ease.InOutBack
  elseif type == 25 then
    ease = DG.Tweening.Ease.InElastic
  elseif type == 26 then
    ease = DG.Tweening.Ease.OutElastic
  elseif type == 27 then
    ease = DG.Tweening.Ease.InOutElastic
  elseif type == 28 then
    ease = DG.Tweening.Ease.InBounce
  elseif type == 29 then
    ease = DG.Tweening.Ease.OutBounce
  elseif type == 30 then
    ease = DG.Tweening.Ease.InOutBounce
  else
    ease = DG.Tweening.Ease.Linear
  end
  return ease
end

function HomeStoryEntityCameraVC:SetFov(fov)
  local val = fov.Value
  local duration = fov.Duration
  if duration and 0 < duration then
    self._foving = true
    self._fovStartTime = 0
    self._fovTime = duration
    self._oldFov = self._vc.m_Lens.FieldOfView
    local ease = fov.Ease
    self._fovEase = self:GetEase(ease)
    self._newFov = val
  else
    self._vc.m_Lens.FieldOfView = val
  end
end

function HomeStoryEntityCameraVC:ActiveVC(active)
  local priority
  if active then
    priority = 1
    self:ResetTr()
  else
    priority = 0
  end
  if not self._active then
    self:SetActive(true)
  end
  self._vc.Priority = priority
end

function HomeStoryEntityCameraVC:LookEntity(id)
  if id == -1 then
    self._vc.m_LookAt = nil
  else
    local tr = self._storyManager:GetEntityGo(id).transform
    self._vc.m_LookAt = tr
  end
end

function HomeStoryEntityCameraVC:ShakeCamera(data)
  local noise = self._vc:GetCinemachineComponent(Cinemachine.CinemachineCore.Stage.Noise)
  noise.m_AmplitudeGain = data.Strength
  noise.m_FrequencyGain = data.Speed
  noise.m_PivotOffset = Vector3(data.Offset[1], data.Offset[2], data.Offset[3])
  self._shaking = true
  self._shakeTime = data.Duration
end

function HomeStoryEntityCameraVC:StartShake(data)
  local noise = self._vc:GetCinemachineComponent(Cinemachine.CinemachineCore.Stage.Noise)
  noise.m_AmplitudeGain = data.Strength
  noise.m_FrequencyGain = data.Speed
  noise.m_PivotOffset = data.Offset
end

function HomeStoryEntityCameraVC:StopShake()
  local noise = self._vc:GetCinemachineComponent(Cinemachine.CinemachineCore.Stage.Noise)
  noise.m_AmplitudeGain = 0
  noise.m_FrequencyGain = 0
  noise.m_PivotOffset = Vector3(0, 0, 0)
  self._shakeTime = 0
  self._shaking = false
end

function HomeStoryEntityCameraVC:SetActive(active)
  self._active = active
  self._gameObject:SetActive(active)
end

function HomeStoryEntityCameraVC:SetPos(pos)
  self._gameObject.transform.position = pos
end

function HomeStoryEntityCameraVC:Dispose()
end

function HomeStoryEntityCameraVC:Destroy()
  HomeStoryEntityCameraVC.super.Destroy(self)
  self:Dispose()
end

function HomeStoryEntityCameraVC:_UpdateAnimation(time)
  local res = HomeStoryEntityCameraVC.super._UpdateAnimation(self, time)
  local allEnd = true
  if self._shaking then
    if time > self._shakeTime then
      self:StopShake()
    else
      allEnd = false
    end
  end
  return res and allEnd
end

function HomeStoryEntityCameraVC:OnUpdate(dms)
  if self._foving then
    self._fovStartTime = self._fovStartTime + dms
    local rate = self._fovStartTime / self._fovTime
    if 1 < rate then
      rate = 1
    end
    local fov = DG.Tweening.DOVirtual.EasedValue(self._oldFov, self._newFov, rate, self._fovEase)
    self._vc.m_Lens.FieldOfView = fov
    if rate == 1 then
      self._vc.m_Lens.FieldOfView = self._newFov
      self._oldFov = self._newFov
      self._foving = false
    end
  end
  if self._pathing then
    self._pathStartTime = self._pathStartTime + dms
    local rate = self._pathStartTime / self._pathDuration
    if 1 < rate then
      rate = 1
    end
    local normlize = DG.Tweening.DOVirtual.EasedValue(0, 1, rate, self._ease)
    self._cart.m_Position = normlize
    if rate == 1 then
      self._cart.m_Position = 1
      self._pathing = false
    end
  end
end
