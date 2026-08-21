_class("SkillEffectCalc_ShowWarningArea", Object)
SkillEffectCalc_ShowWarningArea = SkillEffectCalc_ShowWarningArea

function SkillEffectCalc_ShowWarningArea:Constructor(world)
  self._world = world
end

function SkillEffectCalc_ShowWarningArea:DoSkillEffectCalculator(skillEffectCalcParam)
  local effectParam = skillEffectCalcParam.skillEffectParam
  local casterEntity = self._world:GetEntityByID(skillEffectCalcParam.casterEntityID)
  local posCaster = casterEntity:GridLocation().Position
  local effectResult = SkillEffectResult_ShowWarningArea:New()
  if not effectParam:IsGetScopeResultFromAI() then
    effectResult:ComputeWarningArea(self._world, casterEntity, effectParam)
  else
    local cAI = casterEntity:AI()
    local scopeResult = cAI:GetSkillScopeResult(true)
    effectResult.m_listPosWarning = scopeResult:GetAttackRange()
  end
  return effectResult
end
