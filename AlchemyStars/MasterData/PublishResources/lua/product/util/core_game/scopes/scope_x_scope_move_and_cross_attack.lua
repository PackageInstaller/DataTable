require("scope_base")
_class("SkillScopeCalculator_XScopeMoveAndCrossAttack", SkillScopeCalculator_Base)
SkillScopeCalculator_XScopeMoveAndCrossAttack = SkillScopeCalculator_XScopeMoveAndCrossAttack

function SkillScopeCalculator_XScopeMoveAndCrossAttack:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  local selectType = scopeParam[1] or 0
  local attackRange = {}
  local wholeRange = {}
  local size = 9
  local target_area_grid = {}
  for i, p in ipairs(bodyArea) do
    table.insert(target_area_grid, Vector2(centerPos.x + p.x, centerPos.y + p.y))
  end
  local world = self._gridFilter._world
  local blockGridTrapPosList = self._gridFilter:GetBlockGridTrapPosList()
  local blockMovePosList = self._gridFilter:GetBlockMovePosList()
  local teamLeader = world:Player():GetCurrentTeamEntity()
  local teamPos = teamLeader:GetGridPosition()
  local blocks = {}
  table.appendArray(blocks, blockGridTrapPosList)
  table.appendArray(blocks, blockMovePosList)
  local cross_area = {}
  local wholeArea = {}
  if self._gridFilter:IsValidPiecePos(centerPos) then
    table.insert(cross_area, centerPos)
    table.insert(wholeArea, centerPos)
  end
  for i, p in ipairs(target_area_grid) do
    local center_x = p.x
    local center_y = p.y
    local leftDownBlocked = false
    local rightDownBlocked = false
    local leftUpBlocked = false
    local rightUpBlocked = false
    for index = 1, size do
      local leftDownPos = Vector2(center_x - index, center_y - index)
      local rightDownPos = Vector2(center_x + index, center_y - index)
      local leftUpPos = Vector2(center_x - index, center_y + index)
      local rightUpPos = Vector2(center_x + index, center_y + index)
      if not leftDownBlocked then
        if not table.icontains(blocks, leftDownPos) then
          self:_InsertTargetGrid(cross_area, leftDownPos, wholeArea)
        else
          leftDownBlocked = true
          self:_InsertTargetGridIntoOneArea(leftDownPos, wholeArea)
        end
      else
        self:_InsertTargetGridIntoOneArea(leftDownPos, wholeArea)
      end
      if not rightDownBlocked then
        if not table.icontains(blocks, rightDownPos) then
          self:_InsertTargetGrid(cross_area, rightDownPos, wholeArea)
        else
          rightDownBlocked = true
          self:_InsertTargetGridIntoOneArea(rightDownPos, wholeArea)
        end
      else
        self:_InsertTargetGridIntoOneArea(rightDownPos, wholeArea)
      end
      if not leftUpBlocked then
        if not table.icontains(blocks, leftUpPos) then
          self:_InsertTargetGrid(cross_area, leftUpPos, wholeArea)
        else
          leftUpBlocked = true
          self:_InsertTargetGridIntoOneArea(leftUpPos, wholeArea)
        end
      else
        self:_InsertTargetGridIntoOneArea(leftUpPos, wholeArea)
      end
      if not rightUpBlocked then
        if not table.icontains(blocks, rightUpPos) then
          self:_InsertTargetGrid(cross_area, rightUpPos, wholeArea)
        else
          rightUpBlocked = true
          self:_InsertTargetGridIntoOneArea(rightUpPos, wholeArea)
        end
      else
        self:_InsertTargetGridIntoOneArea(rightUpPos, wholeArea)
      end
    end
  end
  local result
  if selectType == 0 then
    local targetMovePosList = {}
    local crossExceptBlockParam = {
      9,
      1,
      1
    }
    local crossExceptBlock, wholeExceptBlock = self:_CalcCrossExceptBlock(crossExceptBlockParam, teamPos, bodyArea)
    local canMoveAttackTeamPosList = {}
    for _, pos in ipairs(crossExceptBlock) do
      if table.icontains(cross_area, pos) then
        table.insert(canMoveAttackTeamPosList, pos)
      end
    end
    if 0 < table.count(canMoveAttackTeamPosList) then
      table.appendArray(targetMovePosList, canMoveAttackTeamPosList)
    else
      for _, pos in ipairs(cross_area) do
        if pos.x == teamPos.x or pos.y == teamPos.y then
          table.insert(targetMovePosList, pos)
        end
      end
    end
    local farestPos = centerPos
    if 0 < table.count(targetMovePosList) then
      table.removev(targetMovePosList, centerPos)
    end
    if 0 < table.count(targetMovePosList) then
      farestPos = targetMovePosList[1]
      for _, pos in ipairs(targetMovePosList) do
        local lastPosToTargetPosDistance = Vector2.Distance(farestPos, teamPos)
        local curPosToTargetPosDistance = Vector2.Distance(pos, teamPos)
        if lastPosToTargetPosDistance <= curPosToTargetPosDistance then
          farestPos = pos
        end
      end
    else
      farestPos = centerPos
    end
    result = SkillScopeResult:New(SkillScopeType.XScopeMoveAndCrossAttack, centerPos, {farestPos}, {farestPos})
  elseif selectType == 1 then
    local attackRangeCross = {}
    local attackRangeWhole = {}
    for _, posWholeArea in ipairs(wholeArea) do
      local crossAttackRangeTmp, wholeAttackRangeTmp = self:_CalcCrossExceptBlock(9, posWholeArea, bodyArea)
      for _, pos in ipairs(crossAttackRangeTmp) do
        if not table.intable(attackRangeCross, pos) then
          table.insert(attackRangeCross, pos)
        end
      end
      for _, pos in ipairs(wholeAttackRangeTmp) do
        if not table.intable(attackRangeWhole, pos) then
          table.insert(attackRangeWhole, pos)
        end
      end
    end
    result = SkillScopeResult:New(SkillScopeType.XScopeMoveAndCrossAttack, centerPos, attackRangeCross, attackRangeWhole)
  else
    result = SkillScopeResult:New(SkillScopeType.XScopeMoveAndCrossAttack, centerPos, cross_area, wholeArea)
  end
  return result
end
