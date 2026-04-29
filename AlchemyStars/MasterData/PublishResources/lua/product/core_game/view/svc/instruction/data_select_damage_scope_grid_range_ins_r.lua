require("base_ins_r")
_class("DataSelectDamageScopeGridRangeInstruction", BaseInstruction)
DataSelectDamageScopeGridRangeInstruction = DataSelectDamageScopeGridRangeInstruction

function DataSelectDamageScopeGridRangeInstruction:Constructor(paramList)
  if paramList.damageInfoIndex then
    self._damageInfoIndex = tonumber(paramList.damageInfoIndex)
  end
  self._noPhaseEnd = paramList.noPhaseEnd
end

function DataSelectDamageScopeGridRangeInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local resultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.Damage, self._damageInfoIndex)
  if resultArray == nil or table.count(resultArray) <= 0 then
    return not self._noPhaseEnd and InstructionConst.PhaseEnd or nil
  end
  local gridList = {}
  local specialScopeResultList = {}
  for _, result in pairs(resultArray) do
    local damageResult = result
    local damagePos = damageResult:GetGridPos()
    if not self:_IsContainPos(gridList, damagePos) then
      table.insert(gridList, damagePos)
    end
  end
  if table.count(gridList) <= 0 then
    return not self._noPhaseEnd and InstructionConst.PhaseEnd or nil
  end
  phaseContext:SetScopeGridList(gridList)
  phaseContext:SetSpecialScopeResultList(specialScopeResultList)
end

function DataSelectDamageScopeGridRangeInstruction:_IsContainPos(posArr, pos)
  for _, p in pairs(posArr) do
    if pos.x == p.x and pos.y == p.y then
      return true
    end
  end
  return false
end
