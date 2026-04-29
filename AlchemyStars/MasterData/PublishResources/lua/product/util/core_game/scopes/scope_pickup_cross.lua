require("scope_base")
_class("SkillScopeCalculator_PickUpCross", SkillScopeCalculator_Base)
SkillScopeCalculator_PickUpCross = SkillScopeCalculator_PickUpCross

function SkillScopeCalculator_PickUpCross:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  if #centerPos == 0 then
    centerPos = {centerPos}
  end
  local size = scopeParam[1]
  local startIndex = scopeParam[2] or 1
  local selectBodyArea = scopeParam[3] or 0
  local noRepeat = scopeParam[4] or 0
  local cross_area = {}
  local wholeArea = {}
  for _, pos in ipairs(centerPos) do
    local center_x = pos.x
    local center_y = pos.y
    if selectBodyArea == 1 then
      self:_InsertPos(cross_area, Vector2(center_x, center_y), noRepeat)
      self:_InsertPos(wholeArea, Vector2(center_x, center_y), noRepeat)
    end
    for index = startIndex, size do
      local upPos = Vector2(center_x, center_y + index)
      local downPos = Vector2(center_x, center_y - index)
      local leftPos = Vector2(center_x - index, center_y)
      local rightPos = Vector2(center_x + index, center_y)
      self:_InsertPos(wholeArea, upPos, noRepeat)
      self:_InsertPos(wholeArea, downPos, noRepeat)
      self:_InsertPos(wholeArea, leftPos, noRepeat)
      self:_InsertPos(wholeArea, rightPos, noRepeat)
      if self._gridFilter:IsValidPiecePos(upPos) then
        self:_InsertPos(cross_area, upPos, noRepeat)
      end
      if self._gridFilter:IsValidPiecePos(rightPos) then
        self:_InsertPos(cross_area, rightPos, noRepeat)
      end
      if self._gridFilter:IsValidPiecePos(downPos) then
        self:_InsertPos(cross_area, downPos, noRepeat)
      end
      if self._gridFilter:IsValidPiecePos(leftPos) then
        self:_InsertPos(cross_area, leftPos, noRepeat)
      end
    end
  end
  local result = SkillScopeResult:New(SkillScopeType.PickUpCross, centerPos, cross_area, wholeArea)
  return result
end

function SkillScopeCalculator_PickUpCross:_InsertPos(targetTb, pos, noRepeat)
  if noRepeat and noRepeat == 1 then
    local contain = table.icontains(targetTb, pos)
    if not contain then
      table.insert(targetTb, pos)
    end
  else
    table.insert(targetTb, pos)
  end
end
