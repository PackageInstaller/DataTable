require("scope_base")
_class("SkillScopeCalculator_ColOrRowByPickUpCount", SkillScopeCalculator_Base)
SkillScopeCalculator_ColOrRowByPickUpCount = SkillScopeCalculator_ColOrRowByPickUpCount

function SkillScopeCalculator_ColOrRowByPickUpCount:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  if type(centerPos) ~= "table" then
    Log.exception("Scope 140 Need CenterType:4")
  end
  local pickUpPos = centerPos[1]
  local pickUpCount = #centerPos
  local dirType, step, maxValue
  local boardSvc = self._gridFilter._world:GetService("BoardLogic")
  if pickUpCount == 1 then
    maxValue = boardSvc:GetCurBoardMaxY()
  elseif pickUpCount == 2 then
    maxValue = boardSvc:GetCurBoardMaxX()
  end
  local cross_area = {}
  local wholeArea = {}
  for i = 0, maxValue do
    local pos
    if pickUpCount == 1 then
      pos = Vector2(pickUpPos.x, i)
    elseif pickUpCount == 2 then
      pos = Vector2(i, pickUpPos.y)
    end
    if self._gridFilter:IsValidPiecePos(pos) then
      table.insert(cross_area, pos)
      table.insert(wholeArea, pos)
    end
  end
  local result = SkillScopeResult:New(SkillScopeType.ColOrRowByPickUpCount, casterPos, cross_area, wholeArea)
  return result
end
