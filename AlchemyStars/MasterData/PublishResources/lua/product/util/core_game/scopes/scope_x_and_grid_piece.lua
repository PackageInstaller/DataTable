require("scope_base")
_class("SkillScopeCalculator_XScopeTypeAndGridPiece", SkillScopeCalculator_Base)
SkillScopeCalculator_XScopeTypeAndGridPiece = SkillScopeCalculator_XScopeTypeAndGridPiece

function SkillScopeCalculator_XScopeTypeAndGridPiece:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  local casterPos = centerPos
  local bodyAreaArray = bodyArea
  local size = scopeParam[1]
  local selectPiece = scopeParam[2]
  local target_area_grid = {}
  for i, p in ipairs(bodyAreaArray) do
    table.insert(target_area_grid, Vector2(casterPos.x + p.x, casterPos.y + p.y))
  end
  local world = self._gridFilter._world
  local boardServiceLogic = world:GetService("BoardLogic")
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
      local leftDownPos = Vector2(center_x - index, center_y - index)
      local rightDownPos = Vector2(center_x + index, center_y - index)
      local leftUpPos = Vector2(center_x - index, center_y + index)
      local rightUpPos = Vector2(center_x + index, center_y + index)
      table.insert(wholeArea, leftDownPos)
      table.insert(wholeArea, rightDownPos)
      table.insert(wholeArea, leftUpPos)
      table.insert(wholeArea, rightUpPos)
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
  local crossAreaAndPiece = {}
  local wholeAreaAndPiece = {}
  for i, p in ipairs(cross_area) do
    local gridType = boardServiceLogic:GetPieceType(p)
    if selectPiece == gridType then
      table.insert(crossAreaAndPiece, p)
    end
  end
  for i, p in ipairs(wholeArea) do
    local gridType = boardServiceLogic:GetPieceType(p)
    if selectPiece == gridType then
      table.insert(wholeAreaAndPiece, p)
    end
  end
  local result = SkillScopeResult:New(SkillScopeType.XScopeTypeAndGridPiece, casterPos, crossAreaAndPiece, wholeAreaAndPiece)
  return result
end
