require("scope_base")
_class("SkillScopeCalculator_BoardEdgeDirectLineBlock", SkillScopeCalculator_Base)
SkillScopeCalculator_BoardEdgeDirectLineBlock = SkillScopeCalculator_BoardEdgeDirectLineBlock

function SkillScopeCalculator_BoardEdgeDirectLineBlock:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  local params = scopeParam
  local directionX = params[1]
  local directionY = params[2]
  local size = params[3] or 1
  local calcBlockPos = params[4] or 0
  local blockFlag = BlockFlag.MonsterFly
  local direction = Vector2(directionX, directionY)
  local world = self._gridFilter._world
  local boardLogicService = world:GetService("BoardLogic")
  local boardMaxX = boardLogicService:GetCurBoardMaxX()
  local boardMaxY = boardLogicService:GetCurBoardMaxY()
  local boardEdgePosList = {}
  if direction == Vector2(0, 1) then
    for i = 1, boardMaxX do
      local posWork = Vector2(i, 1)
      table.insert(boardEdgePosList, posWork)
    end
  elseif direction == Vector2(0, -1) then
    for i = 1, boardMaxX do
      local posWork = Vector2(i, boardMaxY)
      table.insert(boardEdgePosList, posWork)
    end
  elseif direction == Vector2(1, 0) then
    for i = 1, boardMaxY do
      local posWork = Vector2(1, i)
      table.insert(boardEdgePosList, posWork)
    end
  elseif direction == Vector2(-1, 0) then
    for i = 1, boardMaxY do
      local posWork = Vector2(boardMaxX, i)
      table.insert(boardEdgePosList, posWork)
    end
  end
  local utilDataCalcSvc = world:GetService("UtilData")
  local teamLeader = world:Player():GetCurrentTeamEntity()
  local teamPos = teamLeader:GetGridPosition()
  local range = {}
  local wholeArea = {}
  for _, pos in ipairs(boardEdgePosList) do
    for index = 1, size do
      local isBlock = false
      local posWork = Vector2(pos.x + direction.x * (index - 1), pos.y + direction.y * (index - 1))
      if utilDataCalcSvc:IsValidPiecePos(posWork) then
        local isPosBlock = self._gridFilter:IsPosBlock(posWork, BlockFlag.MonsterLand)
        if posWork ~= teamPos and posWork ~= casterPos and isPosBlock and calcBlockPos == 0 then
          break
        end
        table.insert(range, posWork)
        table.insert(wholeArea, posWork)
        if posWork ~= teamPos and posWork ~= casterPos and isPosBlock and calcBlockPos == 1 then
          break
        end
      end
    end
  end
  local result = SkillScopeResult:New(SkillScopeType.BoardEdgeDirectLineBlock, centerPos, range, range)
  return result
end
