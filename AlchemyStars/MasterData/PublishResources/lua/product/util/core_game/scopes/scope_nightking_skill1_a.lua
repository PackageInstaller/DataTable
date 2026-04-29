require("scope_base")
_class("SkillScopeCalculator_NightKing_Skill1A", SkillScopeCalculator_Base)
SkillScopeCalculator_NightKing_Skill1A = SkillScopeCalculator_NightKing_Skill1A

function SkillScopeCalculator_NightKing_Skill1A:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
  local world = self._gridFilter._world
  local utilScopeCalcSvc = world:GetService("UtilScopeCalc")
  local dirType = utilScopeCalcSvc:GetEntityDirType(casterEntity)
  local rangList = utilScopeCalcSvc:GetNightKing_Skill1A(casterEntity, casterPos, dirType)
  local result = SkillScopeResult:New(SkillScopeType.N16NightKingSkill1A, casterPos, rangList, rangList, nil)
  return result
end
