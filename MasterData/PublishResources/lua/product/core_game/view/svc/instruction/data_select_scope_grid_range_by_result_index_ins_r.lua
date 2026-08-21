require("base_ins_r")
_class("DataSelectScopeGridRangeByResultIndexInstruction", BaseInstruction)
DataSelectScopeGridRangeByResultIndexInstruction = DataSelectScopeGridRangeByResultIndexInstruction

function DataSelectScopeGridRangeByResultIndexInstruction:Constructor(paramList)
  if paramList.effectType then
    self._effectType = tonumber(paramList.effectType)
  end
  if paramList.index then
    self._index = tonumber(paramList.index)
  end
  self._noPhaseEnd = paramList.noPhaseEnd
end

function DataSelectScopeGridRangeByResultIndexInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local resultArray
  if self._effectType then
    local result = skillEffectResultContainer:GetEffectResultByArray(self._effectType, self._index)
    if result then
      resultArray = {}
      table.insert(resultArray, result)
    end
  else
    resultArray = {}
    local resultDic = skillEffectResultContainer:GetEffectResultDict()
    for _, v in pairs(resultDic) do
      local arr = v.array
      for i = 1, #arr do
        table.insert(resultArray, arr[i])
      end
    end
  end
  if resultArray == nil or table.count(resultArray) <= 0 then
    return not self._noPhaseEnd and InstructionConst.PhaseEnd or nil
  end
  local gridList = {}
  local specialScopeResultList = {}
  for _, result in pairs(resultArray) do
    local scopeResult = result:GetSkillEffectScopeResult()
    if scopeResult then
      local array = scopeResult:GetAttackRange()
      for _, v in pairs(array) do
        if not self:_IsContainPos(gridList, v) then
          table.insert(gridList, v)
        end
      end
    end
    if result.GetSpecialScopeResultList then
      local specialScopeResult = result:GetSpecialScopeResultList()
      if specialScopeResult and table.count(specialScopeResult) > 0 and not table.icontains(specialScopeResultList, specialScopeResult[1]) then
        table.appendArray(specialScopeResultList, specialScopeResult)
      end
    end
  end
  if table.count(gridList) <= 0 then
    return not self._noPhaseEnd and InstructionConst.PhaseEnd or nil
  end
  phaseContext:SetScopeGridList(gridList)
  phaseContext:SetSpecialScopeResultList(specialScopeResultList)
end

function DataSelectScopeGridRangeByResultIndexInstruction:_IsContainPos(posArr, pos)
  for _, p in pairs(posArr) do
    if pos.x == p.x and pos.y == p.y then
      return true
    end
  end
  return false
end
