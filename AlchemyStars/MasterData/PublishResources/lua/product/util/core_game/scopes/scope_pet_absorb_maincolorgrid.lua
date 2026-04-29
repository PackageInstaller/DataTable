require("scope_base")
_class("SkillScopeCalculator_PetAbsorbMaintainColorGrid", SkillScopeCalculator_Base)
SkillScopeCalculator_PetAbsorbMaintainColorGrid = SkillScopeCalculator_PetAbsorbMaintainColorGrid

function SkillScopeCalculator_PetAbsorbMaintainColorGrid:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
  local range = {}
  if casterEntity:BuffComponent() then
    range = casterEntity:BuffComponent():GetBuffValue("AbsorbMainColorGridPos")
  end
  local result = SkillScopeResult:New(SkillScopeType.PetAbsorbMainColorGrid, casterPos, range, range)
  return result
end
