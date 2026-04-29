require("scope_base")
_class("SkillScopeCalculator_CanMovePos", SkillScopeCalculator_Base)
SkillScopeCalculator_CanMovePos = SkillScopeCalculator_CanMovePos

function SkillScopeCalculator_CanMovePos:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
  local target_area_grid = {}
  local world = self._gridFilter._world
  if world then
    local boardServiceLogic = world:GetService("BoardLogic")
    local board = world:GetBoardEntity():Board()
    local invalidPos
    if world:MatchType() == MatchType.MT_BlackFist then
      local enemy = casterEntity:Pet():GetOwnerTeamEntity():Team():GetEnemyTeamEntity()
      invalidPos = enemy:GetGridPosition()
    end
    local arr = board:GetBlockFlagArray()
    for x, columnDic in pairs(arr) do
      for y, curGridType in pairs(columnDic) do
        local grid = Vector2(x, y)
        if not boardServiceLogic:IsPosBlock(grid, BlockFlag.LinkLine) and grid ~= invalidPos then
          table.insert(target_area_grid, grid)
        end
      end
    end
  else
    for x = 1, self._gridFilter:GetBoardMaxX() do
      for y = 1, self._gridFilter:GetBoardMaxY() do
        local pos = Vector2(x, y)
        if self._gridFilter:IsValidPiecePos(pos) then
          table.insert(target_area_grid, pos)
        end
      end
    end
  end
  local result = SkillScopeResult:New(SkillScopeType.CanMovePos, centerPos, target_area_grid, target_area_grid)
  return result
end
