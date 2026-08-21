require("scope_base")
_class("SkillScopeCalculator_PickUpSingleLineNearestNoTrap", SkillScopeCalculator_Base)
SkillScopeCalculator_PickUpSingleLineNearestNoTrap = SkillScopeCalculator_PickUpSingleLineNearestNoTrap

function SkillScopeCalculator_PickUpSingleLineNearestNoTrap:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  local trapID = scopeParam[1]
  local count = scopeParam[2]
  local world = self._gridFilter._world
  local dirType = self:GetDirection(centerPos, casterPos)
  local utilScopeSvc = world:GetService("UtilScopeCalc")
  local utilDataSvc = world:GetService("UtilData")
  local pickUpPos, pickUpNEGPos = utilScopeSvc:CalcPickUpSingleLine(dirType, casterPos)
  local ret = {}
  for _, pos in ipairs(pickUpPos) do
    if not utilDataSvc:IsHasTrapOnPos(pos, trapID) and count > #ret then
      table.insert(ret, pos)
    end
  end
  for _, pos in ipairs(pickUpNEGPos) do
    if not utilDataSvc:IsHasTrapOnPos(pos, trapID) and count > #ret then
      table.insert(ret, pos)
    end
  end
  local result = SkillScopeResult:New(SkillScopeType.PickUpSingleLineNearestNoTrap, centerPos, ret, ret)
  return result
end
