require("scope_base")
_class("SkillScopeCalculator_TrapCenterWithScopeCanRepeat", SkillScopeCalculator_Base)
SkillScopeCalculator_TrapCenterWithScopeCanRepeat = SkillScopeCalculator_TrapCenterWithScopeCanRepeat

function SkillScopeCalculator_TrapCenterWithScopeCanRepeat:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
  local tarpID = scopeParam[1]
  local _scopeType = scopeParam[2]
  local calc = SkillScopeCalculator:New(self._hub._gridFilter)
  local attackRange = {}
  local world = self._hub._gridFilter._world
  if not world then
    Log.exception(self._className, "无法用于没有world的环境下")
    return SkillScopeResult:New(SkillScopeType.TrapCenterWithScopeCanRepeat, casterPos, {}, {})
  end
  local trapServerLogic = world:GetService("TrapLogic")
  local _centerPosList = trapServerLogic:FindTrapPosByTrapID(tarpID)
  if table.count(_centerPosList) == 0 then
    return SkillScopeResult:New(SkillScopeType.TrapCenterWithScopeCanRepeat, casterPos, {}, {})
  end
  local _scpoe_param = {}
  if table.count(scopeParam) >= 3 then
    _scpoe_param = table.sub(scopeParam, 3, #scopeParam)
  end
  local attackRange, wholeRange = {}, {}
  for _, pos in ipairs(_centerPosList) do
    local result = calc:ComputeScopeRange(_scopeType, _scpoe_param, pos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
    for i, newPos in ipairs(result:GetAttackRange()) do
      table.insert(attackRange, newPos)
    end
    for i, newPos in ipairs(result:GetWholeGridRange()) do
      table.insert(wholeRange, newPos)
    end
  end
  local result = SkillScopeResult:New(SkillScopeType.TrapCenterWithScopeCanRepeat, casterPos, attackRange, wholeRange)
  return result
end
