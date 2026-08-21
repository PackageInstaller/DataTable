require("scope_base")
_class("SkillScopeCalculator_CasterOffsetAndDir", SkillScopeCalculator_Base)
SkillScopeCalculator_CasterOffsetAndDir = SkillScopeCalculator_CasterOffsetAndDir

function SkillScopeCalculator_CasterOffsetAndDir:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  local wholeArea = self:_CalFixedPos(scopeParam.pos)
  for i, v in ipairs(wholeArea) do
    wholeArea[i] = Vector2(v.x * casterDir.x + casterPos.x, v.y * casterDir.y + casterPos.y)
  end
  local result = SkillScopeResult:New(SkillScopeType.CasterOffsetAndDir, casterPos, wholeArea, wholeArea)
  return result
end
