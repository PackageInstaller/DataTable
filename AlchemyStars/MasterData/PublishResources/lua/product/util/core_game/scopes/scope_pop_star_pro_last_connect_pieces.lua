require("scope_base")
_class("SkillScopeCalculator_PopStarProLastConnectPieces", SkillScopeCalculator_Base)
SkillScopeCalculator_PopStarProLastConnectPieces = SkillScopeCalculator_PopStarProLastConnectPieces

function SkillScopeCalculator_PopStarProLastConnectPieces:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  local wholeArea = {}
  local world = self._hub._gridFilter._world
  local popStarProSvc = world:GetService("PopStarProLogic")
  if popStarProSvc then
    wholeArea = popStarProSvc:GetPopConnectPieces()
  end
  local result = SkillScopeResult:New(SkillScopeType.PopStarProLastConnectPieces, centerPos, wholeArea, wholeArea)
  return result
end
