require("scope_base")
_class("SkillScopeCalculator_PickUpDoubleCross", SkillScopeCalculator_Base)
SkillScopeCalculator_PickUpDoubleCross = SkillScopeCalculator_PickUpDoubleCross

function SkillScopeCalculator_PickUpDoubleCross:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  if #centerPos == 0 then
    centerPos = {centerPos}
  end
  local world = self._gridFilter._world
  local boardServiceLogic = world:GetService("BoardLogic")
  local maxLen = boardServiceLogic:GetCurBoardMaxLen()
  local validGridArray = {}
  local length = maxLen
  for _, pos in ipairs(centerPos) do
    local gridArray = {}
    local type = self:GetDirection(pos, casterPos)
    if type == HitBackDirectionType.RightDown then
      for i = 1, length do
        gridArray[i] = Vector2(casterPos.x + i, casterPos.y - i)
      end
    elseif type == HitBackDirectionType.LeftDown then
      for i = 1, length do
        gridArray[i] = Vector2(casterPos.x - i, casterPos.y - i)
      end
    elseif type == HitBackDirectionType.LeftUp then
      for i = 1, length do
        gridArray[i] = Vector2(casterPos.x - i, casterPos.y + i)
      end
    elseif type == HitBackDirectionType.RightUp then
      for i = 1, length do
        gridArray[i] = Vector2(casterPos.x + i, casterPos.y + i)
      end
    elseif type == HitBackDirectionType.Right then
      for i = 1, length do
        gridArray[i] = Vector2(casterPos.x + i, casterPos.y)
      end
    elseif type == HitBackDirectionType.Left then
      for i = 1, length do
        gridArray[i] = Vector2(casterPos.x - i, casterPos.y)
      end
    elseif type == HitBackDirectionType.Down then
      for i = 1, length do
        gridArray[i] = Vector2(casterPos.x, casterPos.y - i)
      end
    elseif type == HitBackDirectionType.Up then
      for i = 1, length do
        gridArray[i] = Vector2(casterPos.x, casterPos.y + i)
      end
    end
    for _, v in pairs(gridArray) do
      if self._gridFilter:IsValidPiecePos(v) then
        table.insert(validGridArray, v)
      end
    end
  end
  local result = SkillScopeResult:New(SkillScopeType.PickUpDoubleCross, centerPos, validGridArray, validGridArray)
  return result
end
