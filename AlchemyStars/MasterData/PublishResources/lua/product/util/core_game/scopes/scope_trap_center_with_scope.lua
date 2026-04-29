require("scope_base")
_class("SkillScopeCalculator_TrapCenterWithScope", SkillScopeCalculator_Base)
SkillScopeCalculator_TrapCenterWithScope = SkillScopeCalculator_TrapCenterWithScope

function SkillScopeCalculator_TrapCenterWithScope:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
  local tarpID = scopeParam[1]
  local _scopeType = scopeParam[2]
  local calc = SkillScopeCalculator:New(self._hub._gridFilter)
  local attackRange = {}
  local world = self._hub._gridFilter._world
  if not world then
    Log.exception(self._className, "无法用于没有world的环境下")
    return SkillScopeResult:New(SkillScopeType.TrapCenterWithScope, casterPos, {}, {})
  end
  local trapServerLogic = world:GetService("TrapLogic")
  local _centerPosList = trapServerLogic:FindTrapPosByTrapID(tarpID, true, casterEntity)
  if table.count(_centerPosList) == 0 then
    return SkillScopeResult:New(SkillScopeType.TrapCenterWithScope, casterPos, {}, {})
  end
  local _scpoe_param = {}
  if table.count(scopeParam) >= 3 then
    _scpoe_param = table.sub(scopeParam, 3, #scopeParam)
  end
  local attackRange, wholeRange = {}, {}
  for _, pos in ipairs(_centerPosList) do
    local result = calc:ComputeScopeRange(_scopeType, _scpoe_param, pos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
    table.Vector2Append(attackRange, result:GetAttackRange(), attackRange)
    table.Vector2Append(wholeRange, result:GetWholeGridRange(), wholeRange)
  end
  local result = SkillScopeResult:New(SkillScopeType.TrapCenterWithScope, casterPos, attackRange, wholeRange)
  return result
end
