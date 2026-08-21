require("scope_base")
_class("SkillScopeCalculator_ColOrRowByPickUp", SkillScopeCalculator_Base)
SkillScopeCalculator_ColOrRowByPickUp = SkillScopeCalculator_ColOrRowByPickUp

function SkillScopeCalculator_ColOrRowByPickUp:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  if type(centerPos) ~= "table" then
    Log.exception("Scope 140 Need CenterType:4")
  end
  local pickUpPos = centerPos[1]
  local dirPos = centerPos[2]
  if not dirPos then
    return SkillScopeResult:New(SkillScopeType.ColOrRowByPickUp, casterPos, {}, {})
  end
  local dirType, step, maxValue
  local boardSvc = self._gridFilter._world:GetService("BoardLogic")
  if pickUpPos.x ~= dirPos.x then
    maxValue = boardSvc:GetCurBoardMaxY()
    if pickUpPos.x > dirPos.x then
      dirType = DirectionType.Left
      step = -1
    elseif pickUpPos.x < dirPos.x then
      dirType = DirectionType.Right
    end
  elseif pickUpPos.y ~= dirPos.y then
    maxValue = boardSvc:GetCurBoardMaxX()
    if pickUpPos.y > dirPos.y then
      dirType = DirectionType.Down
      step = -1
    elseif pickUpPos.y < dirPos.y then
      dirType = DirectionType.Up
    end
  end
  local cross_area = {}
  local wholeArea = {}
  for i = 0, maxValue do
    local pos
    if dirType == DirectionType.Up or dirType == DirectionType.Down then
      pos = Vector2(i, pickUpPos.y)
    elseif dirType == DirectionType.Left or dirType == DirectionType.Right then
      pos = Vector2(pickUpPos.x, i)
    end
    if self._gridFilter:IsValidPiecePos(pos) then
      table.insert(cross_area, pos)
      table.insert(wholeArea, pos)
    end
  end
  local result = SkillScopeResult:New(SkillScopeType.ColOrRowByPickUp, casterPos, cross_area, wholeArea)
  return result
end
