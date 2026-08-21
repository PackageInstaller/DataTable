require("scope_base")
_class("SkillScopeCalculator_OneScopeRangeNearestPlayer", SkillScopeCalculator_Base)
SkillScopeCalculator_OneScopeRangeNearestPlayer = SkillScopeCalculator_OneScopeRangeNearestPlayer

function SkillScopeCalculator_OneScopeRangeNearestPlayer:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
  local scopeType1 = scopeParam[1]
  local scopeParam1 = scopeParam[2]
  local world = self._gridFilter._world
  local teamEntity = world:Player():GetCurrentTeamEntity()
  local teamPos = teamEntity:GetGridPosition()
  local utilScopeSvc = world:GetService("UtilScopeCalc")
  local scopeCalculator = utilScopeSvc:GetSkillScopeCalc()
  local cross_area = {}
  local scopeResult = scopeCalculator:ComputeScopeRange(scopeType1, scopeParam1, centerPos, bodyArea)
  local attackRange = scopeResult:GetAttackRange()
  local blockType = BlockFlag.MonsterLand
  local boardServiceLogic = world:GetService("BoardLogic")
  for _, pos in ipairs(attackRange) do
    if not boardServiceLogic:IsPosBlock(pos, blockType) or pos == centerPos then
      table.insert(cross_area, pos)
    end
  end
  local nearestDisPos = cross_area[1]
  for _, pos in ipairs(cross_area) do
    local curPosDis = Vector2.Distance(pos, teamPos)
    local nearestDis = Vector2.Distance(nearestDisPos, teamPos)
    if curPosDis < nearestDis then
      nearestDisPos = pos
    end
  end
  cross_area = {nearestDisPos}
  local result = SkillScopeResult:New(SkillScopeType.OneScopeRangeNearestPlayer, centerPos, cross_area, cross_area)
  return result
end
