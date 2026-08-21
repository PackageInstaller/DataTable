require("scope_base")
_class("SkillScopeCalculator_ColOrRowFinalByEdgePos", SkillScopeCalculator_Base)
SkillScopeCalculator_ColOrRowFinalByEdgePos = SkillScopeCalculator_ColOrRowFinalByEdgePos

function SkillScopeCalculator_ColOrRowFinalByEdgePos:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  local boardSvc = self._gridFilter._world:GetService("BoardLogic")
  local ret = {}
  local maxY = boardSvc:GetCurBoardMaxY()
  local maxX = boardSvc:GetCurBoardMaxX()
  if casterPos.y == maxY then
    boardSvc:InsertListValidPos(ret, Vector2(casterPos.x, 1))
  elseif casterPos.y == 1 then
    boardSvc:InsertListValidPos(ret, Vector2(casterPos.x, maxY))
  elseif casterPos.x == 1 then
    boardSvc:InsertListValidPos(ret, Vector2(maxX, casterPos.y))
  elseif casterPos.x == maxX then
    boardSvc:InsertListValidPos(ret, Vector2(1, casterPos.y))
  end
  local result = SkillScopeResult:New(SkillScopeType.ColOrRowFinalByEdgePos, casterPos, ret, ret)
  return result
end
