require("scope_base")
_class("SkillScopeCalculator_TwoScopeCollection", SkillScopeCalculator_Base)
SkillScopeCalculator_TwoScopeCollection = SkillScopeCalculator_TwoScopeCollection

function SkillScopeCalculator_TwoScopeCollection:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
  local calc = SkillScopeCalculator:New(self._hub._gridFilter)
  local attackRange = {}
  local wholeRange = {}
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
    table.Vector2Append(attackRange, result:GetAttackRange(), attackRange)
    table.Vector2Append(wholeRange, result:GetWholeGridRange(), wholeRange)
  end
  return SkillScopeResult:New(SkillScopeType.TowScopeCollection, centerPos, attackRange, wholeRange)
end
