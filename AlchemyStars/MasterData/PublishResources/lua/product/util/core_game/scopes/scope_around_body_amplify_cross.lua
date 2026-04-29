require("scope_base")
_class("SkillScopeCalculator_AroundBodyAmplifyCross", SkillScopeCalculator_Base)
SkillScopeCalculator_AroundBodyAmplifyCross = SkillScopeCalculator_AroundBodyAmplifyCross

function SkillScopeCalculator_AroundBodyAmplifyCross:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  local casterPos = centerPos
  local bodyAreaArray = bodyArea
  local expansionCount = scopeParam[1]
  local size = scopeParam[2]
  local forDash = scopeParam[3]
  local dashCheckTeam = scopeParam[4]
  local wholeArea = {}
  local cross_area = {}
  local areaPos = {}
  local targetArea = {}
  for i, area in ipairs(bodyAreaArray) do
    table.insert(areaPos, casterPos + area)
  end
  for i, v in ipairs(areaPos) do
    local posList = self:_GetAroundPosOfPos(v, expansionCount)
    for j, jv in ipairs(posList) do
      if not table.icontains(areaPos, jv) then
        self:_InsertTargetGrid(targetArea, jv, wholeArea)
      end
    end
  end
  local checkForDash = false
  if forDash and forDash == 1 then
    checkForDash = true
  end
  local teamEntity
  local world = self._gridFilter._world
  if world then
    teamEntity = world:Player():GetLocalTeamEntity()
  end
  local upMaxStep = size
  local downMaxStep = size
  local leftMaxStep = size
  local rightMaxStep = size
  local minX = -1
  local maxX = -1
  local minY = -1
  local maxY = -1
  if checkForDash then
    local extraInvalidPosList = {}
    if dashCheckTeam and dashCheckTeam == 1 and teamEntity then
      local teamPos = teamEntity:GetGridPosition()
      table.insert(extraInvalidPosList, teamPos)
    end
    upMaxStep, maxY = self:_CalcMaxStepForDash(casterPos, bodyAreaArray, Vector2.up, size, extraInvalidPosList)
    downMaxStep, minY = self:_CalcMaxStepForDash(casterPos, bodyAreaArray, Vector2.down, size, extraInvalidPosList)
    leftMaxStep, minX = self:_CalcMaxStepForDash(casterPos, bodyAreaArray, Vector2.left, size, extraInvalidPosList)
    rightMaxStep, maxX = self:_CalcMaxStepForDash(casterPos, bodyAreaArray, Vector2.right, size, extraInvalidPosList)
  end
  for i, p in ipairs(targetArea) do
    local center_x = p.x
    local center_y = p.y
    for index = 1, size do
      if index <= upMaxStep then
        local upPos = Vector2(center_x, center_y + index)
        local inLimit = true
        if 0 < maxY and maxY < upPos.y then
          inLimit = false
        end
        if inLimit then
          if not table.intable(wholeArea, upPos) then
            table.insert(wholeArea, upPos)
          end
          if self._gridFilter:IsValidPiecePos(upPos) and not table.intable(cross_area, upPos) then
            table.insert(cross_area, upPos)
          end
        end
      end
      if index <= downMaxStep then
        local downPos = Vector2(center_x, center_y - index)
        local inLimit = true
        if 0 < minY and minY > downPos.y then
          inLimit = false
        end
        if inLimit then
          if not table.intable(wholeArea, downPos) then
            table.insert(wholeArea, downPos)
          end
          if self._gridFilter:IsValidPiecePos(downPos) and not table.intable(cross_area, downPos) then
            table.insert(cross_area, downPos)
          end
        end
      end
      if index <= leftMaxStep then
        local leftPos = Vector2(center_x - index, center_y)
        local inLimit = true
        if 0 < minX and minX > leftPos.x then
          inLimit = false
        end
        if inLimit then
          if not table.intable(wholeArea, leftPos) then
            table.insert(wholeArea, leftPos)
          end
          if self._gridFilter:IsValidPiecePos(leftPos) and not table.intable(cross_area, leftPos) then
            table.insert(cross_area, leftPos)
          end
        end
      end
      if index <= rightMaxStep then
        local rightPos = Vector2(center_x + index, center_y)
        local inLimit = true
        if 0 < maxX and minX < rightPos.x then
          inLimit = false
        end
        if inLimit then
          if not table.intable(wholeArea, rightPos) then
            table.insert(wholeArea, rightPos)
          end
          if self._gridFilter:IsValidPiecePos(rightPos) and not table.intable(cross_area, rightPos) then
            table.insert(cross_area, rightPos)
          end
        end
      end
    end
  end
  local result = SkillScopeResult:New(SkillScopeType.AroundBodyAmplifyCross, casterPos, cross_area, wholeArea)
  return result
end

function SkillScopeCalculator_AroundBodyAmplifyCross:_CalcMaxStepForDash(casterPos, bodyArea, dir, maxStep, extraInvalidPosList)
  local validStep = 0
  local posNew = casterPos
  for i = 0, maxStep do
    posNew = casterPos + dir * i
    local isValid = true
    for offIndex, offPos in ipairs(bodyArea) do
      local checkPos = posNew + offPos
      if not self._gridFilter:IsValidPiecePos(checkPos) or table.icontains(extraInvalidPosList) then
        isValid = false
        break
      end
    end
    if isValid then
      validStep = i
    else
      break
    end
  end
  local limitVal = -1
  local finalPos = casterPos + dir * validStep
  for offIndex, offPos in ipairs(bodyArea) do
    local checkPos = finalPos + offPos
    if dir == Vector2.up then
      local y = checkPos.y
      if limitVal == -1 or limitVal < y then
        limitVal = y
      end
    elseif dir == Vector2.down then
      local y = checkPos.y
      if limitVal == -1 or limitVal > y then
        limitVal = y
      end
    elseif dir == Vector2.left then
      local x = checkPos.x
      if limitVal == -1 or limitVal > x then
        limitVal = x
      end
    elseif dir == Vector2.right then
      local x = checkPos.x
      if limitVal == -1 or limitVal < x then
        limitVal = x
      end
    end
  end
  return validStep, limitVal
end
