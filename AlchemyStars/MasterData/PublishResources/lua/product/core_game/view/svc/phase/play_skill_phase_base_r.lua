_class("PlaySkillPhaseBase", Object)
PlaySkillPhaseBase = PlaySkillPhaseBase

function PlaySkillPhaseBase:Constructor(skillService, world)
  self._skillService = skillService
  self._world = world
  self._startTick = GameGlobal:GetInstance():GetCurrentTime()
  self._configService = self._world:GetService("Config")
  self._timeService = self._world:GetService("Time")
  self._effectService = self._world:GetService("Effect")
end

function PlaySkillPhaseBase:PrepareToPlay(TT, casterEntity, phaseParam)
end

function PlaySkillPhaseBase:BeginPlay(TT, casterEntity, firstPhaseParam)
  self._startTick = GameGlobal:GetInstance():GetCurrentTime()
end

function PlaySkillPhaseBase:PlayFlight(TT, casterEntity, phaseParam)
end

function PlaySkillPhaseBase:EndPlay(TT, casterEntity, phaseParam)
end

function PlaySkillPhaseBase:_GetElapseTick()
  return math.floor(GameGlobal:GetInstance():GetCurrentTime() - self._startTick)
end

function PlaySkillPhaseBase:SkillService()
  return self._skillService
end

function PlaySkillPhaseBase:_DelayTime(TT, nTime)
  if nTime and 0 < nTime then
    YIELD(TT, nTime)
  end
end

function PlaySkillPhaseBase:_GetEntityBasePos(entityWork)
  local posTarget
  if nil == entityWork then
    return posTarget
  end
  return entityWork:GetGridPosition()
end

function PlaySkillPhaseBase:_GetEntityCenterPos(entityWork)
  local posTarget
  if nil == entityWork then
    return posTarget
  end
  return entityWork:GetDamageCenter()
end

function PlaySkillPhaseBase:_GetEntityBasePosByID(nEntityID)
  local entityWork = self._world:GetEntityByID(nEntityID)
  return self:_GetEntityBasePos(entityWork)
end

function PlaySkillPhaseBase:_PlayEffect(TT, posCast, posTarget, gridEffectID, nEffectDelayTime, fxNoRotation)
  if nil == gridEffectID or gridEffectID <= 0 then
    return
  end
  local effectService = self._world:GetService("Effect")
  local posDirectory = posTarget - posCast
  if fxNoRotation then
    posDirectory = Vector2.zero
  end
  effectService:CreateWorldPositionDirectionEffect(gridEffectID, posTarget, posDirectory)
  self:_DelayTime(TT, nEffectDelayTime)
end

function PlaySkillPhaseBase:_PlayAnimationEffect(TT, casterEntity, stAnimationName, nEffectID, nEffectTime)
  if stAnimationName and "" ~= stAnimationName then
    casterEntity:SetAnimatorControllerTriggers({stAnimationName})
    Log.debug("[Animation]: 播放动画[" .. stAnimationName .. "]")
  end
  if nEffectID then
    local effectService = self._world:GetService("Effect")
    local listEffectID = {}
    if type(nEffectID) == "number" then
      if 0 < nEffectID then
        listEffectID[#listEffectID + 1] = nEffectID
      end
    elseif type(nEffectID) == "table" then
      listEffectID = nEffectID
    end
    for i = 1, #listEffectID do
      effectService:CreateEffect(listEffectID[i], casterEntity)
    end
  end
  self:_DelayTime(TT, nEffectTime)
end

function PlaySkillPhaseBase:_WaitSonTask(listTask)
  if table.count(listTask) > 0 then
    while not TaskHelper:GetInstance():IsAllTaskFinished(listTask) do
      YIELD(TT)
    end
  end
end

function PlaySkillPhaseBase:_MakePosString(posWork)
  return GameHelper.MakePosString(posWork)
end
