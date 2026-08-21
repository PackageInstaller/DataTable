require("base_ins_r")
_class("PlayTargetBeHitAnimationInstruction", BaseInstruction)
PlayTargetBeHitAnimationInstruction = PlayTargetBeHitAnimationInstruction

function PlayTargetBeHitAnimationInstruction:Constructor(paramList)
  self._hitAnimName = paramList.hitAnimName
end

function PlayTargetBeHitAnimationInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local playSkillService = world:GetService("PlaySkill")
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local curDamageIndex = phaseContext:GetCurDamageResultIndex()
  local curDamageInfoIndex = phaseContext:GetCurDamageInfoIndex()
  local curDamageResultStageIndex = phaseContext:GetCurDamageResultStageIndex()
  local damageResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.Damage, curDamageResultStageIndex)
  local damageResult = damageResultArray[curDamageIndex]
  local damageInfo = damageResult:GetDamageInfo(curDamageInfoIndex)
  if not damageInfo then
    Log.fatal("### PlayTargetBeHitAnimation DamageInfo is nil. curDamageIndex, curDamageInfoIndex=", curDamageIndex, curDamageInfoIndex)
    return
  end
  local skillID = skillEffectResultContainer:GetSkillID()
  local targetEntityID = phaseContext:GetCurTargetEntityID()
  local targetEntity = world:GetEntityByID(targetEntityID)
  local damageResultStageCount = skillEffectResultContainer:GetEffectResultsStageCount(SkillEffectType.Damage)
  if skillEffectResultContainer:IsFinalAttack() and curDamageIndex == #damageResultArray and curDamageResultStageIndex == damageResultStageCount then
    playSkillService:FreezeFrame(targetEntity)
  end
  if not targetEntity then
    Log.fatal("TargetEntity is nil  SkillID:", skillID, "TargetID:", targetEntityID)
    return
  end
  local guard = damageInfo:GetDamageType() == DamageType.Guard
  local miss = damageInfo:GetDamageType() == DamageType.Miss
  if not guard and not miss and self._hitAnimName and not damageInfo:IsHPShieldGuard() then
    targetEntity:SetAnimatorControllerTriggers({
      self._hitAnimName
    })
  end
  local result = skillEffectResultContainer:GetEffectResultByTargetID(SkillEffectType.HitBack, targetEntity:GetID())
  local processHitTaskID
  if result then
    local hitbackCalcType = result:GetCalcType()
    if hitbackCalcType and hitbackCalcType == HitBackCalcType.Instant then
      processHitTaskID = playSkillService:ProcessHit(casterEntity, targetEntity, result, 10)
    end
  end
  if processHitTaskID ~= nil then
    phaseContext:AddPhaseTask(processHitTaskID)
  end
  local scopeResult = damageResult:GetSkillEffectScopeResult()
  local attackPos = casterEntity:GetRenderGridPosition()
  local beAttackPos = damageResult:GetGridPos()
  local playBuffSvc = world:GetService("PlayBuff")
  playBuffSvc:_OnAttackEnd(TT, skillID, casterEntity, targetEntity, attackPos, beAttackPos, damageInfo)
  playSkillService:PlayHitTrap(TT, casterEntity, targetEntity)
end
