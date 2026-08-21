require("scope_base")
_class("SkillScopeCalculator_UseTeamMoveSavePos", SkillScopeCalculator_Base)
SkillScopeCalculator_UseTeamMoveSavePos = SkillScopeCalculator_UseTeamMoveSavePos

function SkillScopeCalculator_UseTeamMoveSavePos:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  local teamEntity = self._gridFilter._world:Player():GetCurrentTeamEntity()
  local pos = teamEntity:BuffComponent():GetBuffValue("SaveTeamBeginPos")
  local result = SkillScopeResult:New(SkillScopeType.UseTeamMoveSavePos, casterPos, {pos}, {pos})
  return result
end
