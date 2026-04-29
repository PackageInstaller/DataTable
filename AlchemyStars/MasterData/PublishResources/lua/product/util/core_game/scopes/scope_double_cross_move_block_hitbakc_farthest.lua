require("scope_base")
_class("SkillScopeCalculator_DoubleCrossMoveBlockHitBackFarthest", SkillScopeCalculator_Base)
SkillScopeCalculator_DoubleCrossMoveBlockHitBackFarthest = SkillScopeCalculator_DoubleCrossMoveBlockHitBackFarthest

function SkillScopeCalculator_DoubleCrossMoveBlockHitBackFarthest:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
  local size = scopeParam[1]
  local useTeleport = scopeParam[2] or 0
  local target_area_grid = {}
  for i, p in ipairs(bodyArea) do
    table.insert(target_area_grid, Vector2(centerPos.x + p.x, centerPos.y + p.y))
  end
  local blockGridTrapPosList = self._gridFilter:GetBlockGridTrapPosList()
  local blockMovePosList = self._gridFilter:GetBlockMovePosList()
  local world = self._gridFilter._world
  local teamEntity = world:Player():GetCurrentTeamEntity()
  local teamPos = teamEntity:GetGridPosition()
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
    local leftDownBlocked = false
    local rightDownBlocked = false
    local leftUpBlocked = false
    local rightUpBlocked = false
    for index = 1, size do
      local upPos = Vector2(center_x, center_y + index)
      local downPos = Vector2(center_x, center_y - index)
      local leftPos = Vector2(center_x - index, center_y)
      local rightPos = Vector2(center_x + index, center_y)
      local leftDownPos = Vector2(center_x - index, center_y - index)
      local rightDownPos = Vector2(center_x + index, center_y - index)
      local leftUpPos = Vector2(center_x - index, center_y + index)
      local rightUpPos = Vector2(center_x + index, center_y + index)
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
  table.insert(cross_area, centerPos)
  table.insert(wholeArea, centerPos)
  local teamAroundPos = {}
  for x = -1, 1 do
    for y = -1, 1 do
      local pos = Vector2(teamPos.x + x, teamPos.y + y)
      if pos.x ~= teamPos.x or pos.y ~= teamPos.y then
        self:_InsertTargetGrid(teamAroundPos, pos, wholeArea)
      end
    end
  end
  local real_area = {}
  for i, pos in ipairs(cross_area) do
    if table.Vector2Include(teamAroundPos, pos) then
      table.insert(real_area, pos)
    end
  end
  cross_area = {}
  wholeArea = {}
  if 0 < table.count(real_area) then
    local utilCalc = world:GetService("UtilCalc")
    local pos = utilCalc:GetHitBackPlayerFarthestPos(real_area, casterEntity, HitBackDirectionType.EightDir, teamEntity)
    cross_area = pos
    wholeArea = pos
  end
  local result = SkillScopeResult:New(SkillScopeType.DoubleCrossMoveBlockHitBackFarthest, centerPos, cross_area, wholeArea)
  return result
end
