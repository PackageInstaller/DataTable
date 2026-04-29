_class("DataPetDeadResult", Object)
DataPetDeadResult = DataPetDeadResult

function DataPetDeadResult:Constructor()
  self._petDeadEntityIDList = {}
end

function DataPetDeadResult:DataSetDeadPetEntityIDList(deadList)
  self._petDeadEntityIDList = deadList
end

function DataPetDeadResult:DataGetDeadPetEntityIDList()
  return self._petDeadEntityIDList
end
