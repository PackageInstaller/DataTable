require("scope_base")
_class("SkillScopeCalculator_WalkableGridOnEdge", SkillScopeCalculator_Base)
SkillScopeCalculator_WalkableGridOnEdge = SkillScopeCalculator_WalkableGridOnEdge

function SkillScopeCalculator_WalkableGridOnEdge:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  if not self._gridFilter then
    return SkillScopeResult:New(SkillScopeType.WalkableGridOnEdge, centerPos, {}, {})
  end
  local directionOption = tonumber(scopeParam[1])
  local isCheckEightDir = directionOption == 1
  local onlyCheckEdge = tonumber(scopeParam[2])
  local isOnlyCheckEdge = onlyCheckEdge == 1
  local lbsvc = self._gridFilter._world:GetService("BoardLogic")
  local boardEntity = self._gridFilter._world:GetBoardEntity()
  local cBoard = boardEntity:Board()
  local tv2AttackPos = {}
  local boardMaxX = lbsvc:GetCurBoardMaxX()
  local boardMaxY = lbsvc:GetCurBoardMaxY()
  for x = 1, boardMaxX do
    for y = 1, boardMaxY do
      local posIndex = x * 100 + y
      local v2 = Vector2.New(x, y)
      local v2Relative = v2 - centerPos
      local distanceX, distanceY = cBoard:GetGridEdgeDistanceByPosIndex(posIndex)
      local canInsert = false
      local isEdgeGrid = distanceX == 0 or distanceY == 0
      if isOnlyCheckEdge then
        if isEdgeGrid then
          canInsert = true
        end
      elseif isEdgeGrid then
        local isWalkable = not lbsvc:IsPosBlock(v2, BlockFlag.LinkLine)
        if isWalkable then
          local isNotPieceNone = lbsvc:GetPieceType(v2) ~= PieceType.None
          if isNotPieceNone then
            if isCheckEightDir then
              if self:_IsInEightDir(v2Relative) then
                canInsert = true
              end
            else
              canInsert = true
            end
          end
        end
      end
      if canInsert then
        table.insert(tv2AttackPos, Vector2.New(x, y))
      end
    end
  end
  return SkillScopeResult:New(SkillScopeType.WalkableGridOnEdge, centerPos, tv2AttackPos, tv2AttackPos)
end

function SkillScopeCalculator_WalkableGridOnEdge:_IsInEightDir(v2Relative)
  local isInEightDir = v2Relative ~= Vector2.zero and (math.abs(v2Relative.x) == math.abs(v2Relative.y) or v2Relative.x == 0 or v2Relative.y == 0)
  return isInEightDir
end
