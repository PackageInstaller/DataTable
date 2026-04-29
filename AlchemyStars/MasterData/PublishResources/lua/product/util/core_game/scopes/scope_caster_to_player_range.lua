require("scope_base")
_class("SkillScopeCalculator_CasterToPlayerRange", SkillScopeCalculator_Base)
SkillScopeCalculator_CasterToPlayerRange = SkillScopeCalculator_CasterToPlayerRange

function SkillScopeCalculator_CasterToPlayerRange:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  local extendWidth = scopeParam[1] or 0
  local selectPosCount = scopeParam[2] or 0
  local supplement = scopeParam[3] or 0
  local base_area = {}
  local world = self._gridFilter._world
  local teamLeader = world:Player():GetCurrentTeamEntity()
  local teamPos = teamLeader:GetGridPosition()
  local offset = centerPos - teamPos
  local verticalDir = Vector2(0, 0)
  if offset.x ~= 0 then
    local add = 1
    if centerPos.x > teamPos.x then
      add = -1
    end
    for i = centerPos.x, teamPos.x, add do
      if i ~= centerPos.x and i ~= teamPos.x then
        local workPos = Vector2(i, centerPos.y)
        if self._gridFilter:IsValidPiecePos(workPos) then
          table.insert(base_area, workPos)
        end
      end
    end
    verticalDir = Vector2(0, 1)
  elseif offset.y ~= 0 then
    local add = 1
    if centerPos.y > teamPos.y then
      add = -1
    end
    for i = centerPos.y, teamPos.y, add do
      if i ~= centerPos.y and i ~= teamPos.y then
        local workPos = Vector2(centerPos.x, i)
        if self._gridFilter:IsValidPiecePos(workPos) then
          table.insert(base_area, workPos)
        end
      end
    end
    verticalDir = Vector2(1, 0)
  end
  local cross_area = {}
  table.appendArray(cross_area, base_area)
  if 0 < extendWidth then
    for _, pos in ipairs(base_area) do
      for i = 1, extendWidth do
        local leftPos = pos + verticalDir
        if self._gridFilter:IsValidPiecePos(leftPos) then
          table.insert(cross_area, leftPos)
        end
        local rightPos = pos - verticalDir
        if self._gridFilter:IsValidPiecePos(rightPos) then
          table.insert(cross_area, rightPos)
        end
      end
    end
  end
  if 0 < selectPosCount and 0 < table.count(cross_area) then
    local randomServiceLogic = world:GetService("RandomLogic")
    local boardServiceLogic = world:GetService("BoardLogic")
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
    elseif 0 < supplement then
    end
    cross_area = resultPos
  end
  local result = SkillScopeResult:New(SkillScopeType.CasterToPlayerRange, centerPos, cross_area, cross_area)
  return result
end
