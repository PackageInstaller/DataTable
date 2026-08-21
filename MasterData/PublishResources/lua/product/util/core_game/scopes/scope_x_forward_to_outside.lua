require("scope_base")
_class("SkillScopeCalculator_XForwardToOutside", SkillScopeCalculator_Base)
SkillScopeCalculator_XForwardToOutside = SkillScopeCalculator_XForwardToOutside

function SkillScopeCalculator_XForwardToOutside:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  if #bodyArea ~= 4 then
    Log.error("[XForwardToOutside] caster body area error, body area size must be 4, cur size=", #bodyArea)
    return
  end
  local leftUp = {
    pos = centerPos + Vector2(0, 1),
    offset = Vector2(-1, 1)
  }
  local leftDown = {
    pos = centerPos + Vector2(0, 0),
    offset = Vector2(-1, -1)
  }
  local rightUp = {
    pos = centerPos + Vector2(1, 1),
    offset = Vector2(1, 1)
  }
  local rightDown = {
    pos = centerPos + Vector2(1, 0),
    offset = Vector2(1, -1)
  }
  local moveInfoList = {}
  if casterDir == Vector2.up then
    moveInfoList[1] = leftUp
    moveInfoList[2] = rightUp
  elseif casterDir == Vector2.down then
    moveInfoList[1] = leftDown
    moveInfoList[2] = rightDown
  elseif casterDir == Vector2.left then
    moveInfoList[1] = leftUp
    moveInfoList[2] = leftDown
  elseif casterDir == Vector2.right then
    moveInfoList[1] = rightUp
    moveInfoList[2] = rightDown
  else
    Log.error("[XForwardToOutside] caster dir error, dir=Vector2( ", casterDir.x, ", ", casterDir.y, " )")
    return
  end
  local attackRange = {}
  for _, moveInfo in ipairs(moveInfoList) do
    local findPos = false
    local curPos = moveInfo.pos
    while not findPos do
      curPos = curPos + moveInfo.offset
      if not self._gridFilter:IsValidPiecePos(curPos) then
        findPos = true
        table.insert(attackRange, curPos)
      end
    end
  end
  local result = SkillScopeResult:New(SkillScopeType.XForwardToOutside, casterPos, attackRange, attackRange)
  return result
end
