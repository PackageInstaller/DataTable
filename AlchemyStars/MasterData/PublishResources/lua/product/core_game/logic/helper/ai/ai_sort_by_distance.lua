_class("AiSortByDistance", Object)
AiSortByDistance = AiSortByDistance

function AiSortByDistance:Constructor(centrePos, dataPos, nIndex)
  self.centre = centrePos
  self.data = dataPos
  self.m_nIndex = nIndex or 0
  self.m_nDistance = self:Distance()
end

function AiSortByDistance:GetDistance()
  return self.m_nDistance
end

function AiSortByDistance:GetPosData()
  return self.data
end

function AiSortByDistance:Distance()
  return GameHelper.ComputeLogicDistance(self.centre, self.data)
end

function AiSortByDistance._ComparerByFar(dataA, dataB)
  local nDistanceA = dataA:GetDistance()
  local nDistanceB = dataB:GetDistance()
  if nDistanceA > nDistanceB then
    return 1
  elseif nDistanceA < nDistanceB then
    return -1
  else
    return dataB.m_nIndex - dataA.m_nIndex
  end
end

function AiSortByDistance._ComparerByNear(dataNew, dataOld)
  local nDistanceA = dataNew:GetDistance()
  local nDistanceB = dataOld:GetDistance()
  if nDistanceA > nDistanceB then
    return -1
  elseif nDistanceA < nDistanceB then
    return 1
  else
    return dataOld.m_nIndex - dataNew.m_nIndex
  end
end

function AiSortByDistance._ComparerByNear_2(dataA, dataB)
  if dataA.data == dataB.data then
    return 0
  end
  return AiSortByDistance._ComparerByNear(dataA, dataB)
end
