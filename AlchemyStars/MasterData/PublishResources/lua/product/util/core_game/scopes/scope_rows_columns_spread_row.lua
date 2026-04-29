require("scope_base")
_class("SkillScopeCalculator_NRowsMColumnsSpreadAlongRow", SkillScopeCalculator_Base)
SkillScopeCalculator_NRowsMColumnsSpreadAlongRow = SkillScopeCalculator_NRowsMColumnsSpreadAlongRow

function SkillScopeCalculator_NRowsMColumnsSpreadAlongRow:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  local casterPos = centerPos
  local skillNRowsMColumnsScopeParam = scopeParam
  local columns = skillNRowsMColumnsScopeParam:GetSkillScopeColumns()
  local rows = skillNRowsMColumnsScopeParam:GetSkillScopeRows()
  local targetArea = {}
  local wholeArea = {}
  local yMoveCount = math.floor((rows - 1) / 2 + 0.5)
  local xMoveCount = math.floor((columns - 1) / 2 + 0.5)
  local blockGridTrapPosList = self._gridFilter:GetBlockGridTrapPosList()
  for yMoveIndex = 0, yMoveCount do
    local topY = casterPos.y + yMoveIndex
    local bottomY = casterPos.y - yMoveIndex
    local leftUpBlocked = false
    local leftDownBlocked = false
    local rightUpBlocked = false
    local rightDownBlocked = false
    for xMoveIndex = 0, xMoveCount do
      local rightX = casterPos.x + xMoveIndex
      local leftX = casterPos.x - xMoveIndex
      local leftXTopY = Vector2(leftX, topY)
      if not leftUpBlocked then
        if xMoveIndex == 0 or not table.icontains(blockGridTrapPosList, leftXTopY) then
          self:_InsertTargetGrid(targetArea, leftXTopY, wholeArea)
        else
          leftUpBlocked = true
          self:_InsertTargetGridIntoOneArea(leftXTopY, wholeArea)
        end
      else
        self:_InsertTargetGridIntoOneArea(leftXTopY, wholeArea)
      end
      local leftXBottomY = Vector2(leftX, bottomY)
      if not leftDownBlocked then
        if xMoveIndex == 0 or not table.icontains(blockGridTrapPosList, leftXBottomY) then
          self:_InsertTargetGrid(targetArea, leftXBottomY, wholeArea)
        else
          leftDownBlocked = true
          self:_InsertTargetGridIntoOneArea(leftXBottomY, wholeArea)
        end
      else
        self:_InsertTargetGridIntoOneArea(leftXBottomY, wholeArea)
      end
      local rightXTopY = Vector2(rightX, topY)
      if not rightUpBlocked then
        if xMoveIndex == 0 or not table.icontains(blockGridTrapPosList, rightXTopY) then
          self:_InsertTargetGrid(targetArea, rightXTopY, wholeArea)
        else
          rightUpBlocked = true
          self:_InsertTargetGridIntoOneArea(rightXTopY, wholeArea)
        end
      else
        self:_InsertTargetGridIntoOneArea(rightXTopY, wholeArea)
      end
      local rightXBottomY = Vector2(rightX, bottomY)
      if not rightDownBlocked then
        if xMoveIndex == 0 or not table.icontains(blockGridTrapPosList, rightXBottomY) then
          self:_InsertTargetGrid(targetArea, rightXBottomY, wholeArea)
        else
          rightDownBlocked = true
          self:_InsertTargetGridIntoOneArea(rightXBottomY, wholeArea)
        end
      else
        self:_InsertTargetGridIntoOneArea(rightXBottomY, wholeArea)
      end
    end
  end
  local result = SkillScopeResult:New(SkillScopeType.NRowsMColumns, casterPos, targetArea, wholeArea)
  return result
end
