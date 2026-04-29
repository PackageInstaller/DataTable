require("scope_base")
_class("SkillScopeCalculator_TrapsCenterWithScope", SkillScopeCalculator_Base)
SkillScopeCalculator_TrapsCenterWithScope = SkillScopeCalculator_TrapsCenterWithScope

function SkillScopeCalculator_TrapsCenterWithScope:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
  local scope = SkillScopeCalculator_TrapCenterWithScope:New(self._hub)
  local calc = SkillScopeCalculator:New(self._hub._gridFilter)
  local attackRange, wholeRange = {}, {}
  for i, param in ipairs(scopeParam) do
    local result = self._hub._gridFilter:CalcRangeByTrapCenter(param, centerPos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
    table.Vector2Append(attackRange, result:GetAttackRange(), attackRange)
    table.Vector2Append(wholeRange, result:GetWholeGridRange(), wholeRange)
  end
  local result = SkillScopeResult:New(SkillScopeType.TrapsCenterWithScope, casterPos, attackRange, wholeRange)
  return result
end

function SkillScopeCalculator_TrapsCenterWithScope:_CalcRange(param, centerPos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
  local tarpID = param[1]
  local scopeType = param[2]
  local world = self._hub._gridFilter._world
  local trapServerLogic = world:GetService("TrapLogic")
  local centerPosList = trapServerLogic:FindTrapPosByTrapID(tarpID, false)
  local calc = SkillScopeCalculator:New(self._hub._gridFilter)
  if table.count(centerPosList) == 0 then
    return SkillScopeResult:New(SkillScopeType.TrapCenterWithScope, casterPos, {}, {})
  end
  local scpoe_param = {}
  if table.count(param) >= 3 then
    scpoe_param = table.sub(param, 3, #param)
  end
  local attackRange, wholeRange = {}, {}
  for _, pos in ipairs(centerPosList) do
    local result = calc:ComputeScopeRange(scopeType, scpoe_param, pos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
    table.Vector2Append(attackRange, result:GetAttackRange(), attackRange)
    table.Vector2Append(wholeRange, result:GetWholeGridRange(), wholeRange)
  end
  local result = SkillScopeResult:New(SkillScopeType.TrapsCenterWithScope, casterPos, attackRange, wholeRange)
  return result
end
