require("play_skill_phase_base_r")
_class("PlaySkillNormalAttackWithMovePhase", PlaySkillPhaseBase)
PlaySkillNormalAttackWithMovePhase = PlaySkillNormalAttackWithMovePhase

function PlaySkillNormalAttackWithMovePhase:PlayFlight(TT, casterEntity, phaseParam)
  local attackAnimParam = phaseParam
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local skillID = skillEffectResultContainer:GetSkillID()
  local targetResultAll = skillEffectResultContainer:GetEffectResultByArrayAll(SkillEffectType.TransferTarget)
  local targetResult = targetResultAll[1]
  local damagePos = targetResult:GetTargetGridPos()
  local beAttackEntityID = targetResult:GetTargetEntityID()
  local targetEntity = self._world:GetEntityByID(beAttackEntityID)
  if targetEntity then
    local boardServiceRender = self._world:GetService("BoardRender")
    local gridRenderPos = boardServiceRender:GridPos2RenderPos(damagePos)
    local resvc = self._world:GetService("RenderEntity")
    resvc:TurnToTarget(casterEntity, targetEntity, nil, gridRenderPos)
  end
  local isLastNormalAttack = skillEffectResultContainer:IsLastNormalAttackAtOnGrid()
  local attackAnimName = attackAnimParam:GetAnimationName(isLastNormalAttack)
  if attackAnimName then
    casterEntity:SetAnimatorControllerTriggers({attackAnimName})
  end
  local attackEffectID = attackAnimParam:GetCastEffectID()
  if attackEffectID and 0 < attackEffectID then
    local atkEffectDelay = attackAnimParam:GetHitEffectDelay(isLastNormalAttack)
    GameGlobal.TaskManager():CoreGameStartTask(function()
      if atkEffectDelay ~= 0 then
        YIELD(TT, atkEffectDelay)
      end
      local effectSvc = self._world:GetService("Effect")
      local e = casterEntity
      if "target" == effectSvc:GetEffectHolder(attackEffectID) then
        e = targetEntity
      end
      if e then
        effectSvc:CreateEffect(attackEffectID, e)
      end
    end)
  end
  local hitPointDelay = attackAnimParam:GetHitPointDelay(isLastNormalAttack) or 0
  if 0 < hitPointDelay then
    YIELD(TT, hitPointDelay)
  end
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local normalAtkResultCmpt = renderBoardEntity:LogicResult():GetLogicResult(LogicStepType.NormalAttack)
  local attackPos = casterEntity:GetRenderGridPosition()
  local curNormalSkill = normalAtkResultCmpt:GetNormalSkillSequenceWithAttackGridData(skillID, damagePos, attackPos)
  if curNormalSkill then
    local timeService = self._world:GetService("Time")
    local afterWaitTime = timeService:GetCurrentTimeMs()
    normalAtkResultCmpt:SetCurPlayNormalSkillPlayStartTime(curNormalSkill.order, afterWaitTime)
  end
  local playBuffSvc = self._world:GetService("PlayBuff")
  playBuffSvc:_OnAttackStart(TT, skillID, casterEntity, targetEntity, attackPos, damagePos, nil)
  local playSkillService = self._world:GetService("PlaySkill")
  local nt = NTNormalAttackCalcEnd:New(casterEntity, targetEntity, attackPos, damagePos)
  nt:SetSkillID(skillID)
  nt:SetSkillType(SkillType.Normal)
  self._world:GetService("PlayBuff"):PlayBuffView(TT, nt)
  local oriBeAttackPos = skillEffectResultContainer:GetNormalAttackBeAttackOriPos()
  if oriBeAttackPos then
    local nt1 = NTNormalAttackCalcEndUseOriPos:New(casterEntity, targetEntity, attackPos, oriBeAttackPos)
    nt1:SetSkillID(skillID)
    nt1:SetSkillType(SkillType.Normal)
    self._world:GetService("PlayBuff"):PlayBuffView(TT, nt1)
  end
  local playBuffSvc = self._world:GetService("PlayBuff")
  playBuffSvc:_OnAttackEnd(TT, skillID, casterEntity, targetEntity, attackPos, damagePos, nil)
  local castTotalTime = attackAnimParam:GetCastTotalTime(isLastNormalAttack)
  local remainTime = castTotalTime - hitPointDelay
  YIELD(TT, remainTime)
end
