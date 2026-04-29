require("scope_base")
_class("SkillScopeCalculator_NRowsMColumns", SkillScopeCalculator_Base)
SkillScopeCalculator_NRowsMColumns = SkillScopeCalculator_NRowsMColumns

function SkillScopeCalculator_NRowsMColumns:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  if centerPos._className == "Vector2" then
    centerPos = {centerPos}
  end
  local columns = scopeParam:GetSkillScopeColumns()
  local rows = scopeParam:GetSkillScopeRows()
  local targetArea = {}
  local wholeArea = {}
  local resultArea = {}
  for _, posCenter in ipairs(centerPos) do
    local yMoveCount = math.floor((rows - 1) / 2 + 0.5)
    local xMoveCount = math.floor((columns - 1) / 2 + 0.5)
    for xMoveIndex = 0, xMoveCount do
      local rightX = posCenter.x + xMoveIndex
      local leftX = posCenter.x - xMoveIndex
      for yMoveIndex = 0, yMoveCount do
        local topY = posCenter.y + yMoveIndex
        local bottomY = posCenter.y - yMoveIndex
        local rightXTopY = Vector2(rightX, topY)
        local rightXBottomY = Vector2(rightX, bottomY)
        local leftXTopY = Vector2(leftX, topY)
        local leftXBottomY = Vector2(leftX, bottomY)
        self:_InsertPosToResultArea(rightXTopY, resultArea)
        self:_InsertPosToResultArea(rightXBottomY, resultArea)
        self:_InsertPosToResultArea(leftXTopY, resultArea)
        self:_InsertPosToResultArea(leftXBottomY, resultArea)
      end
    end
  end
  for x, columnDic in pairs(resultArea) do
    for y, pos in pairs(columnDic) do
      targetArea[#targetArea + 1] = pos
      wholeArea[#wholeArea + 1] = pos
    end
  end
  local result = SkillScopeResult:New(SkillScopeType.NRowsMColumns, casterPos, targetArea, wholeArea)
  return result
end
