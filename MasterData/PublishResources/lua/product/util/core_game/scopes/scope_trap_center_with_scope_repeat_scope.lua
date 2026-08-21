require("scope_base")
_class("SkillScopeCalculator_TrapCenterWithScopeRepeatScope", SkillScopeCalculator_Base)
SkillScopeCalculator_TrapCenterWithScopeRepeatScope = SkillScopeCalculator_TrapCenterWithScopeRepeatScope

function SkillScopeCalculator_TrapCenterWithScopeRepeatScope:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
  local tarpID = scopeParam.trapID
  local _scopeType = scopeParam.scopeType
  local _scpoe_param = scopeParam.scopeParam
  local _repeatCount = scopeParam.repeatCount
  local calc = SkillScopeCalculator:New(self._hub._gridFilter)
  local attackRange = {}
  local world = self._hub._gridFilter._world
  if not world then
    Log.exception(self._className, "无法用于没有world的环境下")
    return SkillScopeResult:New(SkillScopeType.TrapCenterWithScopeRepeatScope, casterPos, {}, {})
  end
  local trapServerLogic = world:GetService("TrapLogic")
  local _centerPosList = trapServerLogic:FindTrapPosByTrapID(tarpID)
  if table.count(_centerPosList) == 0 then
    return SkillScopeResult:New(SkillScopeType.TrapCenterWithScopeRepeatScope, casterPos, {}, {})
  end
  local attackRange, wholeRange = {}, {}
  for _, pos in ipairs(_centerPosList) do
    local result = calc:ComputeScopeRange(_scopeType, _scpoe_param, pos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
    for i, newPos in ipairs(result:GetAttackRange()) do
      table.insert(attackRange, newPos)
    end
  end
  local repeatCountList = {}
  for i, v in ipairs(attackRange) do
    local posIndex = v:PosIndex()
    if not repeatCountList[posIndex] then
      repeatCountList[posIndex] = 0
    end
    repeatCountList[posIndex] = repeatCountList[posIndex] + 1
  end
  attackRange, wholeRange = {}, {}
  for posIndex, count in pairs(repeatCountList) do
    if _repeatCount <= count then
      local pos = Vector2.Index2Pos(posIndex)
      table.insert(attackRange, pos)
      table.insert(wholeRange, pos)
    end
  end
  local result = SkillScopeResult:New(SkillScopeType.TrapCenterWithScopeRepeatScope, casterPos, attackRange, wholeRange)
  return result
end
