require("scope_base")
_class("SkillScopeCalculator_DoubleCross", SkillScopeCalculator_Base)
SkillScopeCalculator_DoubleCross = SkillScopeCalculator_DoubleCross

function SkillScopeCalculator_DoubleCross:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  local bodyAreaArray = bodyArea
  local size = scopeParam
  local target_area_grid = {}
  for i, p in ipairs(bodyAreaArray) do
    table.insert(target_area_grid, Vector2(centerPos.x + p.x, centerPos.y + p.y))
  end
  local cross_area = {}
  local wholeArea = {}
  for i, p in ipairs(target_area_grid) do
    local center_x = p.x
    local center_y = p.y
    for index = 1, size do
      local down = center_y - index
      local left = center_x - index
      local up = center_y + index
      local right = center_x + index
      local upPos = Vector2(center_x, center_y + index)
      local downPos = Vector2(center_x, center_y - index)
      local leftPos = Vector2(center_x - index, center_y)
      local rightPos = Vector2(center_x + index, center_y)
      local leftDownPos = Vector2(center_x - index, center_y - index)
      local rightDownPos = Vector2(center_x + index, center_y - index)
      local leftUpPos = Vector2(center_x - index, center_y + index)
      local rightUpPos = Vector2(center_x + index, center_y + index)
      table.insert(wholeArea, upPos)
      table.insert(wholeArea, downPos)
      table.insert(wholeArea, leftPos)
      table.insert(wholeArea, rightPos)
      table.insert(wholeArea, leftDownPos)
      table.insert(wholeArea, rightDownPos)
      table.insert(wholeArea, leftUpPos)
      table.insert(wholeArea, rightUpPos)
      if self._gridFilter:IsValidPiecePos(upPos) then
        table.insert(cross_area, upPos)
      end
      if self._gridFilter:IsValidPiecePos(downPos) then
        table.insert(cross_area, downPos)
      end
      if self._gridFilter:IsValidPiecePos(leftPos) then
        table.insert(cross_area, leftPos)
      end
      if self._gridFilter:IsValidPiecePos(rightPos) then
        table.insert(cross_area, rightPos)
      end
      if self._gridFilter:IsValidPiecePos(leftDownPos) then
        table.insert(cross_area, leftDownPos)
      end
      if self._gridFilter:IsValidPiecePos(rightDownPos) then
        table.insert(cross_area, rightDownPos)
      end
      if self._gridFilter:IsValidPiecePos(leftUpPos) then
        table.insert(cross_area, leftUpPos)
      end
      if self._gridFilter:IsValidPiecePos(rightUpPos) then
        table.insert(cross_area, rightUpPos)
      end
    end
  end
  local result = SkillScopeResult:New(SkillScopeType.DoubleCross, centerPos, cross_area, wholeArea)
  return result
end
