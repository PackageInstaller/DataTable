require("scope_base")
_class("SkillScopeCalculator_BoardSummonSixAreas", SkillScopeCalculator_Base)
SkillScopeCalculator_BoardSummonSixAreas = SkillScopeCalculator_BoardSummonSixAreas

function SkillScopeCalculator_BoardSummonSixAreas:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  self._areas = {
    {
      min_x = 1,
      max_x = 3,
      min_y = 1,
      max_y = 4
    },
    {
      min_x = 1,
      max_x = 3,
      min_y = 5,
      max_y = 8
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
      max_y = 7
    },
    {
      min_x = 7,
      max_x = 9,
      min_y = 1,
      max_y = 4
    },
    {
      min_x = 7,
      max_x = 9,
      min_y = 5,
      max_y = 8
    }
  }
  local eachAreaTargetNum = scopeParam[1] or 0
  local world = self._gridFilter._world
  local randomServiceLogic = world:GetService("RandomLogic")
  local boardServiceLogic = world:GetService("BoardLogic")
  local canPosAreas = {}
  for areaIndex, areaInfo in ipairs(self._areas) do
    local curAreaPos = {}
    for posX = areaInfo.min_x, areaInfo.max_x do
      for posY = areaInfo.min_y, areaInfo.max_y do
        local workPos = Vector2(posX, posY)
        local isBlocked = boardServiceLogic:IsPosBlock(workPos, BlockFlag.MonsterLand)
        if not isBlocked then
          table.insert(curAreaPos, workPos)
        end
      end
    end
    table.insert(canPosAreas, curAreaPos)
  end
  local resultPosList = {}
  for areaIndex, areaPosList in ipairs(canPosAreas) do
    randomServiceLogic:Shuffle(areaPosList)
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
  randomServiceLogic:Shuffle(resultPosList)
  local result = SkillScopeResult:New(SkillScopeType.BoardSummonSixAreas, centerPos, resultPosList, resultPosList)
  return result
end
