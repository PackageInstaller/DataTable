require("scope_base")
_class("SkillScopeCalculator_BowlingerSummonArea", SkillScopeCalculator_Base)
SkillScopeCalculator_BowlingerSummonArea = SkillScopeCalculator_BowlingerSummonArea
local SectorRange = {
  [1] = {
    minX = 1,
    maxX = 3,
    minY = 1,
    maxY = 4
  },
  [2] = {
    minX = 4,
    maxX = 6,
    minY = 1,
    maxY = 3
  },
  [3] = {
    minX = 7,
    maxX = 9,
    minY = 1,
    maxY = 4
  },
  [4] = {
    minX = 1,
    maxX = 3,
    minY = 5,
    maxY = 7
  },
  [5] = {
    minX = 4,
    maxX = 6,
    minY = 4,
    maxY = 7
  },
  [6] = {
    minX = 7,
    maxX = 9,
    minY = 5,
    maxY = 7
  }
}

function SkillScopeCalculator_BowlingerSummonArea:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  local areaNo = scopeParam[1]
  local sectorRangePreference = SectorRange[areaNo]
  if not sectorRangePreference then
    Log.Exception(self._className, "areaNo: ", tostring(areaNo), "no SectorRange found")
    return SkillScopeResult(SkillScopeType.BowlingerSummonArea, centerPos, {}, {})
  end
  local minX = sectorRangePreference.minX
  local maxX = sectorRangePreference.maxX
  local minY = sectorRangePreference.minY
  local maxY = sectorRangePreference.maxY
  local attackRange = {}
  local wholeRange = {}
  for x = minX, maxX do
    for y = minY, maxY do
      local v2 = Vector2.New(x, y)
      table.insert(wholeRange, v2)
      if self._gridFilter:IsValidPiecePos(v2) then
        table.insert(attackRange, v2)
      end
    end
  end
  return SkillScopeResult:New(SkillScopeType.BowlingerSummonArea, centerPos, attackRange, wholeRange)
end
