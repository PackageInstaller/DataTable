require("scope_base")
_class("SkillScopeCalculator_PickUpDoubleCrossBlocked", SkillScopeCalculator_Base)
SkillScopeCalculator_PickUpDoubleCrossBlocked = SkillScopeCalculator_PickUpDoubleCrossBlocked

function SkillScopeCalculator_PickUpDoubleCrossBlocked:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
  if #centerPos == 0 then
    centerPos = {centerPos}
  end
  local blockType = scopeParam and GetBlockFlagByValue(scopeParam[1]) or BlockFlag.Skill
  local blocks = self._gridFilter:GetBlockGridTrapPosList(blockType)
  local world = self._gridFilter._world
  if world:MatchType() == MatchType.MT_BlackFist and scopeParam and casterEntity then
    local enemyEntity = casterEntity:Pet():GetOwnerTeamEntity():Team():GetEnemyTeamEntity()
    if scopeParam[1] == 1 then
      table.insert(blocks, enemyEntity:GetGridPosition())
    end
  end
  local boardServiceLogic = world:GetService("BoardLogic")
  local maxLen = boardServiceLogic:GetCurBoardMaxLen()
  local cross_area = {}
  local wholeArea = {}
  local length = maxLen
  for _, pos in ipairs(centerPos) do
    local type = self:GetDirection(pos, casterPos)
    if type == HitBackDirectionType.RightDown then
      local rightDownBlocked = false
      for i = 1, length do
        local rightDownPos = Vector2(casterPos.x + i, casterPos.y - i)
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
      end
    elseif type == HitBackDirectionType.LeftDown then
      local leftDownBlocked = false
      for i = 1, length do
        local leftDownPos = Vector2(casterPos.x - i, casterPos.y - i)
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
      end
    elseif type == HitBackDirectionType.LeftUp then
      local leftUpBlocked = false
      for i = 1, length do
        local leftUpPos = Vector2(casterPos.x - i, casterPos.y + i)
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
      end
    elseif type == HitBackDirectionType.RightUp then
      local rightUpBlocked = false
      for i = 1, length do
        local rightUpPos = Vector2(casterPos.x + i, casterPos.y + i)
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
    elseif type == HitBackDirectionType.Right then
      local rightBlocked = false
      for i = 1, length do
        local rightPos = Vector2(casterPos.x + i, casterPos.y)
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
    elseif type == HitBackDirectionType.Left then
      local leftBlocked = false
      for i = 1, length do
        local leftPos = Vector2(casterPos.x - i, casterPos.y)
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
      end
    elseif type == HitBackDirectionType.Down then
      local downBlocked = false
      for i = 1, length do
        local downPos = Vector2(casterPos.x, casterPos.y - i)
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
      end
    elseif type == HitBackDirectionType.Up then
      local upBlocked = false
      for i = 1, length do
        local upPos = Vector2(casterPos.x, casterPos.y + i)
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
      end
    end
  end
  local result = SkillScopeResult:New(SkillScopeType.PickUpDoubleCrossBlocked, centerPos, cross_area, wholeArea)
  return result
end
