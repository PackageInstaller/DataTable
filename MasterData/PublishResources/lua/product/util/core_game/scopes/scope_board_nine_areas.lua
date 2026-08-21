require("scope_base")
_class("SkillScopeCalculator_BoardNineAreas", SkillScopeCalculator_Base)
SkillScopeCalculator_BoardNineAreas = SkillScopeCalculator_BoardNineAreas

function SkillScopeCalculator_BoardNineAreas:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  local areaIndex = scopeParam[1] or 0
  local selectPosCount = scopeParam[2] or 0
  local cross_area = {}
  local world = self._gridFilter._world
  local randomServiceLogic = world:GetService("RandomLogic")
  local boardServiceLogic = world:GetService("BoardLogic")
  if areaIndex == 0 then
    areaIndex = randomServiceLogic:LogicRand(1, 9)
  end
  local offsetX = math.fmod(areaIndex, 3)
  if offsetX == 0 then
    offsetX = 3
  end
  offsetX = (offsetX - 1) * 3 + 1
  local offsetY = math.modf(areaIndex / 3)
  if 0 < offsetY and offsetX == 7 then
    offsetY = offsetY - 1
  end
  offsetY = offsetY * 3 + 1
  for x = offsetX, offsetX + 2 do
    for y = offsetY, offsetY + 2 do
      local workPos = Vector2(x, y)
      local isBlocked = boardServiceLogic:IsPosBlock(workPos, BlockFlag.MonsterLand)
      if not isBlocked then
        table.insert(cross_area, workPos)
      end
    end
  end
  if 0 < selectPosCount and 0 < table.count(cross_area) then
    local canSummonPosList = {}
    for _, pos in ipairs(cross_area) do
      local isBlocked = boardServiceLogic:IsPosBlock(pos, BlockFlag.MonsterLand)
      if not isBlocked then
        table.insert(canSummonPosList, pos)
      end
    end
    local resultPos = {}
    if selectPosCount <= table.count(canSummonPosList) then
      local randomCount = 0
      while selectPosCount > table.count(resultPos) do
        local randomIndex = randomServiceLogic:LogicRand(1, #canSummonPosList)
        local randomPos = canSummonPosList[randomIndex]
        table.insert(resultPos, randomPos)
        table.removev(canSummonPosList, randomPos)
      end
    else
    end
    cross_area = resultPos
  end
  local result = SkillScopeResult:New(SkillScopeType.BoardNineAreas, centerPos, cross_area, cross_area)
  return result
end
