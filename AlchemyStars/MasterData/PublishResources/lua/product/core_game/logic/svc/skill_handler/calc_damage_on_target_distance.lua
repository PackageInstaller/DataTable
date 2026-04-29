require("calc_base")
_class("SkillEffectCalc_DamageOnTargetDistance", SkillEffectCalc_Base)
SkillEffectCalc_DamageOnTargetDistance = SkillEffectCalc_DamageOnTargetDistance

function SkillEffectCalc_DamageOnTargetDistance:Constructor(world)
  self._world = world
  self._skillEffectService = self._world:GetService("SkillEffectCalc")
end

function SkillEffectCalc_DamageOnTargetDistance:DoSkillEffectCalculator(skillEffectCalcParam)
  local results = {}
  self._curPos = nil
  self._gridRingNum = 0
  local attacker = self._world:GetEntityByID(skillEffectCalcParam.casterEntityID)
  local centerPos = skillEffectCalcParam:GetCenterPos()
  local skillDamageParam = skillEffectCalcParam.skillEffectParam
  local targetCount = skillDamageParam:GetTargetCount()
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local skillCalculater = SkillScopeCalculator:New(utilScopeSvc)
  local fullScreenCalc = SkillScopeCalculator_FullScreen:New(skillCalculater)
  local platformScopeResult = fullScreenCalc:CalcRange(SkillScopeType.FullScreen, 1, centerPos, attacker:BodyArea():GetArea(), attacker:GetGridDirection(), SkillTargetType.Board, centerPos)
  local targetSelector = self._world:GetSkillScopeTargetSelector()
  local targetArray = targetSelector:DoSelectSkillTarget(attacker, SkillTargetType.NearestMonsterOneByOne, platformScopeResult, nil, {targetCount})
  for _, targetID in ipairs(targetArray) do
    local result = self:_CalculateSingleTarget(skillEffectCalcParam, targetID)
    if result then
      table.appendArray(results, result)
    end
  end
  return results
end

function SkillEffectCalc_DamageOnTargetDistance:_CalculateSingleTarget(skillEffectCalcParam, defenderEntityID)
  local skillDamageParam = skillEffectCalcParam.skillEffectParam
  local defender = self._world:GetEntityByID(defenderEntityID)
  if defender == nil then
    Log.notice("CalculationForeachTarget defender is null ", defenderEntityID)
    local skillResult = self._skillEffectService:NewSkillDamageEffectResult(nil, -1, 0, nil, nil)
    return {skillResult}
  end
  local attacker = self._world:GetEntityByID(skillEffectCalcParam.casterEntityID)
  local modifySkillIncreaseType = skillDamageParam:GetSkillIncreaseType()
  local damageStageIndex = skillDamageParam:GetSkillEffectDamageStageIndex()
  local baseValue = skillDamageParam:GetBaseValue()
  local changeValue = skillDamageParam:GetChangeValue()
  local skillEffectResultContainer = attacker:SkillContext():GetResultContainer()
  local damageResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.Damage)
  if skillEffectCalcParam.skillRange == nil then
    skillEffectCalcParam.skillRange = {
      skillEffectCalcParam.gridPos
    }
  end
  local formulaService = self._world:GetService("Formula")
  local attackPos = skillEffectCalcParam.attackPos
  local gridPos = skillEffectCalcParam.gridPos
  if not self._curPos then
    self._curPos = attackPos
  end
  local targetPos = defender:GetGridPosition()
  local utilCalcSvc = self._world:GetService("UtilCalc")
  local currentRingNum = utilCalcSvc:GetGridRingNum(self._curPos, targetPos)
  self._gridRingNum = self._gridRingNum + currentRingNum
  self._curPos = targetPos
  local damageParam = baseValue + self._gridRingNum * changeValue
  local buffLogicSvc = self._world:GetService("BuffLogic")
  buffLogicSvc:ChangeSkillIncrease(attacker, self, modifySkillIncreaseType, damageParam)
  local effectCalcSvc = self._skillEffectService
  local nTotalDamage, listDamageInfo = effectCalcSvc:ComputeSkillDamage(attacker, attackPos, defender, gridPos, skillEffectCalcParam.skillID, skillDamageParam, SkillEffectType.Damage, damageStageIndex)
  buffLogicSvc:RemoveSkillIncrease(attacker, self, modifySkillIncreaseType)
  local skillResult = effectCalcSvc:NewSkillDamageEffectResult(gridPos, defenderEntityID, nTotalDamage, listDamageInfo, damageStageIndex)
  local skillResultList = {}
  table.insert(skillResultList, skillResult)
  return skillResultList
end
