require("scope_base")
_class("SkillScopeCalculator_PickUpSingleLine", SkillScopeCalculator_Base)
SkillScopeCalculator_PickUpSingleLine = SkillScopeCalculator_PickUpSingleLine

function SkillScopeCalculator_PickUpSingleLine:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  local world = self._gridFilter._world
  local dirType = self:GetDirection(centerPos, casterPos)
  local utilScopeSvc = world:GetService("UtilScopeCalc")
  local pickUpPos, pickUpNEGPos = utilScopeSvc:CalcPickUpSingleLine(dirType, casterPos)
  table.Vector2Append(pickUpPos, pickUpNEGPos)
  local result = SkillScopeResult:New(SkillScopeType.PickUpSingleLine, centerPos, pickUpPos, pickUpPos)
  return result
end
