require("scope_base")
_class("SkillScopeCalculator_LimitRingNearestToSelectPos", SkillScopeCalculator_Base)
SkillScopeCalculator_LimitRingNearestToSelectPos = SkillScopeCalculator_LimitRingNearestToSelectPos

function SkillScopeCalculator_LimitRingNearestToSelectPos:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
  local limitCount = scopeParam[1] or 1
  local selectPosX = scopeParam[2] or 5
  local selectPosY = scopeParam[3] or 5
  local selectPos = Vector2(selectPosX, selectPosY)
  local world = self._gridFilter._world
  local cross_area = {}
  local gridPosList = {}
  local utilScopeSvc = world:GetService("UtilScopeCalc")
  local scopeCalculator = utilScopeSvc:GetSkillScopeCalc()
  local scopeResult = scopeCalculator:ComputeScopeRange(SkillScopeType.SquareRing, {limitCount, 1}, centerPos, bodyArea)
  local attackRange = scopeResult:GetAttackRange()
  local blockType = BlockFlag.MonsterLand
  local boardServiceLogic = world:GetService("BoardLogic")
  for _, pos in ipairs(attackRange) do
    table.insert(gridPosList, pos)
  end
  local nearestDisPos = gridPosList[1]
  for _, pos in ipairs(gridPosList) do
    local curPosDis = Vector2.Distance(pos, selectPos)
    local nearestDis = Vector2.Distance(nearestDisPos, selectPos)
    if curPosDis < nearestDis then
      nearestDisPos = pos
    end
  end
  cross_area = {nearestDisPos}
  local result = SkillScopeResult:New(SkillScopeType.LimitRingNearestToSelectPos, centerPos, cross_area, cross_area)
  return result
end
