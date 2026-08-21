require("scope_base")
_class("SkillScopeCalculator_SelectPieceByType", SkillScopeCalculator_Base)
SkillScopeCalculator_SelectPieceByType = SkillScopeCalculator_SelectPieceByType

function SkillScopeCalculator_SelectPieceByType:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  local world = self._gridFilter._world
  if not world then
    Log.exception(self._className, "这个范围只能在局内展示")
    return
  end
  local boardServiceLogic = world:GetService("BoardLogic")
  local pieceRange = boardServiceLogic:GetGridPosByPieceType(scopeParam)
  return SkillScopeResult:New(SkillScopeType.SelectPieceByType, centerPos, pieceRange, pieceRange)
end
