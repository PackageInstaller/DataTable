require("scope_base")
_class("SkillScopeCalculator_NearestPlayerAroundBody", SkillScopeCalculator_Base)
SkillScopeCalculator_NearestPlayerAroundBody = SkillScopeCalculator_NearestPlayerAroundBody

function SkillScopeCalculator_NearestPlayerAroundBody:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
  local world = self._gridFilter._world
  local cross_area = {}
  local gridPosList = {}
  local teamEntity = world:Player():GetCurrentTeamEntity()
  local teamPos = teamEntity:GetGridPosition()
  local teamBodyArea = teamEntity:BodyArea():GetArea()
  local utilScopeSvc = world:GetService("UtilScopeCalc")
  local scopeCalculator = utilScopeSvc:GetSkillScopeCalc()
  local scopeResult = scopeCalculator:ComputeScopeRange(SkillScopeType.SquareRing, {1, 0}, teamPos, teamBodyArea)
  local attackRange = scopeResult:GetAttackRange()
  local blockType = BlockFlag.MonsterLand
  local boardServiceLogic = world:GetService("BoardLogic")
  for _, pos in ipairs(attackRange) do
    if not boardServiceLogic:IsPosBlock(pos, blockType) then
      table.insert(gridPosList, pos)
    end
  end
  local nearestDisPos = gridPosList[1]
  for _, pos in ipairs(gridPosList) do
    local curPosDis = Vector2.Distance(pos, centerPos)
    local nearestDis = Vector2.Distance(nearestDisPos, centerPos)
    if curPosDis < nearestDis then
      nearestDisPos = pos
    end
  end
  cross_area = {nearestDisPos}
  local result = SkillScopeResult:New(SkillScopeType.NearestPlayerAroundBody, centerPos, cross_area, cross_area)
  return result
end
