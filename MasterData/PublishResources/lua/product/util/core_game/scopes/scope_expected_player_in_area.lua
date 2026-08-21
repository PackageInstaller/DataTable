require("scope_base")
_class("SkillScopeCalculator_ExpectedPlayerInArea", SkillScopeCalculator_Base)
SkillScopeCalculator_ExpectedPlayerInArea = SkillScopeCalculator_ExpectedPlayerInArea

function SkillScopeCalculator_ExpectedPlayerInArea:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
  local world = self._gridFilter._world
  local teamEntity = world:Player():GetLocalTeamEntity()
  local playerPos = teamEntity:GetGridPosition()
  local ret = {}
  local boardServiceLogic = self._gridFilter._world:GetService("BoardLogic")
  local board = self._gridFilter._world:GetBoardEntity():Board()
  local pieceTable = board:ClonePieceTable()
  local playerInArea
  for i, v in ipairs(scopeParam) do
    if playerPos.x >= v.x[1] and playerPos.x <= v.x[2] and playerPos.y >= v.y[1] and playerPos.y <= v.y[2] then
      playerInArea = v
    end
  end
  for x, col in pairs(pieceTable) do
    if x < playerInArea.x[1] or x > playerInArea.x[2] then
      for y, v in pairs(col) do
        if y < playerInArea.y[1] or y > playerInArea.y[2] then
          local grid = Vector2(x, y)
          table.insert(ret, grid)
        end
      end
    end
  end
  local result = SkillScopeResult:New(SkillScopeType.ExpectedPlayerInArea, centerPos, ret, ret)
  return result
end
