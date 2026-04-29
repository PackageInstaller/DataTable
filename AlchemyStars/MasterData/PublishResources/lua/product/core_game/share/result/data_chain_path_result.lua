_class("DataChainPathResult", Object)
DataChainPathResult = DataChainPathResult

function DataChainPathResult:Constructor()
  self._chainPathResult = {}
  self._chainElementResult = nil
  self._chainTeamResult = {}
  self._cutChainPathResult = {}
  self._pathChainRate = {}
end

function DataChainPathResult:SetChainPathResult(res)
  self._chainPathResult = res
end

function DataChainPathResult:GetChainPathResult()
  return self._chainPathResult
end

function DataChainPathResult:GetChainElementResult()
  return self._chainElementResult
end

function DataChainPathResult:SetChainElementResult(elem)
  self._chainElementResult = elem
end

function DataChainPathResult:SetPathChainRate(v)
  self._pathChainRate = v
end

function DataChainPathResult:GetPathChainRate()
  return self._pathChainRate
end

function DataChainPathResult:GetChainTeamResult()
  return self._chainTeamResult
end

function DataChainPathResult:SetChainTeamResult(team)
  self._chainTeamResult = team
end

function DataChainPathResult:SetCutChainPathResult(cutChainPathResult)
  self._cutChainPathResult = cutChainPathResult
end

function DataChainPathResult:GetCutChainPathResult()
  return self._cutChainPathResult
end
