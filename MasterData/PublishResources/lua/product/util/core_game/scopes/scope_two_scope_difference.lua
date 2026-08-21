require("scope_base")
_class("SkillScopeCalculator_TwoScopeDifference", SkillScopeCalculator_Base)
SkillScopeCalculator_TwoScopeDifference = SkillScopeCalculator_TwoScopeDifference

function SkillScopeCalculator_TwoScopeDifference:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
  local calc = SkillScopeCalculator:New(self._hub._gridFilter)
  local attackRange = {}
  local wholeRange = {}
  local attackRangeList = {}
  local wholeRangeList = {}
  for _, v in ipairs(scopeParam) do
    local _scopeType = v.scopeType
    local _scpoe_param = v.scopeParam
    local result = calc:ComputeScopeRange(_scopeType, _scpoe_param, centerPos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
    table.insert(attackRangeList, result:GetAttackRange())
    table.insert(wholeRangeList, result:GetWholeGridRange())
  end
  if 2 <= #attackRangeList then
    attackRange = self:_GetRestValidScope(attackRangeList[1], attackRangeList[2])
  end
  if 2 <= #wholeRangeList then
    wholeRange = self:_GetRestValidScope(wholeRangeList[1], wholeRangeList[2])
  end
  return SkillScopeResult:New(SkillScopeType.TwoScopeDifference, centerPos, attackRange, wholeRange)
end

function SkillScopeCalculator_TwoScopeDifference:_GetRestValidScope(validGridList, invalidGridList)
  local tv2FilteredInvalidGridList = {}
  for _, v2 in ipairs(invalidGridList) do
    if table.icontains(validGridList, v2) then
      table.insert(tv2FilteredInvalidGridList, v2)
    end
  end
  local tv2FilteredValidGridList = {}
  for _, v2 in ipairs(validGridList) do
    if not table.icontains(tv2FilteredInvalidGridList, v2) then
      table.insert(tv2FilteredValidGridList, v2)
    end
  end
  validGridList = tv2FilteredValidGridList
  return tv2FilteredValidGridList
end
