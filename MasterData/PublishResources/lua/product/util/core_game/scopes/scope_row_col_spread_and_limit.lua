require("scope_base")
_class("SkillScopeCalculator_NRowMColSpreadAndLimit", SkillScopeCalculator_Base)
SkillScopeCalculator_NRowMColSpreadAndLimit = SkillScopeCalculator_NRowMColSpreadAndLimit

function SkillScopeCalculator_NRowMColSpreadAndLimit:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  local targetArea, wholeArea = self:_CalcNRowMColSpread(scopeParam, centerPos, bodyArea)
  local limitXMin = scopeParam[4] or 1
  local limitXMax = scopeParam[5] or 9
  local limitYMin = scopeParam[6] or 1
  local limitYMax = scopeParam[7] or 9
  local attackRange = {}
  local wholeRange = {}
  for _, pos in ipairs(targetArea) do
    if limitXMin <= pos.x and limitXMax >= pos.x and limitYMin <= pos.y and limitYMax >= pos.y then
      table.insert(attackRange, pos)
    end
  end
  for _, pos in ipairs(wholeArea) do
    if limitXMin <= pos.x and limitXMax >= pos.x and limitYMin <= pos.y and limitYMax >= pos.y then
      table.insert(wholeRange, pos)
    end
  end
  local result = SkillScopeResult:New(SkillScopeType.NRowsMColumns, centerPos, attackRange, wholeRange)
  return result
end
