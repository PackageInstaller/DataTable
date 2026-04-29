require("scope_base")
_class("SkillScopeCalculator_RandomRectAndCount", SkillScopeCalculator_Base)
SkillScopeCalculator_RandomRectAndCount = SkillScopeCalculator_RandomRectAndCount

function SkillScopeCalculator_RandomRectAndCount:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  local validGridList = self._gridFilter:GetAllValidGridPosList()
  local validGridListCount = #validGridList
  local scopeGridList = {}
  local count = scopeParam[1]
  local column = scopeParam[2]
  local rows = scopeParam[3]
  while count > #scopeGridList do
    local rand = self._gridFilter:_GetRandomNumber(1, validGridListCount)
    local gridList = self:_CalcLeftDownColumnsAndRowsRange(validGridList[rand], column, rows)
    if gridList and #gridList ~= 0 then
      table.insert(scopeGridList, gridList)
    end
  end
  local result = SkillScopeResult:New(SkillScopeType.RandomRectAndCount, centerPos, scopeGridList, validGridList)
  return result
end
