require("scope_base")
_class("SkillScopeCalculator_RhombusRemoveAngle", SkillScopeCalculator_Base)
SkillScopeCalculator_RhombusRemoveAngle = SkillScopeCalculator_RhombusRemoveAngle

function SkillScopeCalculator_RhombusRemoveAngle:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  local params = scopeParam
  local size = params[1]
  local isCenterIncluded = params[2]
  local canMoveFlag = params[3]
  local select_piece = {}
  local index = 1
  for i = -size, size do
    for j = -size, size do
      if size >= math.abs(i) + math.abs(j) and (i ~= 0 or j ~= 0) then
        select_piece[index] = {i, j}
        index = index + 1
      end
    end
  end
  local range = {}
  local wholeArea = {}
  for _, pos in ipairs(select_piece) do
    local tar = Vector2(centerPos.x + pos[1], centerPos.y + pos[2])
    self:_InsertTargetGrid(range, tar, wholeArea)
  end
  if isCenterIncluded then
    self:_InsertTargetGrid(range, centerPos, wholeArea)
  end
  if canMoveFlag and canMoveFlag ~= 0 then
    local newRange = {}
    for _, pos in pairs(range) do
      if not self._gridFilter:IsPosBlock(pos, BlockFlag.LinkLine) then
        table.insert(newRange, pos)
      end
    end
    range = newRange
  end
  table.removev(range, Vector2(centerPos.x, centerPos.y + size))
  table.removev(range, Vector2(centerPos.x, centerPos.y - size))
  table.removev(range, Vector2(centerPos.x + size, centerPos.y))
  table.removev(range, Vector2(centerPos.x - size, centerPos.y))
  local result = SkillScopeResult:New(SkillScopeType.RhombusRemoveAngle, centerPos, range, range)
  return result
end
