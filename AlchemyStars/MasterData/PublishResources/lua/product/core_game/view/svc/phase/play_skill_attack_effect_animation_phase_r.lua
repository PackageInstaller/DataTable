require("play_skill_phase_base_r")
_class("PlaySkillAttackEffectAnimationPhase", PlaySkillPhaseBase)
PlaySkillAttackEffectAnimationPhase = PlaySkillAttackEffectAnimationPhase

function PlaySkillAttackEffectAnimationPhase:PlayFlight(TT, casterEntity, phaseParam)
  local attackAnimParam = phaseParam
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local isFinalAttack = skillEffectResultContainer:IsFinalAttack()
  local attackAnimName = attackAnimParam:GetAnimationName()
  if attackAnimName then
    casterEntity:SetAnimatorControllerTriggers({attackAnimName})
    casterEntity:SetAnimatorControllerBools({Move = false})
  end
  local attackEffectID = attackAnimParam:GetCastEffectID()
  if attackEffectID then
    local effectSvc = self._world:GetService("Effect")
    if "target" ~= effectSvc:GetEffectHolder(attackEffectID) then
      local e = casterEntity
      effectSvc:CreateEffect(attackEffectID, e)
    end
  end
  local skillID = skillEffectResultContainer:GetSkillID()
  local taskidArray = {}
  local index = 1
  while true do
    local damageResult = skillEffectResultContainer:GetEffectResultByArray(SkillEffectType.Damage, index)
    if not damageResult then
      break
    end
    local castDamage = damageResult:GetDamageInfo(1)
    local beAttackEntityID = damageResult:GetTargetID()
    local targetEntity = self._world:GetEntityByID(beAttackEntityID)
    local curDeadTaskID = GameGlobal.TaskManager():CoreGameStartTask(self.PlayOneAttack, self, casterEntity, targetEntity, attackAnimParam, castDamage, isFinalAttack, damageResult:GetGridPos(), skillID)
    table.insert(taskidArray, curDeadTaskID)
    index = index + 1
  end
  JOIN_TASK_ARRAY(TT, taskidArray)
end

function PlaySkillAttackEffectAnimationPhase:PlayOneAttack(TT, casterEntity, targetEntity, attackAnimParam, damage, isFinalAttack, damageTextPos, skillID)
  local resvc = self._world:GetService("RenderEntity")
  resvc:TurnToTarget(casterEntity, targetEntity)
  local hitPointDelay = attackAnimParam:GetHitPointDelay()
  if 0 < hitPointDelay then
    YIELD(TT, hitPointDelay)
  end
  if targetEntity ~= nil then
    local hitAnimName = attackAnimParam:GetHitAnimation()
    local hitEffectID = attackAnimParam:GetHitEffectID()
    local beHitParam = HandleBeHitParam:New():SetHandleBeHitParam_CasterEntity(casterEntity):SetHandleBeHitParam_TargetEntity(targetEntity):SetHandleBeHitParam_HitAnimName(hitAnimName):SetHandleBeHitParam_HitEffectID(hitEffectID):SetHandleBeHitParam_DamageInfo(damage):SetHandleBeHitParam_DamagePos(damageTextPos):SetHandleBeHitParam_HitTurnTarget(attackAnimParam:HitTurnToTarget()):SetHandleBeHitParam_DeathClear(false):SetHandleBeHitParam_IsFinalHit(isFinalAttack):SetHandleBeHitParam_SkillID(skillID)
    self:SkillService():HandleBeHit(TT, beHitParam)
  end
  local castTotalTime = attackAnimParam:GetCastTotalTime()
  local remainTime = castTotalTime - hitPointDelay
  YIELD(TT, remainTime)
  if isFinalAttack == true then
    YIELD(TT, BattleConst.FreezeDuration)
  end
end
