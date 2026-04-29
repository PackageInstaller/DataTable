require("scope_base")
_class("SkillScopeCalculator_TrapsCenterWithScopeByCenterPos", SkillScopeCalculator_Base)
SkillScopeCalculator_TrapsCenterWithScopeByCenterPos = SkillScopeCalculator_TrapsCenterWithScopeByCenterPos

function SkillScopeCalculator_TrapsCenterWithScopeByCenterPos:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
  self._world = self._hub._gridFilter._world
  local resultList = {}
  local rangeList = {}
  for _, param in ipairs(scopeParam) do
    local results = self:CalcRangeByTrapCenter(param, centerPos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
    for i, result in ipairs(results) do
      table.insert(rangeList, result)
    end
  end
  for i = 1, 2 do
    self:MergeRange(rangeList)
  end
  local attackRange = {}
  for i, range in ipairs(rangeList) do
    if centerPos._className == "Vector2" then
      if table.Vector2Include(range, centerPos) then
        attackRange = range
        break
      end
    else
      for _, pos in ipairs(centerPos) do
        if table.Vector2Include(range, pos) then
          attackRange = range
          break
        end
      end
    end
  end
  local result = SkillScopeResult:New(SkillScopeType.TrapsCenterWithScopeByCasterPos, casterPos, attackRange, attackRange)
  return result
end

function SkillScopeCalculator_TrapsCenterWithScopeByCenterPos:MergeRange(rangeList)
  for i, rangeA in ipairs(rangeList) do
    for j, rangeB in ipairs(rangeList) do
      if j ~= i then
        for _, pos in ipairs(rangeA) do
          if table.Vector2Include(rangeB, pos) or self:IsNearBy(rangeB, pos) then
            table.Vector2Append(rangeB, rangeA, rangeB)
            break
          end
        end
      end
    end
  end
end

function SkillScopeCalculator_TrapsCenterWithScopeByCenterPos:IsNearBy(range, pos)
  for i, v in ipairs(range) do
    for _, offset in ipairs(Offset4) do
      local i, j = offset[1], offset[2]
      if v.x + i == pos.x and v.y + j == pos.y then
        return true
      end
    end
  end
  return false
end

function SkillScopeCalculator_TrapsCenterWithScopeByCenterPos:CalcRangeByTrapCenter(param, centerPos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
  local tarpID = param[1]
  local scopeType = param[2]
  local trapServerLogic = self._world:GetService("TrapLogic")
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
    table.insert(attackRange, result:GetAttackRange())
    table.insert(wholeRange, result:GetWholeGridRange())
  end
  return attackRange
end
