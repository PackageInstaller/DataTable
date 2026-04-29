require("scope_base")
_class("SkillScopeCalculator_PickUpCrossIgnoreValidity", SkillScopeCalculator_Base)
SkillScopeCalculator_PickUpCrossIgnoreValidity = SkillScopeCalculator_PickUpCrossIgnoreValidity

function SkillScopeCalculator_PickUpCrossIgnoreValidity:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  local scopeList = {}
  if centerPos then
    if #centerPos == 0 and centerPos._className == "Vector2" then
      centerPos = {centerPos}
    end
    for _, pos in ipairs(centerPos) do
      table.insert(scopeList, Vector2(pos.x - 1, pos.y))
      table.insert(scopeList, Vector2(pos.x + 1, pos.y))
      table.insert(scopeList, Vector2(pos.x, pos.y - 1))
      table.insert(scopeList, Vector2(pos.x, pos.y + 1))
    end
  end
  table.unique(scopeList)
  local result = SkillScopeResult:New(SkillScopeType.PickUpCrossIgnoreValidity, centerPos, scopeList, scopeList)
  return result
end
