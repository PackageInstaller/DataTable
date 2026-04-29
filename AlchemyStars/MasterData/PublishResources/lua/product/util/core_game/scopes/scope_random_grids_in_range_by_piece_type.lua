require("scope_base")
_class("SkillScopeCalculator_RandomGridsInRangeByPieceType", SkillScopeCalculator_Base)
SkillScopeCalculator_RandomGridsInRangeByPieceType = SkillScopeCalculator_RandomGridsInRangeByPieceType

function SkillScopeCalculator_RandomGridsInRangeByPieceType:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  local gridCount = scopeParam.gridCount or 0
  local girdTypeList = scopeParam.pieceType or {}
  local rangeScopeType = scopeParam.rangeScopeType
  local rangeScopeParam = scopeParam.rangeScopeParam
  local world = self._gridFilter._world
  if not world then
    Log.exception(self._className, "这个范围只能在局内展示")
    return
  end
  local boardServiceLogic = world:GetService("BoardLogic")
  local randomSvc = world:GetService("RandomLogic")
  local pieceRange = boardServiceLogic:GetGridPosByPieceType(girdTypeList)
  local scopeRangeResult = self._hub:ComputeScopeRange(rangeScopeType, rangeScopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  local scopeRange = scopeRangeResult:GetAttackRange()
  local filterdPieceRange = {}
  for _, pos in pairs(pieceRange) do
    if table.icontains(scopeRange, pos) then
      table.insert(filterdPieceRange, pos)
    end
  end
  table.sort(filterdPieceRange, function(a, b)
    if a.x == b.x then
      return a.y < b.y
    end
    return a.x < b.x
  end)
  local randomRange = {}
  if gridCount >= #filterdPieceRange then
    randomRange = filterdPieceRange
  else
    while gridCount > #randomRange do
      local index = randomSvc:BoardLogicRand(1, #filterdPieceRange)
      randomRange[#randomRange + 1] = filterdPieceRange[index]
      table.remove(filterdPieceRange, index)
    end
  end
  local result = SkillScopeResult:New(SkillScopeType.RandomGridsInRangeByPieceType, centerPos, randomRange, randomRange)
  return result
end
