require("scope_base")
_class("SkillScopeCalculator_RandomGridsByPieceType", SkillScopeCalculator_Base)
SkillScopeCalculator_RandomGridsByPieceType = SkillScopeCalculator_RandomGridsByPieceType

function SkillScopeCalculator_RandomGridsByPieceType:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  local gridCount = scopeParam.gridCount or 0
  local girdTypeList = scopeParam.pieceType or {}
  local world = self._gridFilter._world
  if not world then
    Log.exception(self._className, "这个范围只能在局内展示")
    return
  end
  local boardServiceLogic = world:GetService("BoardLogic")
  local pieceRange = boardServiceLogic:GetGridPosByPieceType(girdTypeList)
  local randomRange = {}
  if gridCount >= #pieceRange then
    randomRange = pieceRange
  else
    while gridCount > #randomRange do
      local index = self._gridFilter:_GetRandomNumber(1, #pieceRange)
      randomRange[#randomRange + 1] = pieceRange[index]
      table.remove(pieceRange, index)
    end
  end
  local result = SkillScopeResult:New(SkillScopeType.RandomGridsByPieceType, centerPos, randomRange, randomRange)
  return result
end
