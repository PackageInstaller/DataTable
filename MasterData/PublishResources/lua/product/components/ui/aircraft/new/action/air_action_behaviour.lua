_class("AirActionBehaviour", AirActionBase)
AirActionBehaviour = AirActionBehaviour

function AirActionBehaviour:Constructor(fur, pet, cfgID, duration, isInit)
  self._furniture = fur
  self._pet = pet
  self._duration = duration
  local cfg = Cfg.cfg_aircraft_pet_action[cfgID]
  if not cfg then
    Log.exception("[Behaviour] 找不到行为ID：", cfgID)
  end
  self._state = AirPetFurState.None
  self._fadeInTl = nil
  self._fadeOutTl = nil
  self._loopCfg = nil
  self._loopTl = nil
  self._fadeInEndTime = 0
  self._fadeOutStartTime = duration
  if self:_petHasExtraAnim(cfg) then
    local req = ResourceManager:GetInstance():SyncLoadAsset(self._pet:SkinID() .. "_aircraft_extra.prefab", LoadType.GameObject)
    if req == nil then
      Log.exception("[Behaviour] 找不到星灵特殊动作prefab，配置id:", cfg.ID, "，星灵id:", self._pet:SkinID())
    end
    local go = req.Obj
    local anim = go:GetComponent(typeof(UnityEngine.Animation))
    self._extraReq = req
    self._pet:SetExtraAnim(anim)
  end
  if self._furniture:HasExtraAnim() then
    local req = ResourceManager:GetInstance():SyncLoadAsset(self._furniture:CfgID() .. "_" .. self._pet:SkinID() .. ".prefab", LoadType.GameObject)
    if req == nil then
      Log.exception("[Behaviour] 家具有特殊动作但找不到对应prefab，配置id:", cfg.ID, "，目标名称:", self._furniture:CfgID() .. "_" .. self._pet:SkinID() .. ".prefab")
    end
    local go = req.Obj
    local anim = go:GetComponent(typeof(UnityEngine.Animation))
    self._furExtraAnim = anim
    self._furExtraReq = req
    if anim == nil then
      Log.exception("家具额外动作没有Animation组件:", self._furniture:CfgID() .. "_" .. self._pet:SkinID())
    end
    if self._furniture:Animation() == nil then
      Log.exception("家具没有Animation组件:", self._furniture:CfgID())
    end
    HelperProxy:GetInstance():AddAnimTo(anim, self._furniture:Animation())
  end
  local fadeIn = cfg.In
  local loop = cfg.Loop
  local fadeOut = cfg.Out
  if not fadeIn and not loop and not fadeOut then
    Log.exception("[Behaviour] 找不到可播放的动画：", cfgID)
  end
  if fadeIn then
    local fadeInItem = self:_getItemByWeight(fadeIn)
    self._fadeInEndTime = fadeInItem.dur
    self._fadeInTl = AirPetFurTimeline:New(fur, pet, fadeInItem, 0)
  end
  if fadeOut then
    local fadeOutItem = self:_getItemByWeight(fadeOut)
    self._fadeOutStartTime = duration - fadeOutItem.dur
    self._fadeOutTl = AirPetFurTimeline:New(fur, pet, fadeOutItem, self._fadeOutStartTime)
  end
  if loop then
    self._loopCfg = loop
  end
  self._isInit = isInit
end

function AirActionBehaviour:_petHasExtraAnim(cfg)
  if cfg.fadeIn then
    for _, c in pairs(cfg.fadeIn) do
      if self:_isExtro(c.pAnim) then
        return true
      end
    end
  end
  if cfg.Loop then
    for _, c in pairs(cfg.Loop) do
      if self:_isExtro(c.pAnim) then
        return true
      end
    end
  end
  if cfg.fadeOut then
    for _, c in pairs(cfg.fadeOut) do
      if self:_isExtro(c.pAnim) then
        return true
      end
    end
  end
  return false
end

function AirActionBehaviour:_furHasExtraAnim(cfg)
  if cfg.fadeIn then
    for _, c in pairs(cfg.fadeIn) do
      if c.fAnim then
        return true
      end
    end
  end
  if cfg.Loop then
    for _, c in pairs(cfg.Loop) do
      if c.fAnim then
        return true
      end
    end
  end
  if cfg.fadeOut then
    for _, c in pairs(cfg.fadeOut) do
      if c.fAnim then
        return true
      end
    end
  end
  return false
end

function AirActionBehaviour:_isExtro(name)
  if name and (name == AirPetAnimName.Stand or name == AirPetAnimName.Walk or name == AirPetAnimName.Click or name == AirPetAnimName.Sit) then
    return false
  end
  return true
end

function AirActionBehaviour:_getItemByWeight(t)
  local total = 0
  for _, item in ipairs(t) do
    total = total + item.weight
  end
  local r = math.random(1, total)
  local temp = 0
  for _, item in ipairs(t) do
    temp = temp + item.weight
    if r <= temp then
      return item
    end
  end
end

function AirActionBehaviour:_startLoopTl(startTime)
  if self._loopCfg then
    local cfg = self:_getItemByWeight(self._loopCfg)
    self._loopTl = AirPetFurTimeline:New(self._furniture, self._pet, cfg, startTime, self._isInit)
    self._loopTl:Start()
  end
end

function AirActionBehaviour:Start()
  self._curTime = 0
  self._index = 1
  self._running = true
  if self._fadeInTl then
    self._fadeInTl:Start()
  end
  self._state = AirPetFurState.FadeIn
end

function AirActionBehaviour:Update(deltaTimeMS)
  if self._running then
    self._curTime = self._curTime + deltaTimeMS
    if self._curTime >= self._duration then
      self._running = false
      self:Stop()
    elseif self._state == AirPetFurState.FadeIn then
      if self._curTime > self._fadeInEndTime then
        if self._fadeInTl then
          self._fadeInTl:Dispose()
        end
        self:_startLoopTl(self._fadeInEndTime)
        self._state = AirPetFurState.Idle
      end
    elseif self._state == AirPetFurState.Idle then
      if self._curTime > self._fadeOutStartTime then
        if self._loopTl then
          self._loopTl:Dispose()
        end
        if self._fadeOutTl then
          self._fadeOutTl:Start()
        end
        self._state = AirPetFurState.FadeOut
      elseif self._loopTl then
        if self._curTime > self._loopTl:EndTime() then
          local startTime = self._loopTl:EndTime()
          self._loopTl:Dispose()
          self:_startLoopTl(startTime)
        end
      else
        self._state = AirPetFurState.FadeOut
      end
    elseif self._state == AirPetFurState.FadeOut then
      if self._curTime > self._duration then
        if self._fadeOutTl then
          self._fadeOutTl:Dispose()
        end
        self._state = AirPetFurState.None
      end
    elseif self._state == AirPetFurState.None then
    end
  end
end

function AirActionBehaviour:IsOver()
  return not self._running
end

function AirActionBehaviour:Stop()
  if self._running then
    self._running = false
    if self._state == AirPetFurState.FadeIn then
      if self._fadeInTl then
        self._fadeInTl:Dispose()
      end
    elseif self._state == AirPetFurState.Idle then
      if self._loopTl then
        self._loopTl:Dispose()
      end
    elseif self._state == AirPetFurState.FadeOut and self._fadeOutTl then
      self._fadeOutTl:Dispose()
    end
  end
end

function AirActionBehaviour:Dispose()
  if self._extraReq then
    self._pet:SetExtraAnim(nil)
    self._pet = nil
    self._extraReq:Dispose()
    self._extraReq = nil
  end
  if self._furExtraReq then
    HelperProxy:GetInstance():RemoveAnimTo(self._furExtraAnim, self._furniture:Animation())
    self._furExtraReq:Dispose()
    self._furExtraReq = nil
    self._furExtraAnim = nil
  end
end

_class("AirPetFurTimeline", Object)
AirPetFurTimeline = AirPetFurTimeline

function AirPetFurTimeline:Constructor(fur, pet, cfg, startTime, isSerializedAction)
  self._fur = fur
  self._pet = pet
  self._petAnim = cfg.pAnim
  self._petEff = cfg.pEff
  self._furAnim = cfg.fAnim
  self._furEff = cfg.fEff
  self._holder = cfg.holder
  local duration = cfg.dur
  if duration then
    self._endTime = startTime + duration
  else
    self._endTime = 99999999999
  end
  self._isInit = isSerializedAction
end

function AirPetFurTimeline:Start()
  local disposed = false
  local reqs = {}
  if self._petAnim then
    if self._petAnim == "Sit" then
      if self._isInit then
        self._pet:Anim_CrossFade(AirPetAnimName.Sit, 0)
      else
        self._pet:Anim_Sit()
      end
    elseif self._isInit then
      self._pet:Anim_CrossFade(self._petAnim, 0)
    else
      self._pet:Anim_CrossFade(self._petAnim)
    end
  end
  
  local function loadEff(name, parent)
    local req = ResourceManager:GetInstance():SyncLoadAsset(name .. ".prefab", LoadType.GameObject)
    if not req then
      Log.exception("[Behaviour] 找不到特效资源：", name)
    end
    local go = req.Obj
    local t = go.transform
    t.position = parent.position
    t.rotation = parent.rotation
    go:SetActive(true)
    reqs[#reqs + 1] = req
    return go
  end
  
  local function loadEffOnHolder(name, parent)
    if not parent then
      return
    end
    local req = ResourceManager:GetInstance():SyncLoadAsset(name .. ".prefab", LoadType.GameObject)
    if not req then
      Log.exception("[Behaviour] 找不到特效资源：", name)
    end
    local go = req.Obj
    local t = go.transform
    t:SetParent(parent, false)
    t.localPosition = Vector3.zero
    t.localEulerAngles = Vector3.zero
    go:SetActive(true)
    reqs[#reqs + 1] = req
    return go
  end
  
  if self._petEff then
    local go
    if self._holder then
      local parent = GameObjectHelper.FindChild(self._pet:Transform(), self._holder)
      if parent then
        go = loadEffOnHolder(self._petEff, parent)
      else
        go = loadEff(self._petEff, self._pet:Transform())
      end
    else
      go = loadEff(self._petEff, self._pet:Transform())
    end
    GameObjectHelper.SetGameObjectLayer(go, AircraftLayer.Pet)
  end
  if self._furAnim then
    self._fur:Anim_Play(self._furAnim)
  end
  if self._furEff then
    if not self._fur:EffectSlot() then
      Log.exception("[Behaviour] 家具没有特效挂点：", self._fur:CfgID())
    end
    loadEff(self._furEff, self._fur:EffectSlot())
  end
  self._reqs = reqs
end

function AirPetFurTimeline:EndTime()
  return self._endTime
end

function AirPetFurTimeline:Dispose()
  if self.disposed then
    Log.exception("该片段已被析构", debug.traceback())
    return
  end
  if self._petAnim then
    self._pet:Anim_Stop()
  end
  if self._furAnim then
    self._fur:Anim_Stop()
  end
  self.disposed = true
  for _, req in ipairs(self._reqs) do
    req:Dispose()
  end
end
