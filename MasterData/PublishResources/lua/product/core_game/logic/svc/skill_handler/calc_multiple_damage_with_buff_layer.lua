_class("SkillEffectCalc_MultipleDamageWithBuffLayer", Object)
SkillEffectCalc_MultipleDamageWithBuffLayer = SkillEffectCalc_MultipleDamageWithBuffLayer

function SkillEffectCalc_MultipleDamageWithBuffLayer:Constructor(world)
  self._world = world
  self._skillEffectService = self._world:GetService("SkillEffectCalc")
end

function SkillEffectCalc_MultipleDamageWithBuffLayer:DoSkillEffectCalculator(skillEffectCalcParam)
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

function SkillEffectCalc_MultipleDamageWithBuffLayer:_CalculateSingleTarget(skillEffectCalcParam, defenderEntityID)
  local skillDamageParam = skillEffectCalcParam.skillEffectParam
  local defender = self._world:GetEntityByID(defenderEntityID)
  local attacker = self._world:GetEntityByID(skillEffectCalcParam.casterEntityID)
  local svc = self._world:GetService("BuffLogic")
  local layerCount = svc:GetBuffLayer(attacker, skillDamageParam:GetBuffEffectType())
  if defender == nil or layerCount == 0 then
    Log.notice("CalculationForeachTarget defender is null ", defenderEntityID)
    local skillResult = self._skillEffectService:NewSkillDamageEffectResult(nil, -1, 0, nil, nil)
    return {skillResult}
  end
  local attackPos = skillEffectCalcParam.attackPos
  local gridPos = skillEffectCalcParam.gridPos
  local damageStageIndex = skillDamageParam:GetSkillEffectDamageStageIndex()
  local skillResultList = {}
  for i = 1, layerCount do
    local nTotalDamage, listDamageInfo = self._skillEffectService:ComputeSkillDamage(attacker, attackPos, defender, gridPos, skillEffectCalcParam.skillID, skillDamageParam, SkillEffectType.Damage, damageStageIndex)
    local skillResult = self._skillEffectService:NewSkillDamageEffectResult(gridPos, defenderEntityID, nTotalDamage, listDamageInfo, damageStageIndex)
    table.insert(skillResultList, skillResult)
  end
  return skillResultList
end
