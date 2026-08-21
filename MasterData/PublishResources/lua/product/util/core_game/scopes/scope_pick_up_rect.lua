require("scope_base")
_class("SkillScopeCalculator_PickUpRect", SkillScopeCalculator_Base)
SkillScopeCalculator_PickUpRect = SkillScopeCalculator_PickUpRect

function SkillScopeCalculator_PickUpRect:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  local cross_area = {}
  local wholeArea = {}
  local dirX = 1
  local dirY = 1
  if centerPos.x < casterPos.x then
    dirX = -1
  end
  if centerPos.y < casterPos.y then
    dirY = -1
  end
  for i = casterPos.x, centerPos.x, dirX do
    for j = casterPos.y, centerPos.y, dirY do
      local pos = Vector2(i, j)
      table.insert(wholeArea, pos)
      if self._gridFilter:IsValidPiecePos(pos) then
        table.insert(cross_area, pos)
      end
    end
  end
  local result = SkillScopeResult:New(SkillScopeType.PickUpRect, casterPos, cross_area, wholeArea)
  return result
end
