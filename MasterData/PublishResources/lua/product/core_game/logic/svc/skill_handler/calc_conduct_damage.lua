require("calc_base")
_class("SkillEffectCalc_ConductDamage", SkillEffectCalc_Base)
SkillEffectCalc_ConductDamage = SkillEffectCalc_ConductDamage

function SkillEffectCalc_ConductDamage:DoSkillEffectCalculator(skillEffectCalcParam)
  local tResultArray = {}
  local teidTarget = skillEffectCalcParam:GetTargetEntityIDs()
  for _, targetID in ipairs(teidTarget) do
    local results = self:CalculateOnSingleTarget(skillEffectCalcParam, targetID)
    table.appendArray(tResultArray, results)
  end
  return tResultArray
end

function SkillEffectCalc_ConductDamage:CalculateOnSingleTarget(calcParam, targetID)
  local effectParam = calcParam.skillEffectParam
  local attacker = self._world:GetEntityByID(calcParam.casterEntityID)
  local tConductResult = {}
  local cSkillContext = attacker:SkillContext()
  local resultContainer = cSkillContext:GetResultContainer()
  local tDamageResultArray = resultContainer:GetEffectResultByArrayAll(SkillEffectType.Damage)
  for damageIndex, damageResult in ipairs(tDamageResultArray) do
    if damageResult:GetTargetID() == targetID then
      table.insert(tConductResult, self:CalculateResult(calcParam, attacker, damageIndex, damageResult))
    end
  end
  return tConductResult
end

function SkillEffectCalc_ConductDamage:CalculateResult(calcParam, attacker, damageIndex, damageResult)
  local targetID = damageResult:GetTargetID()
  local scopeResult = self:CalcConductScope(calcParam, targetID)
  local targetPosIdRecordList = scopeResult:GetGridPosTargetIDRecordList()
  local targetIDs = scopeResult:GetTargetIDs()
  local effectParam = calcParam.skillEffectParam
  local tConductRate = effectParam:GetConductRateList()
  local conductResult = SkillEffectConductDamageResult:New(damageIndex, targetID)
  local cSkillContext = attacker:SkillContext()
  local effectCalcSvc = self._world:GetService("SkillEffectCalc")
  local conductCount = 0
  for _, targetID in ipairs(targetIDs) do
    if conductCount > #tConductRate then
      break
    end
    conductCount = conductCount + 1
    local fConductRate = tConductRate[conductCount]
    if not fConductRate then
      break
    end
    local gridPos
    local defender = self._world:GetEntityByID(targetID)
    if targetPosIdRecordList then
      for index, value in ipairs(targetPosIdRecordList) do
        local record = value
        if table.icontains(record.idList, targetID) then
          gridPos = record.recordPos
          break
        end
      end
    end
    if not gridPos then
      break
    end
    local damageStageIndex = effectParam:GetSkillEffectDamageStageIndex()
    cSkillContext:SetConductBaseDamage(damageResult:GetTotalDamage())
    cSkillContext:SetCurrentConductRate(fConductRate)
    local damageParam = SkillDamageEffectParam:New({
      percent = {fConductRate},
      formulaID = effectParam:GetFormulaID(),
      damageStageIndex = effectParam:GetSkillEffectDamageStageIndex()
    })
    local nTotalDamage, listDamageInfo = effectCalcSvc:ComputeSkillDamage(attacker, calcParam.attackPos, defender, gridPos, calcParam.skillID, damageParam, SkillEffectType.ConductDamage, effectParam:GetSkillEffectDamageStageIndex())
    local damageEffectResult = effectCalcSvc:NewSkillDamageEffectResult(gridPos, targetID, nTotalDamage, listDamageInfo, damageStageIndex)
    conductResult:CreateAtomData(conductCount, damageEffectResult)
  end
  return conductResult
end

function SkillEffectCalc_ConductDamage:CalcConductScope(calcParam, conductCenterEntityID)
  local effectParam = calcParam.skillEffectParam
  local attacker = self._world:GetEntityByID(calcParam.casterEntityID)
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local calcScope = utilScopeSvc:GetSkillScopeCalc()
  local lastHitpoint = calcParam.gridPos
  local scopeType = effectParam:GetConductScopeType()
  local scopeParam = effectParam:GetConductScopeParam()
  local parser = SkillScopeParamParser:New()
  scopeParam = parser:ParseScopeParam(scopeType, scopeParam)
  local casterBodyArea = attacker:BodyArea():GetArea()
  local casterDirection = attacker:GetGridDirection()
  local targetType = effectParam:GetConductTargetType()
  local scopeResult = calcScope:ComputeScopeRange(scopeType, scopeParam, lastHitpoint, casterBodyArea, casterDirection, targetType, lastHitpoint)
  local selector = SkillScopeTargetSelector:New(self._world)
  local targetArray = selector:DoSelectSkillTarget(attacker, targetType, scopeResult)
  local rangeMap = {}
  local tv2AttackRange = scopeResult:GetAttackRange()
  for _, v2 in ipairs(tv2AttackRange) do
    local index = v2:Pos2Index()
    rangeMap[index] = true
  end
  for _, targetID in ipairs(targetArray) do
    if targetID ~= conductCenterEntityID then
      local entity = self._world:GetEntityByID(targetID)
      if entity and entity:HasBodyArea() then
        local v2GridPos = entity:GetGridPosition()
        local cBodyArea = entity:BodyArea()
        local tv2BodyArea = cBodyArea:GetArea()
        for _, v2AreaPos in ipairs(tv2BodyArea) do
          local v2AbsAreaPos = v2AreaPos + v2GridPos
          local index = v2AbsAreaPos:Pos2Index()
          if rangeMap[index] then
            scopeResult:AddTargetIDAndPos(targetID, v2AbsAreaPos)
            scopeResult:AddTargetIDAndPosAllowDuplicate(targetID, v2AbsAreaPos)
            break
          end
        end
      end
    end
  end
  return scopeResult
end
