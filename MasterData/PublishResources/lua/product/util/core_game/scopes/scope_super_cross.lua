require("scope_base")
_class("SkillScopeCalculator_SuperCross", SkillScopeCalculator_Base)
SkillScopeCalculator_SuperCross = SkillScopeCalculator_SuperCross

function SkillScopeCalculator_SuperCross:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  local bodyAreaArray = bodyArea
  local size = scopeParam
  local cross_result = self._hub:ComputeScopeRange(SkillScopeType.CrossExceptBlock, {scopeParam}, centerPos, bodyArea, casterDir, nTargetType, centerPos)
  local cross_range = cross_result:GetAttackRange()
  local cross_total_range = cross_result:GetWholeGridRange()
  local x_result = self._hub:ComputeScopeRange(SkillScopeType.XScopeType, {1}, centerPos, bodyArea, casterDir, nTargetType, centerPos)
  local x_range = x_result:GetAttackRange()
  for _, pos in ipairs(x_range) do
    self:_InsertTargetGrid(cross_range, pos, cross_total_range)
  end
  local result = SkillScopeResult:New(SkillScopeType.SuperCross, centerPos, cross_range, cross_total_range)
  return result
end
