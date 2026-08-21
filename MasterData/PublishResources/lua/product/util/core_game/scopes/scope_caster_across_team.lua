require("scope_base")
_class("SkillScopeCalculator_CasterAcrossTeam", SkillScopeCalculator_Base)
SkillScopeCalculator_CasterAcrossTeam = SkillScopeCalculator_CasterAcrossTeam

function SkillScopeCalculator_CasterAcrossTeam:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
  local world = self._hub._gridFilter._world
  local teamEntity = world:Player():GetCurrentTeamEntity()
  local playerPos = teamEntity:GetGridPosition()
  local dir = playerPos - casterPos
  local targetPos = playerPos + dir
  local result = SkillScopeResult:New(SkillScopeType.CasterAcrossTeam, casterPos, {targetPos}, {targetPos})
  return result
end
