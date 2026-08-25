local EffectAudioPostCtrl = NewClass("EffectAudioPostCtrl")

function EffectAudioPostCtrl:ctor(container)
  self.container = container
  self.audioPlayedEvent = ""
  self.audioStopedEvent = ""
  self.delay = 0
  self.effTime = 0
  self._effectTime = 0
  self._delayTime = 0
  self._hasPlayedStopAudio = false
  self._hasStarted = false
  self:ParseParamFormGO()
end

function EffectAudioPostCtrl:ParseParamFormGO()
  local childTrans = self.container.gameObject:GetComponentsInChildren(typeof(CS.UnityEngine.Transform))
  for i = 1, childTrans.Length do
    local childTran = childTrans:GetValue(i - 1)
    if string.find(childTran.gameObject.name, "LuaCompParam_EffectAudioPostCtrl:") then
      local p1, p2, p3, p4 = string.match(childTran.gameObject.name, "LuaCompParam_EffectAudioPostCtrl:(.-),(.-),(.-),(.-),")
      self.audioPlayedEvent = p1 or ""
      self.audioStopedEvent = p2 or ""
      self.delay = tonumber(p3) or 0
      self.effTime = tonumber(p4) or 0
      print("EffectAudioPostCtrl Parameter 1:", p1)
      print("EffectAudioPostCtrl Parameter 2:", p2)
      print("EffectAudioPostCtrl Parameter 3:", p3)
      print("EffectAudioPostCtrl Parameter 4:", p4)
    else
      print("EffectAudioPostCtrl Error: String does not contain 'POST_PARAM:'")
    end
  end
end

function EffectAudioPostCtrl:Awake()
  self._hasStarted = true
  self:StartPlay()
end

function EffectAudioPostCtrl:OnEnable()
  if self._hasStarted then
    return
  end
  self:StartPlay()
end

function EffectAudioPostCtrl:Update()
  if self._delayTime > 0 then
    self._delayTime = self._delayTime - CS.UnityEngine.Time.deltaTime
    if self._delayTime < 0 then
      self:PostStartEvent()
    end
    return
  end
  if self._effectTime < 0 then
    return
  end
  self._effectTime = self._effectTime - CS.UnityEngine.Time.deltaTime
  if self._effectTime <= 0 and not self._hasPlayedStopAudio then
    self._hasPlayedStopAudio = true
    if self.audioStopedEvent ~= "" then
      AudioManager.Instance:PostSoundEvent(self.audioStopedEvent)
    end
  end
end

function EffectAudioPostCtrl:OnDisable()
  if not self._hasStarted then
    return
  end
  if not self._hasPlayedStopAudio then
    self._hasPlayedStopAudio = true
    if self.audioStopedEvent ~= "" then
      AudioManager.Instance:PostSoundEvent(self.audioStopedEvent)
    end
  end
end

function EffectAudioPostCtrl:StartPlay()
  self._hasPlayedStopAudio = false
  self._delayTime = self.delay
  self._effectTime = self:ComputeEffectLifeTime()
  if self._delayTime <= 0 then
    self:PostStartEvent()
  end
end

function EffectAudioPostCtrl:ComputeEffectLifeTime()
  if 0 ~= self.effTime then
    return self.effTime
  end
  local subLife = 0
  local cps = self.container.gameObject:GetComponentsInChildren(typeof(CS.UnityEngine.ParticleSystem))
  for i = 1, cps.Length do
    local cp = cps:GetValue(i - 1)
    if cp.main.loop then
      return -1
    end
    local lfTime
    if cp.emission.rateOverTime.constant <= 0 then
      lfTime = cp.main.startDelay.constant + cp.main.startLifetime.constant
    else
      lfTime = cp.main.startDelay.constant + math.max(cp.main.startLifetime.constant, cp.main.duration)
    end
    if subLife < lfTime then
      subLife = lfTime
    end
  end
  return subLife
end

function EffectAudioPostCtrl:PostStartEvent()
  if self.audioPlayedEvent ~= "" and self.container.gameObject.activeInHierarchy then
    AudioManager.Instance:PostSoundEvent(self.audioPlayedEvent)
  end
end

return EffectAudioPostCtrl
