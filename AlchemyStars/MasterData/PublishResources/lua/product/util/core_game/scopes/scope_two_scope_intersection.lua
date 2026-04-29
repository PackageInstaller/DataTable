require("scope_base")
_class("SkillScopeCalculator_TwoScopeIntersection", SkillScopeCalculator_Base)
SkillScopeCalculator_TwoScopeIntersection = SkillScopeCalculator_TwoScopeIntersection

function SkillScopeCalculator_TwoScopeIntersection:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
  local calc = SkillScopeCalculator:New(self._hub._gridFilter)
  local attackRange = {}
  local wholeRange = {}
  local attackRangeList = {}
  local wholeRangeList = {}
  for _, v in ipairs(scopeParam) do
    local _scopeType = v.scopeType
    local _scpoe_param = v.scopeParam
    local _scope_centerPosIndex = v.centerPosIndex
    local transCenterPos = centerPos
    if _scope_centerPosIndex then
      if _scope_centerPosIndex == 0 then
        transCenterPos = centerPos
      else
        transCenterPos = centerPos[_scope_centerPosIndex]
      end
    end
    local result = calc:ComputeScopeRange(_scopeType, _scpoe_param, transCenterPos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
    table.insert(attackRangeList, result:GetAttackRange())
    table.insert(wholeRangeList, result:GetWholeGridRange())
  end
  if 2 <= #attackRangeList then
    attackRange = self:_GetIntersectionScope(attackRangeList[1], attackRangeList[2])
  end
  if 2 <= #wholeRangeList then
    wholeRange = self:_GetIntersectionScope(wholeRangeList[1], wholeRangeList[2])
  end
  return SkillScopeResult:New(SkillScopeType.TwoScopeIntersection, centerPos, attackRange, wholeRange)
end

function SkillScopeCalculator_TwoScopeIntersection:_GetIntersectionScope(list1, list2)
  local out = {}
  for _, e in ipairs(list1) do
    if table.icontains(list2, e) then
      table.insert(out, e)
    end
  end
  return out
end
