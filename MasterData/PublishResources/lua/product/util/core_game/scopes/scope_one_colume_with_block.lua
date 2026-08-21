require("scope_base")
_class("SkillScopeCalculator_OneColumeWithBlock", SkillScopeCalculator_Base)
SkillScopeCalculator_OneColumeWithBlock = SkillScopeCalculator_OneColumeWithBlock

function SkillScopeCalculator_OneColumeWithBlock:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  local casterPos = centerPos
  local targetArea = {}
  local wholeArea = {}
  local posA = Vector2.New(casterPos.x, 0)
  self:_CalcHitBackOnDir(casterPos, posA, self._gridFilter, wholeArea, targetArea)
  local boardMaxY = BattleConst.DefaultMaxY
  if self._gridFilter._world then
    local boardServiceLogic = self._gridFilter._world:GetService("BoardLogic")
    boardMaxY = boardServiceLogic:GetCurBoardMaxY()
  end
  local posB = Vector2.New(casterPos.x, boardMaxY)
  self:_CalcHitBackOnDir(casterPos, posB, self._gridFilter, wholeArea, targetArea)
  return SkillScopeResult:New(SkillScopeType.OneColumeWithBlock, casterPos, targetArea, wholeArea)
end
