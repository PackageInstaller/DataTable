require("homelandpet_component_base")
_class("HomelandPetComponentExtraAnimation", HomelandPetComponentBase)
HomelandPetComponentExtraAnimation = HomelandPetComponentExtraAnimation

function HomelandPetComponentExtraAnimation:Constructor(componentType, pet, behavior)
  HomelandPetComponentExtraAnimation.super.Constructor(self, componentType, pet, behavior)
  self._animation = self._pet:GetAnimation()
  self._petExtraAnimationCfg = nil
  self._petEffectReqs = {}
  self._petEffectObj = {}
end

function HomelandPetComponentExtraAnimation:ReLoadPetComponent()
  self._animation = self._pet:GetAnimation()
end

function HomelandPetComponentExtraAnimation:Init()
end

function HomelandPetComponentExtraAnimation:FishingManager()
  if not self._fishingManager then
    local homeLandModule = GameGlobal.GetUIModule(HomelandModule)
    local homelandClient = homeLandModule:GetClient()
    self._fishingManager = homelandClient:FishingManager()
  end
  return self._fishingManager
end

function HomelandPetComponentExtraAnimation:OnExcute()
  if self.state == HomelandPetComponentState.Resting then
    if not self._petExtraAnimationCfg then
      return
    end
    if not self._animation then
      self._animation = self._pet:GetAnimation()
    end
    self._pet:SetBipObstacleEnabled(true)
    self.state = HomelandPetComponentState.Running
  end
end

function HomelandPetComponentExtraAnimation:Exit()
  local preState = self.state
  HomelandPetComponentExtraAnimation.super.Exit(self)
  self._pet:SetBipObstacleEnabled(false)
  self._petExtraAnimationCfg = nil
  for _, _req in pairs(self._petEffectReqs) do
    _req:Dispose()
  end
  table.clear(self._petEffectReqs)
  table.clear(self._petEffectObj)
  self:DestroyFishTools()
  self:_DestroyAnimTask()
end

function HomelandPetComponentExtraAnimation:Dispose()
  HomelandPetComponentExtraAnimation.super.Dispose()
end

function HomelandPetComponentExtraAnimation:PlayAnimation(cfgId, nextCfgId)
  local data = self:_GetData(cfgId)
  local anim = data and data.anim
  local nextData = self:_GetData(nextCfgId)
  local nextAnim = nextData and nextData.anim
  if data then
    self:_PlayAnimation(anim, nextAnim)
  end
end

function HomelandPetComponentExtraAnimation:PlayEffect(cfgId, show)
  local data = self:_GetData(cfgId)
  if data then
    if show then
      self:_PlayEffect(data.peff, data.pholder, data.panim)
    else
      self:_StopEffect(data.peff)
    end
  end
end

function HomelandPetComponentExtraAnimation:GetEffect(cfgId)
  local data = self:_GetData(cfgId)
  if data and data.peff then
    return self._petEffectObj[data.peff]
  end
end

function HomelandPetComponentExtraAnimation:StopAllEffect()
  for _, gameObject in pairs(self._petEffectObj) do
    gameObject:SetActive(false)
    self:_PlayEffectAnimation(gameObject)
  end
end

function HomelandPetComponentExtraAnimation:_GetData(cfgId)
  self._petExtraAnimationCfg = Cfg.cfg_homeland_pet_extra_animation[cfgId]
  local info = self._petExtraAnimationCfg and self._petExtraAnimationCfg.Anim
  local data = self:_RandomAnimationAndEffect(info)
  return data
end

function HomelandPetComponentExtraAnimation:_RandomAnimationAndEffect(info)
  if not info then
    return nil
  end
  if table.count(info) <= 1 then
    return info[1]
  end
  local totalWeight = 0
  local weightArray = {}
  for key, value in pairs(info) do
    if value.weight then
      weightArray[key] = {
        totalWeight,
        value.weight
      }
      totalWeight = totalWeight + value.weight
    end
  end
  local randomWeight = math.random(1, totalWeight)
  for key, value in pairs(weightArray) do
    if randomWeight > value[1] and randomWeight <= value[2] then
      return info[key]
    end
  end
end

function HomelandPetComponentExtraAnimation:_PlayAnimation(animName, nextAnimName)
  self._animation = self._animation or self._pet:GetAnimation()
  if self._animation then
    self._pet:LoadExtraAnimation()
    self:_PlayAnimationOnce(animName, nextAnimName)
  end
end

function HomelandPetComponentExtraAnimation:_PlayAnimationOnce(animName, nextAnimName)
  self:_DestroyAnimTask()
  self._animation:Play(animName)
  if not nextAnimName then
    return
  end
  local state = self._animation:get_Item(animName)
  if state then
    local length = state.clip.length * 1000
    self:_DestroyAnimTask()
    self._animTask = TaskManager:GetInstance():StartTask(function(TT)
      YIELD(TT, length)
      self._animation:Play(nextAnimName)
    end)
  end
end

function HomelandPetComponentExtraAnimation:_DestroyAnimTask()
  if self._animTask then
    GameGlobal.TaskManager():KillTask(self._animTask)
    self._animTask = nil
  end
end

function HomelandPetComponentExtraAnimation:_PlayEffect(peff, pholder, anim)
  if peff and not self._petEffectReqs[peff] then
    local bone = self._pet:GetBoneNode(pholder)
    local req = ResourceManager:GetInstance():SyncLoadAsset(peff .. ".prefab", LoadType.GameObject)
    if req and req.Obj then
      local effect = req.Obj
      effect.transform:SetParent(bone)
      effect.transform.localPosition = Vector3.zero
      effect.transform.localRotation = Quaternion.Euler(0, 0, 0)
      self._petEffectReqs[peff] = req
      self._petEffectObj[peff] = req.Obj
      self:_LoadPetExtraAnimation(effect)
    end
  end
  if self._petEffectObj[peff] then
    self._petEffectObj[peff]:SetActive(true)
    self:_PlayEffectAnimation(self._petEffectObj[peff], anim)
  end
end

function HomelandPetComponentExtraAnimation:_StopEffect(peff)
  if peff and self._petEffectObj[peff] then
    self._petEffectObj[peff]:SetActive(false)
    self:_PlayEffectAnimation(self._petEffectObj[peff])
  end
end

function HomelandPetComponentExtraAnimation:_PlayEffectAnimation(obj, animName)
  local animation = obj:GetComponentInChildren(typeof(UnityEngine.Animation))
  if animation then
    animation:Play(animName)
  end
end

function HomelandPetComponentExtraAnimation:_LoadPetExtraAnimation(obj)
  local animation = obj:GetComponentInChildren(typeof(UnityEngine.Animation))
  if animation then
    local extra = self._pet:GetExtraAnimation()
    HelperProxy:GetInstance():AddAnimTo(extra, animation)
  end
end

function HomelandPetComponentExtraAnimation:StartFishTools(cfgId, delay)
  delay = delay or 0
  self._startTask = GameGlobal.TaskManager():StartTask(function(TT)
    YIELD(TT, delay)
    local fishRodgo = self:GetEffect(cfgId)
    local fishLine = fishRodgo and fishRodgo.transform:Find("Line"):GetComponent("LineRenderer")
    local fishLineFirstPointTran = fishRodgo and fishRodgo.transform:Find("hl_tool_5012001_1/Dummy001/Bone0001/Bone002/Bone003/Bone004/Bone005/Bone006/Bone007")
    self:FishingManager():StartFishTools(self._pet, fishLine, fishLineFirstPointTran)
  end)
end

function HomelandPetComponentExtraAnimation:StopFishTools(delay)
  delay = delay or 0
  self._stopTask = GameGlobal.TaskManager():StartTask(function(TT)
    YIELD(TT, delay)
    self:FishingManager():StopFishTools()
  end)
end

function HomelandPetComponentExtraAnimation:DestroyFishTools()
  if self._startTask then
    GameGlobal.TaskManager():KillTask(self._startTask)
    self._startTask = nil
  end
  if self._stopTask then
    GameGlobal.TaskManager():KillTask(self._stopTask)
    self._stopTask = nil
  end
  self:FishingManager():DestroyFishTools()
end
