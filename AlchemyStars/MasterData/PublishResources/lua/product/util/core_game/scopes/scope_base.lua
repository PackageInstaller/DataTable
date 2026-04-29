_class("SkillScopeCalculator_Base", Object)
SkillScopeCalculator_Base = SkillScopeCalculator_Base

function SkillScopeCalculator_Base:Constructor(calcHub)
  self._hub = calcHub
  self._gridFilter = calcHub._gridFilter
end

function SkillScopeCalculator_Base:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  Log.exception(self._className, "NotImplementedException occurred at: ", Log.traceback())
  return {}
end

function SkillScopeCalculator_Base:_InsertTargetGrid(targetArea, newGridPos, wholeArea)
  return self._hub:_InsertTargetGrid(targetArea, newGridPos, wholeArea)
end

function SkillScopeCalculator_Base:_InsertTargetGridIntoOneArea(newGridPos, area)
  return self._hub:_InsertTargetGridIntoOneArea(newGridPos, area)
end

function SkillScopeCalculator_Base:GetDirection(gridpos, casterPos)
  return self._hub:GetDirection(gridpos, casterPos)
end

function SkillScopeCalculator_Base:CalcMultiCenterCrossList(...)
  return self._hub:CalcMultiCenterCrossList(...)
end

function SkillScopeCalculator_Base:_CalcLeftDownColumnsAndRowsRange(...)
  return self._hub:_CalcLeftDownColumnsAndRowsRange(...)
end

function SkillScopeCalculator_Base:_ComputeHalfStartPos(...)
  return self._hub:_ComputeHalfStartPos(...)
end

function SkillScopeCalculator_Base:_GetAroundPosOfPos(...)
  return self._hub:_GetAroundPosOfPos(...)
end

function SkillScopeCalculator_Base:_InsertPosToResultArea(...)
  return self._hub:_InsertPosToResultArea(...)
end

function SkillScopeCalculator_Base:_CalcCrossExceptBlock(...)
  return self._hub:_CalcCrossExceptBlock(...)
end

function SkillScopeCalculator_Base:_CalcXShapeExceptBlock(...)
  return self._hub:_CalcXShapeExceptBlock(...)
end

function SkillScopeCalculator_Base:_CalcNRowMColSpread(...)
  return self._hub:_CalcNRowMColSpread(...)
end

function SkillScopeCalculator_Base:_GetIntersectionScope(list1, list2)
  local out = {}
  for _, e in ipairs(list1) do
    if table.icontains(list2, e) then
      table.insert(out, e)
    end
  end
  return out
end

function SkillScopeCalculator_Base:_GetExceptScope(list1, list2)
  local out = {}
  for _, e in ipairs(list1) do
    if not table.icontains(list2, e) then
      table.insert(out, e)
    end
  end
  return out
end

function SkillScopeCalculator_Base:_CalFixedPos(posList)
  local arr = {}
  for _, v in ipairs(posList) do
    table.insert(arr, Vector2(v[1], v[2]))
  end
  return arr
end
