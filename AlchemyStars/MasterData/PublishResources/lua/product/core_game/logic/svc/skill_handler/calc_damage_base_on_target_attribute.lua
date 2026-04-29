require("calc_base")
_class("SkillEffectCalc_DamageBasedOnTargetAttribute", SkillEffectCalc_Base)
SkillEffectCalc_DamageBasedOnTargetAttribute = SkillEffectCalc_DamageBasedOnTargetAttribute

function SkillEffectCalc_DamageBasedOnTargetAttribute:Constructor(world)
  self._world = world
  self._skillEffectService = self._world:GetService("SkillEffectCalc")
end

function SkillEffectCalc_DamageBasedOnTargetAttribute:DoSkillEffectCalculator(skillEffectCalcParam)
  local results = {}
  local targets = skillEffectCalcParam:GetTargetEntityIDs()
  for _, targetID in ipairs(targets) do
    local result = self:_CalculateSingleTarget(skillEffectCalcParam, targetID)
    if result then
      table.appendArray(results, result)
    end
  end
  return results
end

function SkillEffectCalc_DamageBasedOnTargetAttribute:_OnGetCompareAttribute(attacker, defender, entityTag, attribute, param)
  local entity
  if entityTag == "SkillTarget" then
    entity = defender
  elseif entityTag == "Self" then
    entity = attacker
  else
    Log.notice("_OnGetCompareAttribute entity is null.  entityTag =", entityTag)
  end
  if attribute == "MaxHP" then
    local maxHP = entity:Attributes():CalcMaxHp()
    maxHP = math.floor(maxHP * param)
    return maxHP
  end
  local entityAttribute = entity:Attributes():GetAttribute(attribute)
  entityAttribute = math.floor(entityAttribute * param)
  return entityAttribute
end

function SkillEffectCalc_DamageBasedOnTargetAttribute:_CalculateSingleTarget(skillEffectCalcParam, defenderEntityID)
  local skillDamageParam = skillEffectCalcParam.skillEffectParam
  local defender = self._world:GetEntityByID(defenderEntityID)
  if defender == nil then
    Log.notice("CalculationForeachTarget defender is null ", defenderEntityID)
    local skillResult = self._skillEffectService:NewSkillDamageEffectResult(nil, -1, 0, nil, nil)
    return {skillResult}
  end
  local attacker = self._world:GetEntityByID(skillEffectCalcParam.casterEntityID)
  local targetTag = skillDamageParam:GetTarget()
  local argetAttribute = skillDamageParam:GetTargetAttribute()
  local compareTag = skillDamageParam:GetCompare()
  local compareAttribute = skillDamageParam:GetCompareAttribute()
  local compareParam = skillDamageParam:GetCompareParam()
  local targetAttribute = self:_OnGetCompareAttribute(attacker, defender, targetTag, argetAttribute, 1)
  local compareAttribute = self:_OnGetCompareAttribute(attacker, defender, compareTag, compareAttribute, compareParam)
  local compareSymbol = skillDamageParam:GetCompareSymbol()
  local satisfied = false
  if compareSymbol == ComparisonOperator.EQ then
    satisfied = targetAttribute == compareAttribute
  elseif compareSymbol == ComparisonOperator.NE then
    satisfied = targetAttribute ~= compareAttribute
  elseif compareSymbol == ComparisonOperator.GT then
    satisfied = targetAttribute > compareAttribute
  elseif compareSymbol == ComparisonOperator.GE then
    satisfied = targetAttribute >= compareAttribute
  elseif compareSymbol == ComparisonOperator.LT then
    satisfied = targetAttribute < compareAttribute
  elseif compareSymbol == ComparisonOperator.LE then
    satisfied = targetAttribute <= compareAttribute
  end
  if not satisfied then
    return
  end
  local ownerBuffEffect = skillDamageParam:GetOwnerBuffEffect()
  if ownerBuffEffect and not attacker:BuffComponent():HasBuffEffect(ownerBuffEffect) then
    return
  end
  local damageStageIndex = skillDamageParam:GetSkillEffectDamageStageIndex()
  local preDamageStageIndex = skillDamageParam:GetPreDamageStageIndex()
  if preDamageStageIndex then
    local skillEffectResultContainer = attacker:SkillContext():GetResultContainer()
    local damageResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.Damage, preDamageStageIndex)
    if not damageResultArray or table.count(damageResultArray) == 0 then
      return
    end
    local defenderDamageResult
    for _, v in ipairs(damageResultArray) do
      local damageResult = v
      local targetEntityID = damageResult:GetTargetID()
      if targetEntityID == defenderEntityID then
        defenderDamageResult = damageResult
        break
      end
    end
    if not defenderDamageResult then
      return
    end
  end
  if skillEffectCalcParam.skillRange == nil then
    skillEffectCalcParam.skillRange = {
      skillEffectCalcParam.gridPos
    }
  end
  local formulaService = self._world:GetService("Formula")
  local attackPos = skillEffectCalcParam.attackPos
  local gridPos = skillEffectCalcParam.gridPos
  local damageStageIndex = skillDamageParam:GetSkillEffectDamageStageIndex()
  local effectCalcSvc = self._skillEffectService
  local nTotalDamage, listDamageInfo = effectCalcSvc:ComputeSkillDamage(attacker, attackPos, defender, gridPos, skillEffectCalcParam.skillID, skillDamageParam, SkillEffectType.Damage, damageStageIndex)
  local skillResult = effectCalcSvc:NewSkillDamageEffectResult(gridPos, defenderEntityID, nTotalDamage, listDamageInfo, damageStageIndex)
  local skillResultList = {}
  table.insert(skillResultList, skillResult)
  return skillResultList
end
