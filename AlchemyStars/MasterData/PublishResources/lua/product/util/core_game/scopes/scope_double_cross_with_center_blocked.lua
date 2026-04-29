require("scope_base")
_class("SkillScopeCalculator_DoubleCrossWithCenter", SkillScopeCalculator_Base)
SkillScopeCalculator_DoubleCrossWithCenter = SkillScopeCalculator_DoubleCrossWithCenter

function SkillScopeCalculator_DoubleCrossWithCenter:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  local casterPos = centerPos
  local casterbodyAreaArray = bodyArea
  local size = scopeParam[1]
  local target_area_grid = {}
  for i, p in ipairs(casterbodyAreaArray) do
    table.insert(target_area_grid, Vector2(casterPos.x + p.x, casterPos.y + p.y))
  end
  local cross_area = {}
  local wholeArea = {}
  local blocks = self._gridFilter:GetBlockGridTrapPosList()
  for i, p in ipairs(target_area_grid) do
    local center_x = p.x
    local center_y = p.y
    local upBlocked = false
    local downBlocked = false
    local leftBlocked = false
    local rightBlocked = false
    local leftDownBlocked = false
    local rightDownBlocked = false
    local leftUpBlocked = false
    local rightUpBlocked = false
    for index = 1, size do
      local upPos = Vector2(center_x, center_y + index)
      local downPos = Vector2(center_x, center_y - index)
      local leftPos = Vector2(center_x - index, center_y)
      local rightPos = Vector2(center_x + index, center_y)
      local leftDownPos = Vector2(center_x - index, center_y - index)
      local rightDownPos = Vector2(center_x + index, center_y - index)
      local leftUpPos = Vector2(center_x - index, center_y + index)
      local rightUpPos = Vector2(center_x + index, center_y + index)
      if not upBlocked then
        if not table.icontains(blocks, upPos) then
          self:_InsertTargetGrid(cross_area, upPos, wholeArea)
        else
          upBlocked = true
          self:_InsertTargetGridIntoOneArea(upPos, wholeArea)
        end
      else
        self:_InsertTargetGridIntoOneArea(upPos, wholeArea)
      end
      if not downBlocked then
        if not table.icontains(blocks, downPos) then
          self:_InsertTargetGrid(cross_area, downPos, wholeArea)
        else
          downBlocked = true
          self:_InsertTargetGridIntoOneArea(downPos, wholeArea)
        end
      else
        self:_InsertTargetGridIntoOneArea(downPos, wholeArea)
      end
      if not leftBlocked then
        if not table.icontains(blocks, leftPos) then
          self:_InsertTargetGrid(cross_area, leftPos, wholeArea)
        else
          leftBlocked = true
          self:_InsertTargetGridIntoOneArea(leftPos, wholeArea)
        end
      else
        self:_InsertTargetGridIntoOneArea(leftPos, wholeArea)
      end
      if not rightBlocked then
        if not table.icontains(blocks, rightPos) then
          self:_InsertTargetGrid(cross_area, rightPos, wholeArea)
        else
          rightBlocked = true
          self:_InsertTargetGridIntoOneArea(rightPos, wholeArea)
        end
      else
        self:_InsertTargetGridIntoOneArea(rightPos, wholeArea)
      end
      if not leftDownBlocked then
        if not table.icontains(blocks, leftDownPos) then
          self:_InsertTargetGrid(cross_area, leftDownPos, wholeArea)
        else
          leftDownBlocked = true
          self:_InsertTargetGridIntoOneArea(leftDownPos, wholeArea)
        end
      else
        self:_InsertTargetGridIntoOneArea(leftDownPos, wholeArea)
      end
      if not rightDownBlocked then
        if not table.icontains(blocks, rightDownPos) then
          self:_InsertTargetGrid(cross_area, rightDownPos, wholeArea)
        else
          rightDownBlocked = true
          self:_InsertTargetGridIntoOneArea(rightDownPos, wholeArea)
        end
      else
        self:_InsertTargetGridIntoOneArea(rightDownPos, wholeArea)
      end
      if not leftUpBlocked then
        if not table.icontains(blocks, leftUpPos) then
          self:_InsertTargetGrid(cross_area, leftUpPos, wholeArea)
        else
          leftUpBlocked = true
          self:_InsertTargetGridIntoOneArea(leftUpPos, wholeArea)
        end
      else
        self:_InsertTargetGridIntoOneArea(leftUpPos, wholeArea)
      end
      if not rightUpBlocked then
        if not table.icontains(blocks, rightUpPos) then
          self:_InsertTargetGrid(cross_area, rightUpPos, wholeArea)
        else
          rightUpBlocked = true
          self:_InsertTargetGridIntoOneArea(rightUpPos, wholeArea)
        end
      else
        self:_InsertTargetGridIntoOneArea(rightUpPos, wholeArea)
      end
    end
  end
  if not table.icontains(blocks, casterPos) then
    self:_InsertTargetGrid(cross_area, casterPos, wholeArea)
  else
    self:_InsertTargetGridIntoOneArea(casterPos, wholeArea)
  end
  local result = SkillScopeResult:New(SkillScopeType.DoubleCross, casterPos, cross_area, wholeArea)
  return result
end
