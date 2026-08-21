require("scope_base")
_class("SkillScopeCalculator_ChessKnight", SkillScopeCalculator_Base)
SkillScopeCalculator_ChessKnight = SkillScopeCalculator_ChessKnight
SkillScopeCalculator_ChessKnight.RangeMap = {
  Vector2.New(1, 2),
  Vector2.New(2, 1),
  Vector2.New(2, -1),
  Vector2.New(1, -2),
  Vector2.New(-1, 2),
  Vector2.New(-2, 1),
  Vector2.New(-2, -1),
  Vector2.New(-1, -2)
}

function SkillScopeCalculator_ChessKnight:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  local attackRange = {}
  local wholeRange = {}
  for _, v2Relative in ipairs(SkillScopeCalculator_ChessKnight.RangeMap) do
    local v2 = centerPos + v2Relative
    table.insert(wholeRange, v2)
    if self._gridFilter:IsValidPiecePos(v2) then
      table.insert(attackRange, v2)
    end
  end
  local result = SkillScopeResult:New(SkillScopeType.ChessKnight, centerPos, attackRange, wholeRange)
  if not scopeParam or table.count(scopeParam) == 0 then
    return result
  end
  local selectNearestFormTeam = scopeParam[1] or 0
  local extendScopeType = scopeParam[2] or 0
  local extendScopeParam = scopeParam[3] or 0
  local selectNearestChess = scopeParam[4] or 0
  local world = self._gridFilter._world
  if 0 < selectNearestFormTeam then
    local targetPos
    if selectNearestChess == 0 then
      local teamLeader = world:Player():GetCurrentTeamEntity()
      targetPos = teamLeader:GetGridPosition()
    else
      local group = world:GetGroup(world.BW_WEMatchers.ChessPet)
      local targetEntityList = {}
      for i, e in ipairs(group:GetEntities()) do
        table.insert(targetEntityList, e)
      end
      if table.count(targetEntityList) > 0 then
        table.sort(targetEntityList, function(a, b)
          local posA = a:GetGridPosition()
          local posB = b:GetGridPosition()
          local disA = Vector2.Distance(casterPos, posA)
          local disB = Vector2.Distance(casterPos, posB)
          return disA < disB
        end)
        targetPos = targetEntityList[1]:GetGridPosition()
      end
    end
    if table.count(attackRange) > 0 then
      table.sort(attackRange, function(a, b)
        local disA = Vector2.Distance(targetPos, a)
        local disB = Vector2.Distance(targetPos, b)
        return disA < disB
      end)
    end
    local attackRangeResult = {}
    if selectNearestFormTeam == 1 then
      attackRangeResult = {
        attackRange[1]
      }
    elseif selectNearestFormTeam == 2 then
      local blockMovePosList = self._gridFilter:GetBlockMovePosList()
      table.removev(blockMovePosList, targetPos)
      for _, pos in ipairs(attackRange) do
        if self._gridFilter:IsValidPiecePos(pos) and not table.icontains(blockMovePosList, pos) then
          for _, offset in ipairs(Offset8) do
            local workPos = Vector2(pos.x + offset[1], pos.y + offset[2])
            if self._gridFilter:IsValidPiecePos(workPos) and not table.icontains(blockMovePosList, workPos) then
              attackRangeResult = {pos}
              break
            end
          end
          if table.count(attackRangeResult) > 0 then
            break
          end
        end
      end
      if table.count(attackRangeResult) == 0 then
        attackRangeResult = {centerPos}
      end
    end
    result = SkillScopeResult:New(SkillScopeType.ChessKnight, centerPos, attackRangeResult, attackRangeResult)
  end
  if extendScopeType ~= 0 then
    local attackRangeExtend = {}
    local wholeRangeExtend = {}
    for _, pos in ipairs(attackRange) do
      local extend_result = self._hub:ComputeScopeRange(extendScopeType, extendScopeParam, pos, bodyArea, casterDir, nTargetType, pos)
      local extend_range = extend_result:GetAttackRange()
      local extend_whole_range = extend_result:GetWholeGridRange()
      table.appendArray(attackRangeExtend, extend_range)
      table.appendArray(wholeRangeExtend, extend_whole_range)
    end
    result = SkillScopeResult:New(SkillScopeType.ChessKnight, centerPos, attackRangeExtend, wholeRangeExtend)
  end
  return result
end
