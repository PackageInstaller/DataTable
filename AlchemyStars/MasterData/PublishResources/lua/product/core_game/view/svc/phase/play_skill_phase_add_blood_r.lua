require("play_skill_phase_base_r")
_class("PlaySkillPhase_AddBlood", PlaySkillPhaseBase)
PlaySkillPhase_AddBlood = PlaySkillPhase_AddBlood

function PlaySkillPhase_AddBlood:Constructor()
end

function PlaySkillPhase_AddBlood:PlayFlight(TT, casterEntity, phaseParam)
  self:_PlayFlightAll(TT, casterEntity, phaseParam)
  self:_DelayTime(TT, phaseParam:GetShowTimeDelay())
end

function PlaySkillPhase_AddBlood:_PlayFlightAll(TT, casterEntity, paramWork)
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local skillResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.AddBlood)
  if nil == skillResultArray then
    Log.error("加血表现里，给[", casterEntity:GetID(), "]加血时没有找到逻辑数据")
    return
  end
  local posCast = self:_GetEntityBasePos(casterEntity)
  local nIntervalTime = paramWork:GetGridIntervalTime()
  for i = 1, #skillResultArray do
    local skillResult = skillResultArray[i]
    local nTargetID = skillResult:GetTargetID()
    local nAddValue = skillResult:GetAddValue()
    local damageInfo = skillResult:GetDamageInfo()
    local targetEntity = self._world:GetEntityByID(nTargetID)
    GameGlobal.TaskManager():CoreGameStartTask(self._PlayFlightOne, self, casterEntity, targetEntity, paramWork:GetGridEffectID(), paramWork:GetGridEffectDelayTime(), damageInfo)
    self:_DelayTime(TT, nIntervalTime)
  end
end

function PlaySkillPhase_AddBlood:_PlayFlightOne(TT, casterEntity, entityWork, nEffectID, nEffectTime, damageInfo)
  local posCast = self:_GetEntityBasePos(casterEntity)
  local posTarget = entityWork:GetDamageCenter()
  self:_PlayEffect(TT, posCast, posTarget, nEffectID, nEffectTime)
  if entityWork then
    local playDamageService = self._world:GetService("PlayDamage")
    damageInfo:SetShowType(DamageShowType.Single)
    playDamageService:AsyncUpdateHPAndDisplayDamage(entityWork, damageInfo)
  end
end
