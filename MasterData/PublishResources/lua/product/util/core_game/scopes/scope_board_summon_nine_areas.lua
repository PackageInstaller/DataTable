require("scope_base")
_class("SkillScopeCalculator_BoardSummonNineAreas", SkillScopeCalculator_Base)
SkillScopeCalculator_BoardSummonNineAreas = SkillScopeCalculator_BoardSummonNineAreas

function SkillScopeCalculator_BoardSummonNineAreas:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  self._areas = {
    {
      min_x = 1,
      max_x = 3,
      min_y = 1,
      max_y = 3
    },
    {
      min_x = 1,
      max_x = 3,
      min_y = 4,
      max_y = 6
    },
    {
      min_x = 1,
      max_x = 3,
      min_y = 7,
      max_y = 9
    },
    {
      min_x = 4,
      max_x = 6,
      min_y = 1,
      max_y = 3
    },
    {
      min_x = 4,
      max_x = 6,
      min_y = 4,
      max_y = 6
    },
    {
      min_x = 4,
      max_x = 6,
      min_y = 7,
      max_y = 9
    },
    {
      min_x = 7,
      max_x = 9,
      min_y = 1,
      max_y = 3
    },
    {
      min_x = 7,
      max_x = 9,
      min_y = 4,
      max_y = 6
    },
    {
      min_x = 7,
      max_x = 9,
      min_y = 7,
      max_y = 9
    }
  }
  self._areas1 = {
    {
      min_x = 1,
      max_x = 3,
      min_y = 1,
      max_y = 6
    },
    {
      min_x = 1,
      max_x = 6,
      min_y = 7,
      max_y = 9
    },
    {
      min_x = 4,
      max_x = 9,
      min_y = 1,
      max_y = 3
    },
    {
      min_x = 7,
      max_x = 9,
      min_y = 4,
      max_y = 9
    },
    {
      min_x = 4,
      max_x = 6,
      min_y = 4,
      max_y = 6
    }
  }
  local eachAreaTargetNum = scopeParam[1] or 0
  local maxNum = scopeParam[2] or -1
  local maxNumRangeMin = scopeParam[3] or -1
  local maxNumRangeMax = scopeParam[4] or -1
  local areasType = scopeParam[5] or -1
  local checkTrapId = scopeParam[6] or -1
  local useAreas = self._areas
  if areasType == 1 then
    useAreas = self._areas1
  end
  local world = self._gridFilter._world
  local randomServiceLogic = world:GetService("RandomLogic")
  local boardServiceLogic = world:GetService("BoardLogic")
  local trapSvc = world:GetService("TrapLogic")
  local canPosAreas = {}
  for areaIndex, areaInfo in ipairs(useAreas) do
    local curAreaPos = {}
    for posX = areaInfo.min_x, areaInfo.max_x do
      for posY = areaInfo.min_y, areaInfo.max_y do
        local workPos = Vector2(posX, posY)
        if 0 <= checkTrapId then
          if trapSvc:CanSummonTrapOnPos(workPos, checkTrapId) then
            table.insert(curAreaPos, workPos)
          end
        else
          local isBlocked = boardServiceLogic:IsPosBlock(workPos, BlockFlag.SummonTrap)
          if not isBlocked then
            table.insert(curAreaPos, workPos)
          end
        end
      end
    end
    table.insert(canPosAreas, curAreaPos)
  end
  local resultPosList = {}
  for areaIndex, areaPosList in ipairs(canPosAreas) do
    randomServiceLogic:ShuffleUseBoardRand(areaPosList)
    local curNum = 0
    for _, workPos in ipairs(areaPosList) do
      if eachAreaTargetNum > curNum then
        table.insert(resultPosList, workPos)
        curNum = curNum + 1
      else
        break
      end
    end
  end
  randomServiceLogic:ShuffleUseBoardRand(resultPosList)
  local limitNum = -1
  if maxNum and 0 < maxNum then
    limitNum = maxNum
  end
  if 0 <= maxNumRangeMin and 0 <= maxNumRangeMax then
    local randomSvc = world:GetService("RandomLogic")
    local random = randomSvc:BoardLogicRand(maxNumRangeMin, maxNumRangeMax)
    limitNum = random
  end
  local retPosList = {}
  if 0 <= limitNum then
    for i = 1, limitNum do
      if resultPosList[i] then
        table.insert(retPosList, resultPosList[i])
      end
    end
  else
    retPosList = resultPosList
  end
  local result = SkillScopeResult:New(SkillScopeType.BoardSummonNineAreas, centerPos, retPosList, retPosList)
  return result
end
