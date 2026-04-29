_class("SkillEffectCalc_DamageOnTargetCount", Object)
SkillEffectCalc_DamageOnTargetCount = SkillEffectCalc_DamageOnTargetCount

function SkillEffectCalc_DamageOnTargetCount:Constructor(world)
  self._world = world
end

function SkillEffectCalc_DamageOnTargetCount:DoSkillEffectCalculator(skillEffectCalcParam)
  local casterEntityID = skillEffectCalcParam.casterEntityID
  local casterEntity = self._world:GetEntityByID(casterEntityID)
  local skillEffectResultContainer = casterEntity:SkillContext():GetResultContainer()
  local scopeResult = skillEffectResultContainer:GetScopeResult()
  local skillEffectParam = skillEffectCalcParam.skillEffectParam
  local targetCount = #scopeResult:GetTargetIDs()
  local countNoRepeat = skillEffectParam:IsCountNoRepeat()
  if countNoRepeat then
    local targetIds = scopeResult:GetTargetIDs()
    local targetIdsNoRepeat = {}
    for i = 1, #targetIds do
      local targetId = targetIds[i]
      if false == table.icontains(targetIdsNoRepeat, targetId) then
        table.insert(targetIdsNoRepeat, targetId)
      end
    end
    targetCount = #targetIdsNoRepeat
  end
  local damageEffectParam = skillEffectParam:GetDamageParamByCount(targetCount)
  local damageCalcParam = SkillEffectCalcParam:New(skillEffectCalcParam:GetCasterEntityID(), skillEffectCalcParam:GetTargetEntityIDs(), damageEffectParam, skillEffectCalcParam:GetSkillID(), skillEffectCalcParam:GetSkillRange(), skillEffectCalcParam:GetAttackPos(), skillEffectCalcParam:GetGridPos())
  local skillEffectCalc = SkillEffectCalc_Damage:New(self._world)
  local result = skillEffectCalc:DoSkillEffectCalculator(damageCalcParam)
  return result
end
