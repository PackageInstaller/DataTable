require("scope_base")
_class("SkillScopeCalculator_DoubleCrossLinkLine", SkillScopeCalculator_Base)
SkillScopeCalculator_DoubleCrossLinkLine = SkillScopeCalculator_DoubleCrossLinkLine

function SkillScopeCalculator_DoubleCrossLinkLine:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
  local world = self._gridFilter._world
  local boardServiceLogic = world:GetService("BoardLogic")
  local maxLen = boardServiceLogic:GetCurBoardMaxLen()
  local teamLeader = world:Player():GetCurrentTeamEntity()
  local teamPos = teamLeader:GetGridPosition()
  local cross_area, wholeArea = {}, {}
  local dirPos = casterPos - teamPos
  local x, y
  if dirPos.x > 0 then
    x = 1
  elseif dirPos.x == 0 then
    x = 0
  else
    x = -1
  end
  if 0 < dirPos.y then
    y = 1
  elseif dirPos.y == 0 then
    y = 0
  else
    y = -1
  end
  local dir = Vector2(x, y)
  local blocks = {}
  for i = -maxLen, maxLen do
    local newPos = Vector2(casterPos.x + dir.x * i, casterPos.y + dir.y * i)
    if not table.icontains(blocks, newPos) then
      self:_InsertTargetGrid(cross_area, newPos, wholeArea)
    end
  end
  local result = SkillScopeResult:New(SkillScopeType.DoubleCrossLinkLine, centerPos, cross_area, wholeArea)
  return result
end
