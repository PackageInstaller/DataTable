require("scope_base")
_class("SkillScopeCalculator_CasterCross", SkillScopeCalculator_Base)
SkillScopeCalculator_CasterCross = SkillScopeCalculator_CasterCross

function SkillScopeCalculator_CasterCross:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  local scopeList = {}
  table.insert(scopeList, Vector2(casterPos.x - 1, casterPos.y))
  table.insert(scopeList, Vector2(casterPos.x + 1, casterPos.y))
  table.insert(scopeList, Vector2(casterPos.x, casterPos.y - 1))
  table.insert(scopeList, Vector2(casterPos.x, casterPos.y + 1))
  local result = SkillScopeResult:New(SkillScopeType.CasterCross, centerPos, scopeList, scopeList)
  return result
end
