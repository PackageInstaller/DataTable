require("play_skill_phase_base_r")
_class("PlaySkillAOEDamagePhase", PlaySkillPhaseBase)
PlaySkillAOEDamagePhase = PlaySkillAOEDamagePhase

function PlaySkillAOEDamagePhase:PlayFlight(TT, casterEntity, phaseParam)
  local aoeDamageParam = phaseParam
  local castEffectID = aoeDamageParam:GetSkillCastEffectID()
  local intervalTime = aoeDamageParam:GetSkillAOEInterval()
  local hitPointDelay = aoeDamageParam:GetSkillHitPointDelay()
  local hitEffectID = aoeDamageParam:GetSkillHitEffectID()
  local hitAnimName = aoeDamageParam:GetSkillHitAnimName()
  local hitTurn2Target = true
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local skillID = skillEffectResultContainer:GetSkillID()
  local isFinalAttack = skillEffectResultContainer:IsFinalAttack()
  local castIndex = 1
  local damageArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.Damage)
  if damageArray == nil then
    return
  end
  local resvc = self._world:GetService("RenderEntity")
  local castCount = #damageArray
  for k, v in pairs(damageArray) do
    local damageResult = v
    local damageTargetID = damageResult:GetTargetID()
    local damageTargetEntity = self._world:GetEntityByID(damageTargetID)
    local damage = damageResult:GetDamageInfo(1)
    local damagePos = damageResult:GetGridPos()
    resvc:TurnToTarget(casterEntity, damageTargetEntity)
    YIELD(TT, hitPointDelay)
    local curHitIsFinalAttack = false
    if isFinalAttack == true and castIndex == castCount then
      curHitIsFinalAttack = true
    end
    local beHitParam = HandleBeHitParam:New():SetHandleBeHitParam_CasterEntity(casterEntity):SetHandleBeHitParam_TargetEntity(damageTargetEntity):SetHandleBeHitParam_HitAnimName(hitAnimName):SetHandleBeHitParam_HitEffectID(hitEffectID):SetHandleBeHitParam_DamageInfo(damage):SetHandleBeHitParam_DamagePos(damagePos):SetHandleBeHitParam_HitTurnTarget(hitTurn2Target):SetHandleBeHitParam_DeathClear(false):SetHandleBeHitParam_IsFinalHit(curHitIsFinalAttack):SetHandleBeHitParam_SkillID(skillID)
    self:SkillService():HandleBeHit(TT, beHitParam)
    YIELD(TT, intervalTime)
  end
end
