require("scope_base")
_class("SkillScopeCalculator_FourValidPointDistanceCaster", SkillScopeCalculator_Base)
SkillScopeCalculator_FourValidPointDistanceCaster = SkillScopeCalculator_FourValidPointDistanceCaster

function SkillScopeCalculator_FourValidPointDistanceCaster:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  local world = self._gridFilter._world
  local utilData = world:GetService("UtilData")
  local cross_area = {}
  local wholeArea = {}
  local distance = scopeParam[1] or 2
  local up = Vector2(centerPos.x, centerPos.y + distance)
  local down = Vector2(centerPos.x, centerPos.y - distance)
  local left = Vector2(centerPos.x - distance, centerPos.y)
  local right = Vector2(centerPos.x + distance, centerPos.y)
  table.insert(wholeArea, up)
  table.insert(wholeArea, down)
  table.insert(wholeArea, left)
  table.insert(wholeArea, right)
  if utilData:IsValidPiecePos(up) then
    table.insert(cross_area, up)
  end
  if utilData:IsValidPiecePos(down) then
    table.insert(cross_area, down)
  end
  if utilData:IsValidPiecePos(left) then
    table.insert(cross_area, left)
  end
  if utilData:IsValidPiecePos(right) then
    table.insert(cross_area, right)
  end
  local result = SkillScopeResult:New(SkillScopeType.FrontAndObliqueOffset, centerPos, cross_area, wholeArea)
  return result
end
