require("scope_base")
_class("SkillScopeCalculator_ColOrRowByEdgePos", SkillScopeCalculator_Base)
SkillScopeCalculator_ColOrRowByEdgePos = SkillScopeCalculator_ColOrRowByEdgePos

function SkillScopeCalculator_ColOrRowByEdgePos:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  local boardSvc = self._gridFilter._world:GetService("BoardLogic")
  local cross_area = boardSvc:CalcScopeColOrRowByEdgePos(casterPos, true)
  local wholeArea = cross_area
  local result = SkillScopeResult:New(SkillScopeType.ColOrRowByEdgePos, casterPos, cross_area, wholeArea)
  return result
end
