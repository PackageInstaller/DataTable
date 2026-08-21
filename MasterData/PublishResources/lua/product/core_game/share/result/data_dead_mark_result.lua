_class("DataDeadMarkResult", Object)
DataDeadMarkResult = DataDeadMarkResult

function DataDeadMarkResult:Constructor(list)
  self._deadEntityIDList = list or {}
end

function DataDeadMarkResult:AddDeadEntityID(eid)
  table.insert(self._deadEntityIDList, eid)
end

function DataDeadMarkResult:GetDeadEntityIDList()
  return self._deadEntityIDList
end
