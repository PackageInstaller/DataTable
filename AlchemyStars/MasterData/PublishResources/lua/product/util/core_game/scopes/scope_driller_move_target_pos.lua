require("scope_base")
_class("SkillScopeCalculator_DrillerMoveTargetPos", SkillScopeCalculator_Base)
SkillScopeCalculator_DrillerMoveTargetPos = SkillScopeCalculator_DrillerMoveTargetPos

function SkillScopeCalculator_DrillerMoveTargetPos:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
  local world = self._hub._gridFilter._world
  local utilScopeSvc = world:GetService("UtilScopeCalc")
  local utilData = world:GetService("UtilData")
  local randomSvc = world:GetService("RandomLogic")
  local trapIDList = scopeParam.trapIDList
  local resultPosList = {}
  self._areas = {
    {
      min_x = 1,
      max_x = 3,
      min_y = 1,
      max_y = 3,
      center_x = 2,
      center_y = 2
    },
    {
      min_x = 1,
      max_x = 3,
      min_y = 4,
      max_y = 6,
      center_x = 2,
      center_y = 5
    },
    {
      min_x = 1,
      max_x = 3,
      min_y = 7,
      max_y = 9,
      center_x = 2,
      center_y = 8
    },
    {
      min_x = 4,
      max_x = 6,
      min_y = 1,
      max_y = 3,
      center_x = 5,
      center_y = 2
    },
    {
      min_x = 4,
      max_x = 6,
      min_y = 4,
      max_y = 6,
      center_x = 5,
      center_y = 5
    },
    {
      min_x = 4,
      max_x = 6,
      min_y = 7,
      max_y = 9,
      center_x = 5,
      center_y = 8
    },
    {
      min_x = 7,
      max_x = 9,
      min_y = 1,
      max_y = 3,
      center_x = 8,
      center_y = 2
    },
    {
      min_x = 7,
      max_x = 9,
      min_y = 4,
      max_y = 6,
      center_x = 8,
      center_y = 5
    },
    {
      min_x = 7,
      max_x = 9,
      min_y = 7,
      max_y = 9,
      center_x = 8,
      center_y = 8
    }
  }
  local areaTrapCount = self:_CalcAreasTrapCount(trapIDList, casterPos)
  local minAreas = self:_FindMinTrapAreas(areaTrapCount)
  local tarPos = self:_CalcTarPosInMinAreas(minAreas, casterPos)
  table.insert(resultPosList, tarPos)
  local result = SkillScopeResult:New(SkillScopeType.DrillerMoveTargetPos, centerPos, resultPosList, resultPosList)
  return result
end

function SkillScopeCalculator_DrillerMoveTargetPos:_CheckPosHasTrap(pos, trapIDList)
  local bFindTrap = false
  local world = self._gridFilter._world
  local utilSvc = world:GetService("UtilData")
  local array = utilSvc:GetTrapsAtPos(pos)
  for _, eTrap in ipairs(array) do
    local cTrap = eTrap:Trap()
    if cTrap and not eTrap:HasDeadMark() and table.icontains(trapIDList, cTrap:GetTrapID()) then
      bFindTrap = true
      break
    end
  end
  return bFindTrap
end

function SkillScopeCalculator_DrillerMoveTargetPos:_CalcAreasTrapCount(trapIDList, casterPos)
  local areaTrapCount = {}
  for areaIndex, areaInfo in ipairs(self._areas) do
    local trapCount = 0
    local isCasterInArea = casterPos.x >= areaInfo.min_x and casterPos.x <= areaInfo.max_x and casterPos.y >= areaInfo.min_y and casterPos.y <= areaInfo.max_y
    if not isCasterInArea then
      for posX = areaInfo.min_x, areaInfo.max_x do
        for posY = areaInfo.min_y, areaInfo.max_y do
          local hasTrap = self:_CheckPosHasTrap(Vector2(posX, posY), trapIDList)
          if hasTrap then
            trapCount = trapCount + 1
          end
        end
      end
    else
      trapCount = -1
    end
    areaTrapCount[areaIndex] = trapCount
  end
  return areaTrapCount
end

function SkillScopeCalculator_DrillerMoveTargetPos:_FindMinTrapAreas(areaTrapCount)
  local minTrapCount = 1000
  local minAreas = {}
  for areaIndex, trapCount in ipairs(areaTrapCount) do
    if 0 <= trapCount then
      if trapCount < minTrapCount then
        minAreas = {areaIndex}
        minTrapCount = trapCount
      elseif trapCount == minTrapCount then
        table.insert(minAreas, areaIndex)
      end
    end
  end
  return minAreas
end

function SkillScopeCalculator_DrillerMoveTargetPos:_CalcTarPosInMinAreas(minAreas, casterPos)
  local tarPos = casterPos
  if 0 < #minAreas then
    local minDis = 1000
    local nearestAreaIndex = -1
    local nearestAreaCenter
    for index, areaIndex in ipairs(minAreas) do
      local areaInfo = self._areas[areaIndex]
      local areaCenter = Vector2(areaInfo.center_x, areaInfo.center_y)
      local crossDis = math.abs(areaCenter.x - casterPos.x) + math.abs(areaCenter.y - casterPos.y)
      if minDis > crossDis then
        minDis = crossDis
        nearestAreaIndex = areaIndex
        nearestAreaCenter = areaCenter
      end
    end
    tarPos = nearestAreaCenter
  end
  return tarPos
end
