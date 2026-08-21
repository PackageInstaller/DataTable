require("play_skill_phase_base_r")
_class("PlaySkillAttackAnimationPhase", PlaySkillPhaseBase)
PlaySkillAttackAnimationPhase = PlaySkillAttackAnimationPhase

function PlaySkillAttackAnimationPhase:PlayFlight(TT, casterEntity, phaseParam)
  local attackAnimParam = phaseParam
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local skillID = skillEffectResultContainer:GetSkillID()
  local isFinalAttack = skillEffectResultContainer:IsFinalAttack()
  local damageResultAll = {}
  local skillStageIndex = attackAnimParam:GetSkillStageIndex()
  if skillStageIndex then
    damageResultAll = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.Damage, skillStageIndex)
  else
    damageResultAll = skillEffectResultContainer:GetEffectResultByArrayAll(SkillEffectType.Damage)
  end
  if not damageResultAll then
    return
  end
  local targetEntityList = {}
  local castDamageList = {}
  local damagePosList = {}
  self._normalAttackDoubleIndex = 0
  self._normalAttackIndex = nil
  for i = 1, #damageResultAll do
    local damageResult = damageResultAll[i]
    local castDamage = damageResult:GetDamageInfo(attackAnimParam:GetDamageIndex())
    local damagePos = damageResult:GetGridPos()
    local beAttackEntityID = damageResult:GetTargetID()
    local targetEntity = self._world:GetEntityByID(beAttackEntityID)
    if targetEntity then
      if damageResult:GetNormalAttackDouble() == true then
        self._normalAttackDoubleIndex = i
      end
      if damageResult:GetNormalAttackIndex() then
        self._normalAttackIndex = damageResult:GetNormalAttackIndex()
        castDamage:SetNormalAttackIndex(self._normalAttackIndex)
      end
      table.insert(targetEntityList, targetEntity)
      table.insert(castDamageList, castDamage)
      table.insert(damagePosList, damagePos)
    end
  end
  self:_PlayAttack(TT, casterEntity, targetEntityList, attackAnimParam, castDamageList, isFinalAttack, skillID, damagePosList, skillEffectResultContainer)
end

function PlaySkillAttackAnimationPhase:_PlayAttack(TT, casterEntity, targetEntityList, attackAnimParam, damageList, isFinalAttack, skillID, damagePosList, skillEffectResultContainer)
  local targetEntity = targetEntityList[1]
  if targetEntity then
    local skillService = self:SkillService()
    local boardServiceRender = self._world:GetService("BoardRender")
    local gridRenderPos = boardServiceRender:GridPos2RenderPos(damagePosList[1])
    local resvc = self._world:GetService("RenderEntity")
    resvc:TurnToTarget(casterEntity, targetEntity, nil, gridRenderPos)
  end
  local isSlantAttack
  local attackPos = casterEntity:GetRenderGridPosition()
  if damagePosList[1] and attackPos.x ~= damagePosList[1].x and attackPos.y ~= damagePosList[1].y and attackAnimParam:GetSlantCastEffectID() then
    isSlantAttack = true
  end
  local isLastNormalAttack = skillEffectResultContainer:IsLastNormalAttackAtOnGrid()
  local attackAnimName = attackAnimParam:GetAnimationName(isLastNormalAttack, isSlantAttack)
  if attackAnimName then
    if attackAnimParam:IsUsePermanentEffectPlayAnim() then
      local rootName = attackAnimParam:GetPermanentEffSpecialAnimRoot()
      self:_PermanentEffectPlayAnim(casterEntity, attackAnimName, rootName)
    else
      casterEntity:SetAnimatorControllerTriggers({attackAnimName})
    end
  end
  local attackEffectID = attackAnimParam:GetCastEffectID(isSlantAttack)
  if attackEffectID and 0 < attackEffectID then
    local atkEffectDelay = attackAnimParam:GetHitEffectDelay(isLastNormalAttack, isSlantAttack)
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
  local hitPointDelay = attackAnimParam:GetHitPointDelay(isLastNormalAttack, isSlantAttack) or 0
  local hitPointDelaySecond = attackAnimParam:GetHitPointDelaySecond(isLastNormalAttack) or 0
  if 0 < hitPointDelay then
    YIELD(TT, hitPointDelay)
  end
  local resultAddComboNum = {}
  if casterEntity:HasPetPstID() then
    resultAddComboNum = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.AddComboNum) or {}
  end
  local oriBeAttackPos = skillEffectResultContainer:GetNormalAttackBeAttackOriPos()
  for i = 1, #targetEntityList do
    local targetEntity = targetEntityList[i]
    local damagePos = damagePosList[i]
    local damage = damageList[i]
    local isAddCombo = false
    if i == 1 or 0 < table.count(resultAddComboNum) or self._normalAttackDoubleIndex == i then
      isAddCombo = true
    end
    local curIsFinalAttack = isFinalAttack and i == #targetEntityList
    local taskid = GameGlobal.TaskManager():CoreGameStartTask(function(TT)
      if i ~= 1 and i ~= 3 and hitPointDelaySecond ~= 0 then
        YIELD(TT, hitPointDelaySecond - hitPointDelay)
      end
      self:_WaitPlayHandleBeHit(TT, casterEntity, targetEntity, attackAnimParam, isSlantAttack, damage, damagePos, curIsFinalAttack, skillID, isAddCombo, oriBeAttackPos)
    end)
  end
  local castTotalTime = attackAnimParam:GetCastTotalTime(isLastNormalAttack)
  local remainTime = castTotalTime - hitPointDelay
  YIELD(TT, remainTime)
  if isFinalAttack == true then
    YIELD(TT, BattleConst.FreezeDuration)
  end
end

function PlaySkillAttackAnimationPhase:_WaitPlayHandleBeHit(TT, casterEntity, targetEntity, attackAnimParam, isSlantAttack, damage, damagePos, isFinalAttack, skillID, isAddCombo, oriBeAttackPos)
  if casterEntity:HasPetPstID() then
    local renderBoardEntity = self._world:GetRenderBoardEntity()
    local normalAtkResultCmpt = renderBoardEntity:LogicResult():GetLogicResult(LogicStepType.NormalAttack)
    local attackPos = casterEntity:GetRenderGridPosition()
    local curNormalSkill = normalAtkResultCmpt:GetNormalSkillSequenceWithAttackGridData(skillID, damagePos, attackPos)
    if curNormalSkill then
      local timeService = self._world:GetService("Time")
      local preNormalSkill = normalAtkResultCmpt:GetNormalSkillSequenceWithOrder(curNormalSkill.order - 1)
      local beforeWaitTime = timeService:GetCurrentTimeMs()
      local preDamageValue = 0
      local preDamageResult
      if preNormalSkill then
        preDamageResult = preNormalSkill.attackGridData:GetEffectResultByArrayAll(SkillEffectType.Damage)
        if preDamageResult then
          local preDamageResultLast = preDamageResult[#preDamageResult]
          local preDamageInfo = preDamageResultLast:GetDamageInfo(attackAnimParam:GetDamageIndex())
          preDamageValue = preDamageInfo:GetDamageValue()
        else
          preDamageResult = preNormalSkill.attackGridData:GetEffectResultByArrayAll(SkillEffectType.AddBlood)
          if preDamageResult then
            local preDamageResultLast = preDamageResult[#preDamageResult]
            local preDamageInfo = preDamageResultLast:GetDamageInfo(attackAnimParam:GetDamageIndex())
            preDamageValue = preDamageInfo:GetDamageValue()
          end
        end
      end
      while curNormalSkill.order > 1 and preNormalSkill.playStartTime == 0 and preDamageValue == 0 and preDamageResult do
        YIELD(TT)
        preNormalSkill = normalAtkResultCmpt:GetNormalSkillSequenceWithOrder(curNormalSkill.order - 1)
      end
      local afterWaitTime = timeService:GetCurrentTimeMs()
      normalAtkResultCmpt:SetCurPlayNormalSkillPlayStartTime(curNormalSkill.order, afterWaitTime)
    end
    if isAddCombo then
      local renderBattleSvc = self._world:GetService("RenderBattle")
      local curComboNum = renderBattleSvc:GetComboNum()
      curComboNum = curComboNum + 1
      renderBattleSvc:SetComboNum(curComboNum)
      local nt = NTNormalAttackCalcEnd:New(casterEntity, targetEntity, attackPos, damagePos)
      nt:SetSkillID(skillID)
      nt:SetSkillType(SkillType.Normal)
      nt:SetNormalAttackIndex(self._normalAttackIndex)
      self._world:GetService("PlayBuff"):PlayBuffView(TT, nt)
      if oriBeAttackPos then
        local nt1 = NTNormalAttackCalcEndUseOriPos:New(casterEntity, targetEntity, attackPos, oriBeAttackPos)
        nt1:SetSkillID(skillID)
        nt1:SetSkillType(SkillType.Normal)
        nt1:SetNormalAttackIndex(self._normalAttackIndex)
        self._world:GetService("PlayBuff"):PlayBuffView(TT, nt1)
      end
    end
  else
    isFinalAttack = false
  end
  local hitAnimName = attackAnimParam:GetHitAnimation()
  local hitEffectID = attackAnimParam:GetHitEffectID(isSlantAttack)
  local hitTurn2Target = attackAnimParam:HitTurnToTarget()
  local beHitParam = HandleBeHitParam:New():SetHandleBeHitParam_CasterEntity(casterEntity):SetHandleBeHitParam_TargetEntity(targetEntity):SetHandleBeHitParam_HitAnimName(hitAnimName):SetHandleBeHitParam_HitEffectID(hitEffectID):SetHandleBeHitParam_DamageInfo(damage):SetHandleBeHitParam_DamagePos(damagePos):SetHandleBeHitParam_HitTurnTarget(hitTurn2Target):SetHandleBeHitParam_DeathClear(false):SetHandleBeHitParam_IsFinalHit(isFinalAttack):SetHandleBeHitParam_SkillID(skillID)
  self:SkillService():HandleBeHit(TT, beHitParam)
end

function PlaySkillAttackAnimationPhase:_PermanentEffectPlayAnim(casterEntity, animName, rootName)
  local effectHolderCmpt = casterEntity:EffectHolder()
  if effectHolderCmpt then
    local renderBattle = self._world:GetService("RenderBattle")
    local permanentEffectList = effectHolderCmpt:GetPermanentEffect()
    for index, effectID in ipairs(permanentEffectList) do
      local effectEntity = self._world:GetEntityByID(effectID)
      if effectEntity then
        if rootName then
          effectEntity:SetSpecialAnimRoot(rootName)
        end
        effectEntity:SetAnimatorControllerTriggers({animName})
      end
    end
  end
end
