_class("SkillScopeFilter_Base", Object)
SkillScopeFilter_Base = SkillScopeFilter_Base

function SkillScopeFilter_Base:DoModifyRange(scopeResult, filterParam, passParam)
  Log.exception(self._className, " NotImplementedException at : ", Log.traceback())
end

function SkillScopeFilter_Base:AddPosToScopeResult(scopeResult, posArray)
  local attackGridRange = scopeResult:GetAttackRange()
  local wholeGridRange = scopeResult:GetWholeGridRange()
  for _, gridPos in ipairs(posArray) do
    if not table.icontains(attackGridRange, gridPos) then
      table.insert(attackGridRange, gridPos)
    end
    if not table.icontains(wholeGridRange, gridPos) then
      table.insert(wholeGridRange, gridPos)
    end
  end
end

function SkillScopeFilter_Base:RemovePosFromScopeResult(scopeResult, posArray)
  local attackGridRange = scopeResult:GetAttackRange()
  for _, gridPos in ipairs(posArray) do
    table.removev(attackGridRange, gridPos)
  end
end
