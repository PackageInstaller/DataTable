require("scope_base")
_class("SkillScopeCalculator_FrontAndObliqueOffset", SkillScopeCalculator_Base)
SkillScopeCalculator_FrontAndObliqueOffset = SkillScopeCalculator_FrontAndObliqueOffset

function SkillScopeCalculator_FrontAndObliqueOffset:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
  local world = self._gridFilter._world
  local utilData = world:GetService("UtilData")
  local cross_area = {}
  local wholeArea = {}
  local attack = scopeParam[1] or 1
  local front = Vector2(0, -1)
  local targetPos = centerPos + front
  if attack == -1 then
    local result = SkillScopeResult:New(SkillScopeType.FrontAndObliqueOffset, centerPos, {targetPos}, {targetPos})
    return result
  elseif attack == -2 then
    cross_area, wholeArea = self:CalcMultiCenterCrossList(targetPos, 1)
    local result = SkillScopeResult:New(SkillScopeType.FrontAndObliqueOffset, centerPos, cross_area, wholeArea)
    return result
  end
  local blockGridTrapPosList = self._gridFilter:GetBlockGridTrapPosList()
  local blockMovePosList = self._gridFilter:GetBlockMovePosList()
  local blocks = {}
  table.appendArray(blocks, blockGridTrapPosList)
  table.appendArray(blocks, blockMovePosList)
  if table.icontains(blocks, targetPos) then
    local battleFlags = world:BattleFlags()
    local monsterList, monsterPosList = self._gridFilter:SelectAllMonster(casterEntity)
    local curEntityID
    for _, monster in pairs(monsterList) do
      local monsterGridPos = monster:GetGridPosition()
      if monsterGridPos == centerPos then
        curEntityID = monster:GetID()
        break
      end
    end
    local lastObliqueOffset = battleFlags:GetFrontAndObliqueOffsetData(curEntityID)
    lastObliqueOffset = lastObliqueOffset or Vector2(1, 0)
    lastObliqueOffset = -lastObliqueOffset
    targetPos = targetPos + lastObliqueOffset
    local isValidGrid = utilData:IsValidPiecePos(targetPos)
    if table.icontains(blocks, targetPos) or not isValidGrid then
      lastObliqueOffset = -lastObliqueOffset
      targetPos = targetPos + lastObliqueOffset * 2
      isValidGrid = utilData:IsValidPiecePos(targetPos)
      if table.icontains(blocks, targetPos) or not isValidGrid then
        targetPos = centerPos
      end
    end
  end
  if attack == 0 then
    local result = SkillScopeResult:New(SkillScopeType.FrontAndObliqueOffset, centerPos, {targetPos}, {targetPos})
    return result
  end
  if targetPos then
    cross_area, wholeArea = self:CalcMultiCenterCrossList(targetPos, 1)
  end
  local result = SkillScopeResult:New(SkillScopeType.FrontAndObliqueOffset, centerPos, cross_area, wholeArea)
  return result
end
