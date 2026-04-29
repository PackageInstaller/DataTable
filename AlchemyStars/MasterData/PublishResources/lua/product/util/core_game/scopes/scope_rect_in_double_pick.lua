require("scope_base")
_class("SkillScopeCalculator_RectInDoublePick", SkillScopeCalculator_Base)
SkillScopeCalculator_RectInDoublePick = SkillScopeCalculator_RectInDoublePick

function SkillScopeCalculator_RectInDoublePick:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  local param = scopeParam
  local world = self._gridFilter._world
  local attackRangeList = {}
  local wholeRangeList = {}
  if 2 <= #centerPos then
    local startPos = centerPos[1]
    local finalPos = centerPos[2]
    local startX = math.min(startPos.x, finalPos.x)
    local finalX = math.max(startPos.x, finalPos.x)
    local startY = math.min(startPos.y, finalPos.y)
    local finalY = math.max(startPos.y, finalPos.y)
    local exceptCenterPos = false
    if param and param.exceptCenterPos and param.exceptCenterPos == 1 then
      exceptCenterPos = true
    end
    for curX = startX, finalX do
      for curY = startY, finalY do
        local curPos = Vector2(curX, curY)
        if exceptCenterPos and (curPos == startPos or curPos == finalPos) then
        else
          table.insert(wholeRangeList, curPos)
          if self._gridFilter:IsValidPiecePos(curPos) then
            table.insert(attackRangeList, curPos)
          end
        end
      end
    end
  elseif #centerPos == 1 and param and param.enableOnePick and param.enableOnePick == 1 then
    local pickPos = centerPos[1]
    table.insert(wholeRangeList, pickPos)
    if self._gridFilter:IsValidPiecePos(pickPos) then
      table.insert(attackRangeList, pickPos)
    end
  end
  local result = SkillScopeResult:New(SkillScopeType.RectInDoublePick, centerPos, attackRangeList, wholeRangeList)
  return result
end
