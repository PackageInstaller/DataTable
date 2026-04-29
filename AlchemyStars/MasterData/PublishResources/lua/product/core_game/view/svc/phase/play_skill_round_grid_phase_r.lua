require("play_skill_phase_base_r")
_class("PlaySkillRoundGridPhase", PlaySkillPhaseBase)
PlaySkillRoundGridPhase = PlaySkillRoundGridPhase

function PlaySkillRoundGridPhase:PlayFlight(TT, casterEntity, phaseParam)
  local RoundGridParam = phaseParam
  local gridEffectDelayTime = RoundGridParam:GetGridEffectDelayTime()
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local skillID = skillEffectResultContainer:GetSkillID()
  local scope = skillEffectResultContainer:GetScopeResult()
  local results = skillEffectResultContainer:GetEffectResultsAsPosDic(SkillEffectType.Damage)
  local gridRange = scope:GetAttackRange()
  local playSkillService = self._world:GetService("PlaySkill")
  local attackAnimName = RoundGridParam:GetAnimationName()
  casterEntity:SetAnimatorControllerTriggers({attackAnimName})
  local attackEffectID = RoundGridParam:GetCastEffectID()
  self._world:GetService("Effect"):CreateEffect(attackEffectID, casterEntity)
  local casterPos = casterEntity:GridLocation().Position
  YIELD(TT, gridEffectDelayTime)
  local hitAnimName = RoundGridParam:GetHitAnimationName()
  local hitEffectID = RoundGridParam:GetHitEffectID()
  local isFinalAttack = skillEffectResultContainer:IsFinalAttack()
  if isFinalAttack then
    self:SkillService():FreezeFrame(true)
  end
  for i, gridPos in ipairs(gridRange) do
    local gridEffectID = RoundGridParam:GetGridEffectID(casterPos, gridPos)
    if gridEffectID then
      self._world:GetService("Effect"):CreateWorldPositionEffect(gridEffectID, gridPos)
    end
    local res = results[Vector2.Pos2Index(gridPos)]
    if res then
      local targetEntityID = res:GetTargetID()
      if targetEntityID ~= -1 then
        local targetEntity = self._world:GetEntityByID(targetEntityID)
        local targetDamage = res:GetDamageInfo(1)
        local beHitParam = HandleBeHitParam:New():SetHandleBeHitParam_CasterEntity(casterEntity):SetHandleBeHitParam_TargetEntity(targetEntity):SetHandleBeHitParam_HitAnimName(hitAnimName):SetHandleBeHitParam_HitEffectID(hitEffectID):SetHandleBeHitParam_DamageInfo(targetDamage):SetHandleBeHitParam_DamagePos(gridPos):SetHandleBeHitParam_HitTurnTarget(phaseParam:HitTurnToTarget()):SetHandleBeHitParam_DeathClear(false):SetHandleBeHitParam_IsFinalHit(false):SetHandleBeHitParam_SkillID(skillID)
        playSkillService:HandleBeHit(TT, beHitParam)
      end
    end
  end
  local finishDelayTime = RoundGridParam:GetFinishDelayTime()
  YIELD(TT, finishDelayTime)
end
