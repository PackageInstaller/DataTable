require("scope_base")
_class("SkillScopeCalculator_Team", SkillScopeCalculator_Base)
SkillScopeCalculator_Team = SkillScopeCalculator_Team

function SkillScopeCalculator_Team:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
  local world = casterEntity:GetOwnerWorld()
  local teamEntity = world:Player():GetCurrentTeamEntity()
  local listPos = {
    teamEntity:GetGridPosition()
  }
  local result = SkillScopeResult:New(SkillScopeType.Team, centerPos, listPos, listPos)
  return result
end
