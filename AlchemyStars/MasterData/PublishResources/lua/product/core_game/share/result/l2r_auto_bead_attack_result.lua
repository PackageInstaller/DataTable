_class("L2R_AutoBeadAttackResult", Object)
L2R_AutoBeadAttackResult = L2R_AutoBeadAttackResult

function L2R_AutoBeadAttackResult:Constructor(dataList, holderEntityID)
  self._autoBeadAtkResultList = dataList
  self._holderEntityID = holderEntityID
end

function L2R_AutoBeadAttackResult:GetHolderEntityID()
  return self._holderEntityID
end

function L2R_AutoBeadAttackResult:GetHolderAutoBeadSkillDataList(entityID)
  local autoBeadResData = self._autoBeadAtkResultList[entityID]
  if autoBeadResData == nil then
    return nil
  end
  return autoBeadResData:GetAutoBeadAttackResultAtkDataList()
end

function L2R_AutoBeadAttackResult:AutoBeadAttackResultHasDamage(entityID)
  local autoBeadResData = self._autoBeadAtkResultList[entityID]
  if autoBeadResData == nil then
    return false
  end
  local effectResListTable = autoBeadResData:GetAutoBeadAttackResultAtkDataList()
  for i, v in ipairs(effectResListTable) do
    local autoBeadAttackData = v
    if autoBeadAttackData:HasDamage() then
      return true
    end
  end
  return false
end

function L2R_AutoBeadAttackResult:GetDeadEntityIDListByHolder(entityID)
  local autoBeadResData = self._autoBeadAtkResultList[entityID]
  if autoBeadResData == nil then
    return nil
  end
  return autoBeadResData:GetDeadEntityIDList()
end
