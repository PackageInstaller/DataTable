_class("HighFrequencyDamageCalculator", Object)
HighFrequencyDamageCalculator = HighFrequencyDamageCalculator

function HighFrequencyDamageCalculator:Constructor(world)
  self._world = world
end

function HighFrequencyDamageCalculator:Calculate(casterEntity, effectParam)
  local skillEffectResultContainer = casterEntity:SkillContext():GetResultContainer()
  local skillID = skillEffectResultContainer:GetSkillID()
  local scopeResult = skillEffectResultContainer:GetScopeResult()
  local targetIDs = scopeResult:GetTargetIDs()
  local utilScope = self._world:GetService("UtilScopeCalc")
  local v2CasterGridPos = casterEntity:GetGridPosition()
  local tTargetDistanceInfo = utilScope:GetEntityDistanceInfoArray(targetIDs, v2CasterGridPos)
  local effectCalcSvc = self._world:GetService("SkillEffectCalc")
  local tDamageResults = {}
  local sMonsterShowLogic = self._world:GetService("MonsterShowLogic")
  local deadMonsterEntities = {}
  local triggerSvc = self._world:GetService("Trigger")
  local finalAttackIndex = 0
  local damageStageIndex = effectParam:GetSkillEffectDamageStageIndex()
  local attackTimes = effectParam:GetMaxAttackTimes()
  local extraAttackCount, addPiecePosList = self:_CalExtraAttackCount(effectParam, casterEntity)
  attackTimes = attackTimes + extraAttackCount
  for i = 1, attackTimes do
    if #tTargetDistanceInfo == 0 then
      break
    end
    local targetDistanceInfo = tTargetDistanceInfo[1]
    local eTarget = targetDistanceInfo.entity
    local nt = NTBeforeHighFrequencyDamageHit:New(casterEntity, i)
    triggerSvc:Notify(nt)
    local nTotalDamage, listDamageInfo = effectCalcSvc:ComputeSkillDamage(casterEntity, v2CasterGridPos, eTarget, targetDistanceInfo.gridPos, skillID, effectParam, SkillEffectType.Damage, damageStageIndex)
    local skillResult = effectCalcSvc:NewSkillDamageEffectResult(targetDistanceInfo.gridPos, targetDistanceInfo.targetID, nTotalDamage, listDamageInfo, damageStageIndex)
    table.insert(tDamageResults, skillResult)
    local currentHP = eTarget:Attributes():GetCurrentHP()
    if currentHP <= 0 then
      table.remove(tTargetDistanceInfo, 1)
      sMonsterShowLogic:AddMonsterDeadMark(eTarget)
    end
    local ntAfter = NTAfterHighFrequencyDamageHit:New(casterEntity, i)
    triggerSvc:Notify(ntAfter)
  end
  local result = SkillEffectHighFrequencyDamageResult:New(tDamageResults)
  local skillEffectResultContainer = casterEntity:SkillContext():GetResultContainer()
  skillEffectResultContainer:AddEffectResult(result)
  if 0 < #tDamageResults and effectParam:IsTractionOnLastTarget() then
    local lastDamageResult = tDamageResults[#tDamageResults]
    local targetID = lastDamageResult:GetTargetID()
    local targetEntity = self._world:GetEntityByID(targetID)
    local tractionParam = SkillEffectMultiTractionParam:New(effectParam._paramList)
    local tractionCalc = SkillEffectCalc_MultiTraction:New(self._world)
    local tractionResult = tractionCalc:DoSkillEffectCalculator(SkillEffectCalcParam:New(casterEntity:GetID(), {targetID}, tractionParam, skillID, scopeResult:GetAttackRange(), targetEntity:GetGridPosition(), targetEntity:GetGridPosition()))
    skillEffectResultContainer:AddEffectResult(tractionResult)
    if tractionResult then
      local executor = SkillEffectLogicExecutor:New(self._world)
      executor:ApplySkillEffect(casterEntity, tractionParam, {tractionResult})
    end
  end
  if 0 < #tDamageResults and effectParam:GetLastTargetBuffID() then
    local lastDamageResult = tDamageResults[#tDamageResults]
    local targetID = lastDamageResult:GetTargetID()
    local targetEntity = self._world:GetEntityByID(targetID)
    local buffID = effectParam:GetLastTargetBuffID()
    local addBuffParam = SkillAddBuffEffectParam:New({prob = 1, buffID = buffID})
    local addBuffCalc = SkillEffectCalc_AddBuff:New(self._world)
    local addBuffResult = addBuffCalc:DoSkillEffectCalculator(SkillEffectCalcParam:New(casterEntity:GetID(), {targetID}, addBuffParam, skillID, scopeResult:GetAttackRange(), targetEntity:GetGridPosition(), targetEntity:GetGridPosition()))
    if addBuffResult and 0 < #addBuffResult then
      for _, r in ipairs(addBuffResult) do
        skillEffectResultContainer:AddEffectResult(r)
      end
      local executor = SkillEffectLogicExecutor:New(self._world)
      executor:ApplySkillEffect(casterEntity, addBuffParam, addBuffResult)
    end
  end
  local btsvc = self._world:GetService("Battle")
  if btsvc:IsFinalAttack() then
    result:SetFinalAttackIndex(#tDamageResults)
  end
  return result
end

function HighFrequencyDamageCalculator:_CalExtraAttackCount(param, attacker)
  local serialScopeType = param:GetSerialScopeType()
  if not serialScopeType then
    return 0, {}
  end
  local radius = param:GetRadius()
  local posCaster = attacker:GetGridPosition()
  local casterBodyArea = attacker:BodyArea():GetArea()
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local scopeCalculator = utilScopeSvc:GetSkillScopeCalc()
  local scopeResult = scopeCalculator:ComputeScopeRange(serialScopeType, {
    [1] = radius,
    [2] = 0
  }, posCaster, casterBodyArea)
  local board = self._world:GetBoardEntity():Board()
  local extraAttackCount = 0
  local boardService = self._world:GetService("BoardRender")
  local pieceType = param:GetPieceType()
  local addPiecePosList = {}
  if scopeResult then
    local array = scopeResult:GetAttackRange()
    for _, v in ipairs(array) do
      local pt = board:GetPieceType(v)
      if pt == pieceType then
        extraAttackCount = extraAttackCount + 1
        table.insert(addPiecePosList, v)
      end
    end
  end
  local onPieceAddAttackCount = param:GetOnePieceAddAttackCount()
  extraAttackCount = extraAttackCount * onPieceAddAttackCount
  return extraAttackCount, addPiecePosList
end
