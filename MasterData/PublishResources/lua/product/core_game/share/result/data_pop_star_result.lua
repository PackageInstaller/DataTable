_class("DataPopStarResult", Object)
DataPopStarResult = DataPopStarResult

function DataPopStarResult:Constructor()
  self._popNum = 0
  self._indexChange = false
  self._delSet = nil
  self._moveSet = nil
  self._newSet = nil
  self._delTrapList = nil
  self._moveTrapList = nil
  self._newTrapList = nil
  self._popConnectPieces = {}
  self._trapSkillResults = {}
  self._totalPopNum = 0
end

function DataPopStarResult:GetPopNum()
  return self._popNum
end

function DataPopStarResult:SetPopNum(num)
  self._popNum = num
end

function DataPopStarResult:IsIndexChange()
  return self._indexChange
end

function DataPopStarResult:SetIndexChange()
  self._indexChange = true
end

function DataPopStarResult:GetDelSet()
  return self._delSet
end

function DataPopStarResult:SetDelSet(del)
  self._delSet = del
end

function DataPopStarResult:GetMoveSet()
  return self._moveSet
end

function DataPopStarResult:SetMoveSet(move)
  self._moveSet = move
end

function DataPopStarResult:GetNewSet()
  return self._newSet
end

function DataPopStarResult:SetNewSet(new)
  self._newSet = new
end

function DataPopStarResult:GetDelTrapList()
  return self._delTrapList
end

function DataPopStarResult:SetDelTrapList(del)
  self._delTrapList = del
end

function DataPopStarResult:GetMoveTrapList()
  return self._moveTrapList
end

function DataPopStarResult:SetMoveTrapList(move)
  self._moveTrapList = move
end

function DataPopStarResult:GetNewTrapList()
  return self._newTrapList
end

function DataPopStarResult:SetNewTrapList(new)
  self._newTrapList = new
end

function DataPopStarResult:GetPopConnectPieces()
  return self._popConnectPieces
end

function DataPopStarResult:SetPopConnectPieces(popConnectPieces)
  self._popConnectPieces = popConnectPieces
end

function DataPopStarResult:AddTrapSkillResult(entityID, skillResult, triggerEntityID)
  table.insert(self._trapSkillResults, {
    entityID,
    skillResult,
    triggerEntityID
  })
end

function DataPopStarResult:GetTrapSkillResults()
  return self._trapSkillResults
end

function DataPopStarResult:GetTotalPopNum()
  return self._totalPopNum
end

function DataPopStarResult:SetTotalPopNum(num)
  self._totalPopNum = num
end
