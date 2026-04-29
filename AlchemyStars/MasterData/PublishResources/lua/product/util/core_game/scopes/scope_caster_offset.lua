require("scope_base")
_class("SkillScopeCalculator_CasterOffset", SkillScopeCalculator_Base)
SkillScopeCalculator_CasterOffset = SkillScopeCalculator_CasterOffset

function SkillScopeCalculator_CasterOffset:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  local wholeArea = self:_CalFixedPos(scopeParam.pos)
  for i, v in ipairs(wholeArea) do
    wholeArea[i] = Vector2(v.x + casterPos.x, v.y + casterPos.y)
  end
  local result = SkillScopeResult:New(SkillScopeType.CasterOffset, casterPos, wholeArea, wholeArea)
  return result
end
