_class("SkillEffectCalc_ScorpionSummon", SkillEffectCalc_Base)
SkillEffectCalc_ScorpionSummon = SkillEffectCalc_ScorpionSummon

function SkillEffectCalc_ScorpionSummon:Constructor(world)
  self._world = world
  self._skillEffectService = self._world:GetService("SkillEffectCalc")
  self._utilScopeSvc = self._world:GetService("UtilScopeCalc")
  self._utilCalcSvc = self._world:GetService("UtilCalc")
  self._utilDataSvc = self._world:GetService("UtilData")
  self._randomSvc = self._world:GetService("RandomLogic")
end

function SkillEffectCalc_ScorpionSummon:DoSkillEffectCalculator(skillEffectCalcParam, notPreview)
  local effectParam = skillEffectCalcParam:GetSkillEffectParam()
  local casterEntity = self._world:GetEntityByID(skillEffectCalcParam:GetCasterEntityID())
  local casterPosition = casterEntity:GetGridPosition()
  local targetCenter
  local targetIDs = skillEffectCalcParam:GetTargetEntityIDs()
  if targetIDs and targetIDs[1] then
    local targetID = targetIDs[1]
    local targetEntity = self._world:GetEntityByID(targetID)
    targetCenter = targetEntity:GridLocation():GetGridPos()
  end
  if not targetCenter then
    return {}
  end
  local results = {}
  local areas = {}
  local monsterIDs = effectParam:GetSummonList()
  local limitCount = effectParam:GetSummonMonsterLimitCount()
  local isOverLimit, existCount = self:_IsOverLimitBefore(monsterIDs[1], limitCount)
  if isOverLimit then
    return results
  end
  local summonType = effectParam:GetScorpionSummonType()
  if summonType then
    if summonType == ScorpionSummonType.ObliqueBack then
      areas = self:_ObliqueBack(targetCenter, casterPosition)
    elseif summonType == ScorpionSummonType.FrontBack then
      areas = self:_FrontBack(targetCenter, casterPosition)
    elseif summonType == ScorpionSummonType.RandomInEight then
      areas = self:_RandomInEight(casterPosition)
    elseif summonType == ScorpionSummonType.RoundSix then
      areas = self:_RoundSix(targetCenter)
    end
  end
  Log.info("ScorpionSummon summonType ", summonType)
  isOverLimit = self:_IsOverLimitAfter(areas, existCount, limitCount)
  if isOverLimit then
    areas = self:_AreasCorrection(areas)
  end
  for _, positions in ipairs(areas) do
    local result = SkillEffectResult_ScorpionSummon:New(SkillEffectEnum_SummonType.Monster, monsterIDs[1], positions)
    table.insert(results, result)
  end
  return results
end

function SkillEffectCalc_ScorpionSummon:_ObliqueBack(targetCenter, center)
  local summonAreas = {
    [1] = {
      {-1, 0},
      {-1, 1},
      {0, 1}
    },
    [2] = {
      {0, 1},
      {1, 1},
      {1, 0}
    },
    [3] = {
      {1, 0},
      {1, -1},
      {0, -1}
    },
    [4] = {
      {0, -1},
      {-1, -1},
      {-1, 0}
    }
  }
  local areaIndex = 0
  if targetCenter.x <= center.x then
    if targetCenter.y > center.y then
      areaIndex = 1
    else
      areaIndex = 4
    end
  elseif targetCenter.y > center.y then
    areaIndex = 2
  else
    areaIndex = 3
  end
  local isVaild = self:_AreaValid(summonAreas[areaIndex], targetCenter)
  if not isVaild then
    local tempAreaIndex = 0
    for _index, value in ipairs(summonAreas) do
      if _index ~= areaIndex then
        isVaild = self:_AreaValid(value, targetCenter)
        if isVaild then
          tempAreaIndex = _index
          break
        end
      end
    end
    areaIndex = tempAreaIndex
  end
  local areas = {}
  if 0 < areaIndex then
    local area = {}
    for _, value in ipairs(summonAreas[areaIndex]) do
      table.insert(area, self:_ToVector2(value, targetCenter))
    end
    table.insert(areas, area)
  end
  return areas
end

function SkillEffectCalc_ScorpionSummon:_AreaValid(offsets, targetCenter)
  if not offsets then
    return false
  end
  for _, offset in ipairs(offsets) do
    local realPosition = self:_ToVector2(offset, targetCenter)
    local isBlock = self._utilDataSvc:IsPosBlock(realPosition, BlockFlag.MonsterFly)
    if isBlock then
      return false
    end
  end
  return true
end

function SkillEffectCalc_ScorpionSummon:_FrontBack(targetCenter, center)
  local summonAreas = {
    [1] = {
      [1] = {
        {-1, 0},
        {-1, 1}
      },
      [2] = {
        {1, 0},
        {1, 1}
      }
    },
    [2] = {
      [1] = {
        {0, 1},
        {1, 1}
      },
      [2] = {
        {0, -1},
        {1, -1}
      }
    }
  }
  local index = 0
  local anchor = Vector2(targetCenter.x, targetCenter.y)
  if targetCenter.x < center.x or 1 < targetCenter.x - center.x then
    index = 1
    anchor.y = center.y
  else
    index = 2
    anchor.x = center.x
  end
  local areas = {}
  local tempAreas = summonAreas[index]
  for _, tempArea in ipairs(tempAreas) do
    local isValid = self:_AreaValid(tempArea, anchor)
    if isValid then
      local area = {}
      for _, offset in ipairs(tempArea) do
        local realPosition = self:_ToVector2(offset, anchor)
        table.insert(area, realPosition)
      end
      table.insert(areas, area)
    end
  end
  return areas
end

function SkillEffectCalc_ScorpionSummon:_RandomInEight(center)
  local areas = {}
  local summonAreas = {
    [DirectionType.LeftUp] = {
      {-1, 0},
      {-1, 1},
      {0, 1}
    },
    [DirectionType.RightUp] = {
      {0, 1},
      {1, 1},
      {1, 0}
    },
    [DirectionType.LeftDown] = {
      {-1, 0},
      {-1, -1},
      {0, -1}
    },
    [DirectionType.RightDown] = {
      {0, -1},
      {1, -1},
      {1, 0}
    },
    [DirectionType.Up] = {
      {0, 1},
      {1, 1}
    },
    [DirectionType.Down] = {
      {0, -1},
      {1, -1}
    },
    [DirectionType.Left] = {
      {-1, 0},
      {-1, 1}
    },
    [DirectionType.Right] = {
      {1, 0},
      {1, 1}
    }
  }
  local validDirections = {}
  for direction = DirectionType.Up, DirectionType.RightDown do
    local anchor = self:_GetAnchorByDirectionType(direction, center)
    local isValid = self:_AreaValid(summonAreas[direction], anchor)
    if isValid then
      table.insert(validDirections, direction)
    end
  end
  if #validDirections <= 0 then
    return areas
  end
  local firstIndex = self._randomSvc:LogicRand(1, #validDirections)
  local direction = validDirections[firstIndex]
  local anchor = self:_GetAnchorByDirectionType(direction, center)
  local firstOffsets = summonAreas[direction]
  areas = self:_InsertArea(areas, firstOffsets, anchor)
  if 2 <= #validDirections then
    table.remove(validDirections, firstIndex)
    local validDirections2 = {}
    for _, _direction in ipairs(validDirections) do
      local offsets = summonAreas[_direction]
      if not self:_IsOverlap(offsets, firstOffsets) then
        table.insert(validDirections2, _direction)
      end
    end
    if 0 < #validDirections2 then
      local secondIndex = self._randomSvc:LogicRand(1, #validDirections2)
      direction = validDirections2[secondIndex]
      local anchor = self:_GetAnchorByDirectionType(direction, center)
      local secondOffsets = summonAreas[direction]
      areas = self:_InsertArea(areas, secondOffsets, anchor)
    end
  end
  return areas
end

function SkillEffectCalc_ScorpionSummon:_IsOverlap(area1, area2)
  for _, position in ipairs(area1) do
    for _, _position in ipairs(area2) do
      if position[1] == _position[1] and position[2] == _position[2] then
        return true
      end
    end
  end
  return false
end

function SkillEffectCalc_ScorpionSummon:_InsertArea(areas, offsets, center)
  local area = {}
  for _, offset in ipairs(offsets) do
    local realPosition = self:_ToVector2(offset, center)
    table.insert(area, realPosition)
  end
  table.insert(areas, area)
  return areas
end

function SkillEffectCalc_ScorpionSummon:_GetAnchorByDirectionType(directionType, center)
  local anchor = Vector2(center.x, center.y)
  if directionType == DirectionType.LeftUp or directionType == DirectionType.Up then
    anchor.y = anchor.y + 1
  elseif directionType == DirectionType.RightUp then
    anchor.x = anchor.x + 1
    anchor.y = anchor.y + 1
  elseif directionType == DirectionType.RightDown or directionType == DirectionType.Right then
    anchor.x = anchor.x + 1
  end
  return anchor
end

function SkillEffectCalc_ScorpionSummon:_RoundSix(targetCeneter)
  local summonAreas = {
    [1] = {
      [1] = {
        {-1, 0},
        {-1, 1},
        {0, 1}
      },
      [2] = {
        {1, 0},
        {1, -1},
        {0, -1}
      }
    },
    [2] = {
      [1] = {
        {0, -1},
        {-1, -1},
        {-1, 0}
      },
      [2] = {
        {0, 1},
        {1, 1},
        {1, 0}
      }
    }
  }
  local weights = {0, 0}
  local tempAreas = {
    {},
    {}
  }
  for areaIndex, areas in ipairs(summonAreas) do
    for _, area in ipairs(areas) do
      local vaild = self:_AreaValid(area, targetCeneter)
      if vaild then
        weights[areaIndex] = weights[areaIndex] + 1
        table.insert(tempAreas[areaIndex], area)
      end
    end
  end
  local areas = {}
  if 0 >= weights[1] + weights[2] then
    return areas
  end
  local index = 1
  if weights[2] > weights[1] then
    index = 2
  end
  for _, tempArea in ipairs(tempAreas[index]) do
    local area = {}
    for _, offset in ipairs(tempArea) do
      local realPosition = self:_ToVector2(offset, targetCeneter)
      table.insert(area, realPosition)
    end
    table.insert(areas, area)
  end
  return areas
end

function SkillEffectCalc_ScorpionSummon:_ToVector2(offset, position)
  return Vector2(position.x + offset[1], position.y + offset[2])
end

function SkillEffectCalc_ScorpionSummon:_IsOverLimitBefore(monsterID, limitCount)
  local count = 0
  if limitCount and 0 < limitCount then
    local monsterGroup = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
    if monsterGroup then
      for _, monsterEntity in ipairs(monsterGroup:GetEntities()) do
        if not monsterEntity:HasDeadMark() then
          local id = monsterEntity:MonsterID():GetMonsterID()
          if id == monsterID then
            count = count + 1
          end
          if limitCount <= count then
            return true, count
          end
        end
      end
    end
  end
  return false, count
end

function SkillEffectCalc_ScorpionSummon:_IsOverLimitAfter(areas, existCount, limitCount)
  local count = 0
  for _, area in pairs(areas) do
    for _, position in pairs(area) do
      count = count + 1
    end
  end
  return limitCount <= count + existCount
end

function SkillEffectCalc_ScorpionSummon:_AreasCorrection(areas)
  local minCount = 99
  local minIndex = 0
  for index, area in pairs(areas) do
    local count = 0
    for _, position in pairs(area) do
      count = count + 1
    end
    if minCount >= count then
      minCount = count
      minIndex = index
    end
  end
  return {
    areas[minIndex]
  }
end
