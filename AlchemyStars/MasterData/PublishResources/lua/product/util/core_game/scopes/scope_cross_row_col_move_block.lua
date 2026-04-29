require("scope_base")
_class("SkillScopeCalculator_CrossRowColMoveBlock", SkillScopeCalculator_Base)
SkillScopeCalculator_CrossRowColMoveBlock = SkillScopeCalculator_CrossRowColMoveBlock

function SkillScopeCalculator_CrossRowColMoveBlock:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  local size = scopeParam[1]
  local useTeleport = scopeParam[2] or 0
  local target_area_grid = {}
  for i, p in ipairs(bodyArea) do
    table.insert(target_area_grid, Vector2(centerPos.x + p.x, centerPos.y + p.y))
  end
  local world = self._gridFilter._world
  local blockGridTrapPosList = self._gridFilter:GetBlockGridTrapPosList()
  local blockMovePosList = self._gridFilter:GetBlockMovePosList()
  local teamLeader = world:Player():GetCurrentTeamEntity()
  local teamPos = teamLeader:GetGridPosition()
  table.removev(blockMovePosList, teamPos)
  local blocks = {}
  table.appendArray(blocks, blockGridTrapPosList)
  table.appendArray(blocks, blockMovePosList)
  local cross_area = {}
  local wholeArea = {}
  for i, p in ipairs(target_area_grid) do
    local center_x = p.x
    local center_y = p.y
    local upBlocked = false
    local downBlocked = false
    local leftBlocked = false
    local rightBlocked = false
    for index = 1, size do
      local upPos = Vector2(center_x, center_y + index)
      local downPos = Vector2(center_x, center_y - index)
      local leftPos = Vector2(center_x - index, center_y)
      local rightPos = Vector2(center_x + index, center_y)
      if not upBlocked then
        if not table.icontains(blocks, upPos) then
          self:_InsertTargetGrid(cross_area, upPos, wholeArea)
        else
          upBlocked = true
          self:_InsertTargetGridIntoOneArea(upPos, wholeArea)
        end
      else
        self:_InsertTargetGridIntoOneArea(upPos, wholeArea)
      end
      if not downBlocked then
        if not table.icontains(blocks, downPos) then
          self:_InsertTargetGrid(cross_area, downPos, wholeArea)
        else
          downBlocked = true
          self:_InsertTargetGridIntoOneArea(downPos, wholeArea)
        end
      else
        self:_InsertTargetGridIntoOneArea(downPos, wholeArea)
      end
      if not leftBlocked then
        if not table.icontains(blocks, leftPos) then
          self:_InsertTargetGrid(cross_area, leftPos, wholeArea)
        else
          leftBlocked = true
          self:_InsertTargetGridIntoOneArea(leftPos, wholeArea)
        end
      else
        self:_InsertTargetGridIntoOneArea(leftPos, wholeArea)
      end
      if not rightBlocked then
        if not table.icontains(blocks, rightPos) then
          self:_InsertTargetGrid(cross_area, rightPos, wholeArea)
        else
          rightBlocked = true
          self:_InsertTargetGridIntoOneArea(rightPos, wholeArea)
        end
      else
        self:_InsertTargetGridIntoOneArea(rightPos, wholeArea)
      end
    end
  end
  table.insert(cross_area, centerPos)
  table.insert(wholeArea, centerPos)
  if useTeleport == 0 then
    local useTeleportResult = SkillScopeResult:New(SkillScopeType.CrossRowColMoveBlock, centerPos, cross_area, wholeArea)
    return useTeleportResult
  end
  local result
  if table.intable(cross_area, teamPos) then
    table.removev(cross_area, teamPos)
    local nearestPos = centerPos
    for _, pos in ipairs(cross_area) do
      local lastPosToTargetPosDistance = Vector2.Distance(nearestPos, teamPos)
      local curPosToTargetPosDistance = Vector2.Distance(pos, teamPos)
      if lastPosToTargetPosDistance > curPosToTargetPosDistance then
        nearestPos = pos
      end
    end
    result = SkillScopeResult:New(SkillScopeType.CrossRowColMoveBlock, centerPos, {nearestPos}, {nearestPos})
  else
    local rowOrColPos
    local targetMovePosList = {}
    for _, pos in ipairs(cross_area) do
      if pos.x == teamPos.x or pos.y == teamPos.y then
        table.insert(targetMovePosList, pos)
      end
    end
    local nearestPos = Vector2(99, 99)
    if 0 < table.count(targetMovePosList) then
      for _, pos in ipairs(targetMovePosList) do
        local lastPosToTargetPosDistance = Vector2.Distance(nearestPos, teamPos)
        local curPosToTargetPosDistance = Vector2.Distance(pos, teamPos)
        if lastPosToTargetPosDistance > curPosToTargetPosDistance then
          nearestPos = pos
        end
      end
    else
      for _, pos in ipairs(cross_area) do
        local lastPosToTargetPosDistance = Vector2.Distance(nearestPos, teamPos)
        local curPosToTargetPosDistance = Vector2.Distance(pos, teamPos)
        if lastPosToTargetPosDistance > curPosToTargetPosDistance then
          nearestPos = pos
        end
      end
    end
    result = SkillScopeResult:New(SkillScopeType.CrossRowColMoveBlock, centerPos, {nearestPos}, {nearestPos})
  end
  return result
end
