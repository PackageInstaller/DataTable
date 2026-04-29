require("calc_base")
_class("DamageByReflectDistanceCalculator", SkillEffectCalc_Base)
DamageByReflectDistanceCalculator = DamageByReflectDistanceCalculator

function DamageByReflectDistanceCalculator:Constructor(world)
  self._world = world
end

function DamageByReflectDistanceCalculator:Calculate(casterEntity, effectParam)
  local skillEffectResultContainer = casterEntity:SkillContext():GetResultContainer()
  local skillID = skillEffectResultContainer:GetSkillID()
  local scopeResult = skillEffectResultContainer:GetScopeResult()
  local attackRange = scopeResult:GetAttackRange()
  local distance = scopeResult:GetSpecialScopeResult()
  local attackPos = casterEntity:GetGridPosition()
  local boardLogicSvc = self._world:GetService("BoardLogic")
  local buffLogicSvc = self._world:GetService("BuffLogic")
  local skillEffectService = self._world:GetService("SkillEffectCalc")
  local targetSelector = self._world:GetSkillScopeTargetSelector()
  local damageStageIndex = effectParam:GetSkillEffectDamageStageIndex()
  local modifySkillIncreaseType = effectParam:GetSkillIncreaseType()
  local tResults = {}
  for i = 1, #attackRange do
    local gridPos = attackRange[i]
    local damageParam = distance[i] * effectParam:GetDistanceDamageParam()
    local targetID = scopeResult:GetTargetIDByPos(gridPos)
    if targetID then
      local target = self._world:GetEntityByID(targetID)
      buffLogicSvc:ChangeSkillIncrease(casterEntity, self, modifySkillIncreaseType, damageParam)
      local nTotalDamage, listDamageInfo = skillEffectService:ComputeSkillDamage(casterEntity, attackPos, target, gridPos, skillID, effectParam, SkillEffectType.Damage, damageStageIndex)
      buffLogicSvc:RemoveSkillIncrease(casterEntity, self, modifySkillIncreaseType)
      local skillResult = self._skillEffectService:NewSkillDamageEffectResult(gridPos, target:GetID(), nTotalDamage, listDamageInfo, damageStageIndex)
      skillEffectResultContainer:AddEffectResult(skillResult)
      table.insert(tResults, skillResult)
    end
  end
  return tResults
end
