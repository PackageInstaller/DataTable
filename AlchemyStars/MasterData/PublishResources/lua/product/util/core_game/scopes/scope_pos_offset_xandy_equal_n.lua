require("scope_base")
_class("SkillScopeCalculator_PosOffsetXAndYEqualN", SkillScopeCalculator_Base)
SkillScopeCalculator_PosOffsetXAndYEqualN = SkillScopeCalculator_PosOffsetXAndYEqualN

function SkillScopeCalculator_PosOffsetXAndYEqualN:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  if not scopeParam then
    Log.fatal("### scopeParam is nil. centerPos=", centerPos)
    return
  end
  local n = scopeParam[1]
  local offset = CalcXAddYOffset(n)
  local resultScope = {}
  for i, v in ipairs(offset) do
    local pos = centerPos + Vector2(v[1], v[2])
    self:_InsertTargetGrid(resultScope, pos)
  end
  local result = SkillScopeResult:New(SkillScopeType.PlayerToCasterDirection, centerPos, resultScope, resultScope)
  return result
end
