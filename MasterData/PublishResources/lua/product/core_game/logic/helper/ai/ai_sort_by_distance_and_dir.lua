_class("AiSortByDistanceAndDir", Object)
AiSortByDistanceAndDir = AiSortByDistanceAndDir

function AiSortByDistanceAndDir:Constructor(centerPos, workPos, curPos, nIndex)
  self.centerPos = centerPos
  self.workPos = workPos
  self.curPos = curPos
  self.index = nIndex or 0
  self.distance = self:Distance()
end

function AiSortByDistanceAndDir:GetDistance()
  return self.distance
end

function AiSortByDistanceAndDir:GetPosData()
  return self.workPos
end

function AiSortByDistanceAndDir:Distance()
  return GameHelper.ComputeLogicDistance(self.centerPos, self.workPos)
end

function AiSortByDistanceAndDir:GetUpAngle()
  local angle
  local vecUp = Vector2.up
  local vecTarget = self.curPos - self.centerPos
  vecTarget = vecTarget.normalized
  local dot = vecUp.x * vecTarget.x + vecUp.y * vecTarget.y
  if math.abs(dot - 1.0) <= 1.0E-6 then
    angle = 0
  elseif math.abs(dot + 1.0) <= 1.0E-6 then
    angle = math.pi
  else
    angle = math.acos(dot)
    local cross = vecUp.x * vecTarget.y - vecTarget.x * vecUp.y
    if cross < 0 then
      angle = 2 * math.pi - angle
    end
  end
  local degree = angle * 180.0 / math.pi
  return degree
end

function AiSortByDistanceAndDir._ComparerByNearAndDir(dataA, dataB)
  local nDistanceA = dataA:GetDistance()
  local nDistanceB = dataB:GetDistance()
  local angleUpToA = dataA:GetUpAngle()
  local angleUpToB = dataB:GetUpAngle()
  if nDistanceA > nDistanceB then
    return -1
  elseif nDistanceA < nDistanceB then
    return 1
  elseif angleUpToA > angleUpToB then
    return -1
  elseif angleUpToA > angleUpToB then
    return 1
  else
    return dataB.index - dataA.index
  end
end
