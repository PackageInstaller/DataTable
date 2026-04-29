require("scope_base")
_class("SkillScopeCalculator_WidthCrossWithPickUp", SkillScopeCalculator_Base)
SkillScopeCalculator_WidthCrossWithPickUp = SkillScopeCalculator_WidthCrossWithPickUp

function SkillScopeCalculator_WidthCrossWithPickUp:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  local casterPos = centerPos
  local bodyAreaArray = bodyArea
  local param = scopeParam
  local size = param[1]
  local width = param[2]
  local target_area_grid = {}
  local offset = math.floor(width / 2)
  for i = 1, offset do
    local posList = self:_GetCenterPos8DirectionWithOffset(casterPos, i)
    self:_CopyTable(target_area_grid, posList)
  end
  local cross_area = {}
  local wholeArea = {}
  for i, p in ipairs(target_area_grid) do
    local center_x = p.x
    local center_y = p.y
    for index = 1, size do
      local upPos = Vector2(center_x, center_y + index)
      local downPos = Vector2(center_x, center_y - index)
      local leftPos = Vector2(center_x - index, center_y)
      local rightPos = Vector2(center_x + index, center_y)
      self:_InsertTargetGridIntoOneArea(upPos, wholeArea)
      self:_InsertTargetGridIntoOneArea(downPos, wholeArea)
      self:_InsertTargetGridIntoOneArea(leftPos, wholeArea)
      self:_InsertTargetGridIntoOneArea(rightPos, wholeArea)
      if self._gridFilter:IsValidPiecePos(upPos) then
        self:_InsertTargetGridIntoOneArea(upPos, cross_area)
      end
      if self._gridFilter:IsValidPiecePos(downPos) then
        self:_InsertTargetGridIntoOneArea(downPos, cross_area)
      end
      if self._gridFilter:IsValidPiecePos(leftPos) then
        self:_InsertTargetGridIntoOneArea(leftPos, cross_area)
      end
      if self._gridFilter:IsValidPiecePos(rightPos) then
        self:_InsertTargetGridIntoOneArea(rightPos, cross_area)
      end
    end
  end
  local result = SkillScopeResult:New(SkillScopeType.WidthCrossWithPickUp, casterPos, cross_area, wholeArea)
  return result
end

function SkillScopeCalculator_WidthCrossWithPickUp:_GetCenterPos8DirectionWithOffset(centerPos, offSet)
  local UpPos = Vector2(centerPos.x, centerPos.y + offSet)
  local BottomPos = Vector2(centerPos.x, centerPos.y - offSet)
  local LeftPos = Vector2(centerPos.x - offSet, centerPos.y)
  local RightPos = Vector2(centerPos.x + offSet, centerPos.y)
  local UpLeftPos = Vector2(centerPos.x - offSet, centerPos.y + offSet)
  local UpRightPos = Vector2(centerPos.x + offSet, centerPos.y + offSet)
  local BottomLeftPos = Vector2(centerPos.x - offSet, centerPos.y - offSet)
  local BottomRightPos = Vector2(centerPos.x + offSet, centerPos.y - offSet)
  return {
    UpPos,
    BottomPos,
    LeftPos,
    RightPos,
    UpLeftPos,
    UpRightPos,
    BottomLeftPos,
    BottomRightPos
  }
end

function SkillScopeCalculator_WidthCrossWithPickUp:_CopyTable(tableA, tableB)
  if nil == tableB or nil == tableA then
    return
  end
  for key, value in pairs(tableB) do
    table.insert(tableA, value)
  end
end
