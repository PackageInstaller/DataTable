require("calc_base")
_class("SkillEffectCalc_FrontExtendDegressiveDamage", SkillEffectCalc_Base)
SkillEffectCalc_FrontExtendDegressiveDamage = SkillEffectCalc_FrontExtendDegressiveDamage

function SkillEffectCalc_FrontExtendDegressiveDamage:Constructor(world)
  self._world = world
  self._skillEffectService = self._world:GetService("SkillEffectCalc")
end

function SkillEffectCalc_FrontExtendDegressiveDamage:DoSkillEffectCalculator(skillEffectCalcParam)
  local results = {}
  self._results = {}
  self._skillEffectCalcParam = skillEffectCalcParam
  local skillDamageParam = skillEffectCalcParam.skillEffectParam
  local casterEntity = self._world:GetEntityByID(skillEffectCalcParam.casterEntityID)
  local skillEffectResultContainer = casterEntity:SkillContext():GetResultContainer()
  local scopeResult = skillEffectResultContainer:GetScopeResult()
  local centerPos = scopeResult:GetCenterPos()
  local effectParam = skillDamageParam:GetEffectParam()
  local utilCalcSvc = self._world:GetService("UtilCalc")
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local skillCalculater = SkillScopeCalculator:New(utilScopeSvc)
  local scopeCalc = SkillScopeCalculator_PickUpFrontExtendWithDamage:New(skillCalculater)
  
  local function calcDamageFunction(gridPos, targetIDArray, addDamagePercent)
    return self:_CalculateWithPosAndTarget(gridPos, targetIDArray, addDamagePercent)
  end
  
  local calcScopeResult = scopeCalc:CalcRange(SkillScopeType.PickUpFrontExtendWithDamage, effectParam, centerPos, casterEntity:BodyArea():GetArea(), casterEntity:GetGridDirection(), SkillTargetType.MonsterTrap, centerPos, casterEntity, calcDamageFunction)
  if table.count(self._results) == 0 then
    local skillResult = self._skillEffectService:NewSkillDamageEffectResult(nil, -1, 0, nil, nil)
    table.insert(self._results, skillResult)
  end
  for _, result in ipairs(self._results) do
    result:SetSpecialScopeResultList(calcScopeResult:GetSpecialScopeResult())
  end
  return self._results
end

function SkillEffectCalc_FrontExtendDegressiveDamage:_CalculateWithPosAndTarget(gridPos, targetIDArray, addDamagePercent)
  local results = {}
  for _, targetID in ipairs(targetIDArray) do
    local result = self:_CalculateSingleTarget(gridPos, targetID, addDamagePercent)
    if result then
      table.appendArray(results, result)
    end
  end
  return results
end

function SkillEffectCalc_FrontExtendDegressiveDamage:_CalculateSingleTarget(gridPos, defenderEntityID, addDamagePercent)
  local skillDamageParam = self._skillEffectCalcParam.skillEffectParam
  local baseDamagePercent = skillDamageParam:GetBaseDamagePercent()
  local defender = self._world:GetEntityByID(defenderEntityID)
  if defender == nil then
    local skillResult = self._skillEffectService:NewSkillDamageEffectResult(nil, -1, 0, nil, nil)
    return {skillResult}
  end
  local attacker = self._world:GetEntityByID(self._skillEffectCalcParam.casterEntityID)
  local attackPos = self._skillEffectCalcParam.attackPos
  local damageStageIndex = skillDamageParam:GetSkillEffectDamageStageIndex()
  local effectCalcSvc = self._skillEffectService
  local skillResultList = {}
  local damagePercent = baseDamagePercent + addDamagePercent
  skillDamageParam:SetDamagePercent({damagePercent})
  local ignoreShield, curSkillDamageIndex
  local nTotalDamage, listDamageInfo = effectCalcSvc:ComputeSkillDamage(attacker, attackPos, defender, gridPos, self._skillEffectCalcParam.skillID, skillDamageParam, SkillEffectType.Damage, damageStageIndex, ignoreShield, curSkillDamageIndex, gridPos)
  local skillResult = effectCalcSvc:NewSkillDamageEffectResult(gridPos, defenderEntityID, nTotalDamage, listDamageInfo, damageStageIndex)
  table.insert(skillResultList, skillResult)
  table.insert(self._results, skillResult)
  return skillResultList
end
