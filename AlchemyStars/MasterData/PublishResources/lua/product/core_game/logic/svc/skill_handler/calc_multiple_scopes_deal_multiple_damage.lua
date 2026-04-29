_class("SkillEffectCalc_MultipleScopesDealMultipleDamage", Object)
SkillEffectCalc_MultipleScopesDealMultipleDamage = SkillEffectCalc_MultipleScopesDealMultipleDamage

function SkillEffectCalc_MultipleScopesDealMultipleDamage:Constructor(world)
  self._world = world
  self._skillEffectService = self._world:GetService("SkillEffectCalc")
end

function SkillEffectCalc_MultipleScopesDealMultipleDamage:DoSkillEffectCalculator(skillEffectCalcParam)
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

function SkillEffectCalc_MultipleScopesDealMultipleDamage:_CalculateSingleTarget(skillEffectCalcParam, defenderEntityID)
  local skillDamageParam = skillEffectCalcParam.skillEffectParam
  local defender = self._world:GetEntityByID(defenderEntityID)
  if defender == nil then
    Log.notice("CalculationForeachTarget defender is null ", defenderEntityID)
    local skillResult = self._skillEffectService:NewSkillDamageEffectResult(nil, -1, 0, nil, nil)
    return {skillResult}
  end
  local formulaService = self._world:GetService("Formula")
  local attacker = self._world:GetEntityByID(skillEffectCalcParam.casterEntityID)
  local attackPos = skillEffectCalcParam.attackPos
  local damageStageIndex = skillDamageParam:GetSkillEffectDamageStageIndex()
  local bodyAreaPosList = {}
  local bodyArea = defender:BodyArea():GetArea()
  local cneterPos = defender:GetGridPosition()
  for _, area in ipairs(bodyArea) do
    local workPos = area + cneterPos
    table.insert(bodyAreaPosList, workPos)
  end
  local gridPosList = {}
  for i = 1, #skillEffectCalcParam.skillRange do
    local skillRangePos = skillEffectCalcParam.skillRange[i]
    if table.intable(bodyAreaPosList, skillRangePos) then
      table.insert(gridPosList, skillRangePos)
    end
  end
  local curSkillDamageIndex = 1
  local skillResultList = {}
  for i = 1, #gridPosList do
    local gridPos = gridPosList[i]
    local nTotalDamage, listDamageInfo = self._skillEffectService:ComputeSkillDamage(attacker, attackPos, defender, gridPos, skillEffectCalcParam.skillID, skillDamageParam, SkillEffectType.Damage, damageStageIndex, nil, curSkillDamageIndex, gridPos)
    local damageInfo = listDamageInfo[1]
    if damageInfo then
      damageInfo:SetCurSkillDamageIndex(curSkillDamageIndex)
    end
    local skillResult = self._skillEffectService:NewSkillDamageEffectResult(gridPos, defenderEntityID, nTotalDamage, listDamageInfo, damageStageIndex)
    table.insert(skillResultList, skillResult)
    curSkillDamageIndex = curSkillDamageIndex + 1
  end
  return skillResultList
end
