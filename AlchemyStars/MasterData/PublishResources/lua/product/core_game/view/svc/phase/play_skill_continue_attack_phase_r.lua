require("play_skill_phase_base_r")
_class("PlaySkillContinueAttackPhase", PlaySkillPhaseBase)
PlaySkillContinueAttackPhase = PlaySkillContinueAttackPhase

function PlaySkillContinueAttackPhase:PrepareToPlay(TT, casterEntity, phaseParam)
  self._hasPlayedAnim = false
end

function PlaySkillContinueAttackPhase:PlayFlight(TT, casterEntity, phaseParam)
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local damageResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.Damage)
  if damageResultArray == nil then
    return
  end
  local damageResCount = #damageResultArray
  local startIndex = phaseParam:GetStartIndex()
  local lastIndex = damageResCount - phaseParam:GetLastStartIndex() + 1
  if startIndex > lastIndex then
    return
  end
  while startIndex <= lastIndex do
    local damageResult = damageResultArray[startIndex]
    local targetEntityID = damageResult:GetTargetID()
    local world = casterEntity:GetOwnerWorld()
    local targetEntity = world:GetEntityByID(targetEntityID)
    local playSkillService = world:GetService("PlaySkill")
    local resvc = world:GetService("RenderEntity")
    resvc:TurnToTarget(casterEntity, targetEntity)
    AudioHelperController.PlayInnerGameSfx(phaseParam:GetAudioId())
    if not self._hasPlayedAnim then
      casterEntity:SetAnimatorControllerTriggers({
        phaseParam:GetAnimName()
      })
      self._hasPlayedAnim = true
    end
    YIELD(TT, phaseParam:GetWaitEffectTime())
    local tran = casterEntity:View():GetGameObject().transform
    local renderPos = tran:TransformPoint(Vector3(phaseParam:GetEffectOffsetX(), phaseParam:GetEffectOffsetY(), phaseParam:GetEffectOffsetZ()))
    local effectEntity = world:GetService("Effect"):CreatePositionEffect(phaseParam:GetEffectId(), renderPos)
    local go = targetEntity:View():GetGameObject()
    local targetPos = go.transform.position
    local dir = targetPos - renderPos
    effectEntity:SetDirection(dir)
    YIELD(TT, phaseParam:GetWaitBulletEffectTime())
    local taskID = GameGlobal.TaskManager():CoreGameStartTask(function(TT)
      self:_CreateBullet(TT, casterEntity, phaseParam, damageResult, startIndex == damageResCount, startIndex)
    end)
    YIELD(TT, phaseParam:GetWaitAnimTime())
    startIndex = startIndex + 1
  end
end

function PlaySkillContinueAttackPhase:_CreateBullet(TT, casterEntity, phaseParam, damageResult, isFinalDamage, damageIndex)
  local world = casterEntity:GetOwnerWorld()
  local targetEntityID = damageResult:GetTargetID()
  local targetEntity = world:GetEntityByID(targetEntityID)
  local tran = casterEntity:View():GetGameObject().transform
  local castPos = tran:TransformPoint(Vector3(phaseParam:GetBulletEffectOffsetX(), phaseParam:GetBulletEffectOffsetY(), phaseParam:GetBulletEffectOffsetZ()))
  local targetPos = targetEntity:Location().Position
  local dir = targetPos - castPos
  local effectEntity = world:GetService("Effect"):CreatePositionEffect(phaseParam:GetBulletEffectId(), castPos)
  effectEntity:SetDirection(dir)
  local distance = Vector3.Distance(castPos, targetPos)
  local flyTime = distance * phaseParam:GetBulletFlySpeed()
  YIELD(TT)
  local go = effectEntity:View():GetGameObject()
  local dotween
  local flyTrace = phaseParam:GetBulletFlyTrace()
  if flyTrace == FlyEffectTraceType.LineTrace then
    dotween = go.transform:DOMove(targetPos, flyTime / 1000.0, false)
  elseif flyTrace == FlyEffectTraceType.JumpTrace then
    local jumpPower = math.sqrt(distance)
    dotween = go.transform:DOJump(targetPos, jumpPower, 1, flyTime / 1000.0, false)
  elseif flyTrace == FlyEffectTraceType.ScaleTrace then
    go.transform.localScale = Vector3(1, 1, distance)
    flyTime = phaseParam:GetBulletFlySpeed()
  elseif flyTrace == FlyEffectTraceType.TimeScaleTrace then
    dotween = go.transform:DOScaleZ(distance, flyTime / 1000.0)
  end
  if dotween then
    dotween:SetEase(DG.Tweening.Ease.InOutSine):OnComplete(function()
      go:SetActive(false)
      world:DestroyEntity(effectEntity)
    end)
  end
  YIELD(TT, flyTime)
  if not dotween then
    world:DestroyEntity(effectEntity)
  end
  YIELD(TT, phaseParam:GetWaitHitTime())
  local playSkillService = world:GetService("PlaySkill")
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local skillID = skillEffectResultContainer:GetSkillID()
  local damageInfo = damageResult:GetDamageInfo(1)
  local damageGridPos = damageResult:GetGridPos()
  local playFinalAttack = false
  if skillEffectResultContainer:IsFinalAttack() and isFinalDamage then
    playFinalAttack = true
  end
  local beHitParam = HandleBeHitParam:New():SetHandleBeHitParam_CasterEntity(casterEntity):SetHandleBeHitParam_TargetEntity(targetEntity):SetHandleBeHitParam_HitAnimName(phaseParam:GetHitAnimName()):SetHandleBeHitParam_HitEffectID(phaseParam:GetHitEffectId()):SetHandleBeHitParam_DamageInfo(damageInfo):SetHandleBeHitParam_DamagePos(damageGridPos):SetHandleBeHitParam_HitTurnTarget(phaseParam:GetTurnToTarget()):SetHandleBeHitParam_DeathClear(phaseParam:GetDeathClear()):SetHandleBeHitParam_IsFinalHit(playFinalAttack):SetHandleBeHitParam_SkillID(skillID):SetHandleBeHitParam_DamageIndex(damageIndex)
  playSkillService:HandleBeHit(TT, beHitParam)
end
