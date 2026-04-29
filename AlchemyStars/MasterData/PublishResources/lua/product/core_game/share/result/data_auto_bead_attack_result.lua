_class("DataAutoBeadAttackResult", Object)
DataAutoBeadAttackResult = DataAutoBeadAttackResult

function DataAutoBeadAttackResult:Constructor()
  self._deadEntityIDList = {}
  self._autoBeadAttackDataList = {}
end

function DataAutoBeadAttackResult:SetDeadEntityIDList(ids)
  self._deadEntityIDList = ids
end

function DataAutoBeadAttackResult:GetDeadEntityIDList()
  return self._deadEntityIDList
end

function DataAutoBeadAttackResult:SetAutoBeadAttackResultAtkDataList(dataList)
  self._autoBeadAttackDataList = dataList
end

function DataAutoBeadAttackResult:GetAutoBeadAttackResultAtkDataList()
  return self._autoBeadAttackDataList
end
