require("scope_base")
_class("SkillScopeCalculator_SelectPosByPlayerPos1", SkillScopeCalculator_Base)
SkillScopeCalculator_SelectPosByPlayerPos1 = SkillScopeCalculator_SelectPosByPlayerPos1

function SkillScopeCalculator_SelectPosByPlayerPos1:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
  local world = self._gridFilter._world
  local teamEntity = world:Player():GetLocalTeamEntity()
  local playerPos = teamEntity:GetGridPosition()
  local ret = {}
  for i, v in ipairs(scopeParam) do
    if playerPos.x >= v.x[1] and playerPos.x <= v.x[2] and playerPos.y >= v.y[1] and playerPos.y <= v.y[2] then
      table.insert(ret, Vector2(v.point[1], v.point[2]))
    end
  end
  local result = SkillScopeResult:New(SkillScopeType.SelectPosByPlayerPos1, centerPos, ret, ret)
  return result
end
