require("scope_base")
_class("SkillScopeCalculator_DoubleNRowMColSpread", SkillScopeCalculator_Base)
SkillScopeCalculator_DoubleNRowMColSpread = SkillScopeCalculator_DoubleNRowMColSpread

function SkillScopeCalculator_DoubleNRowMColSpread:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  local scopeParam1 = {}
  table.insert(scopeParam1, scopeParam[1])
  table.insert(scopeParam1, scopeParam[2])
  table.insert(scopeParam1, scopeParam[3])
  local targetArea1, wholeArea1 = self:_CalcNRowMColSpread(scopeParam1, centerPos, bodyArea)
  local scopeParam2 = {}
  table.insert(scopeParam2, scopeParam[4])
  table.insert(scopeParam2, scopeParam[5])
  table.insert(scopeParam2, scopeParam[6])
  local targetArea2, wholeArea2 = self:_CalcNRowMColSpread(scopeParam2, centerPos, bodyArea)
  local targetArea = {}
  local wholeArea = {}
  table.appendArray(targetArea, targetArea1)
  table.appendArray(wholeArea, wholeArea1)
  for _, pos in ipairs(targetArea2) do
    if not table.intable(targetArea1, pos) then
      table.insert(targetArea, pos)
    end
  end
  for _, pos in ipairs(wholeArea2) do
    if not table.intable(wholeArea1, pos) then
      table.insert(wholeArea, pos)
    end
  end
  local result = SkillScopeResult:New(SkillScopeType.NRowsMColumns, centerPos, targetArea, wholeArea)
  return result
end
