require("scope_base")
_class("SkillScopeCalculator_UnderFoot", SkillScopeCalculator_Base)
SkillScopeCalculator_UnderFoot = SkillScopeCalculator_UnderFoot

function SkillScopeCalculator_UnderFoot:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  local force = 0
  if scopeParam and type(scopeParam) == "table" and 0 < table.count(scopeParam) then
    force = scopeParam[1]
  end
  local targetArea = {}
  local wholeArea = {}
  for i, v in ipairs(bodyArea) do
    local workPos = centerPos + Vector2.New(v.x, v.y)
    self:_InsertTargetGrid(targetArea, workPos, wholeArea)
    if force == 1 and not table.intable(targetArea, workPos) then
      table.insert(targetArea, workPos)
    end
  end
  local result = SkillScopeResult:New(SkillScopeType.UnderFoot, centerPos, targetArea, wholeArea)
  return result
end
