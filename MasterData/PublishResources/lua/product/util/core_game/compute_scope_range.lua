_class("ComputeScopeRange", Object)
ComputeScopeRange = ComputeScopeRange

function ComputeScopeRange:Constructor()
end

function ComputeScopeRange.GetNeighbourPos(nBodyAreaCount)
  local vecNeighbourPos
  if 1 == nBodyAreaCount then
    vecNeighbourPos = {
      Vector2(0, 1),
      Vector2(1, 0),
      Vector2(0, -1),
      Vector2(-1, 0)
    }
  elseif 4 == nBodyAreaCount then
    vecNeighbourPos = {
      Vector2(0, 2),
      Vector2(1, 2),
      Vector2(2, 1),
      Vector2(2, 0),
      Vector2(1, -1),
      Vector2(0, -1),
      Vector2(-1, 0),
      Vector2(-1, 1)
    }
  end
  return vecNeighbourPos
end

function ComputeScopeRange.GetBodyArea(nBodyAreaCount)
  local listReturn = {}
  if 1 == nBodyAreaCount then
    listReturn = {
      Vector2(0, 0)
    }
  elseif 4 == nBodyAreaCount then
    listReturn = {
      Vector2(0, 0),
      Vector2(0, 1),
      Vector2(1, 0),
      Vector2(1, 1)
    }
  elseif 9 == nBodyAreaCount then
    listReturn = {
      Vector2(0, 0),
      Vector2(0, 1),
      Vector2(0, 2),
      Vector2(1, 0),
      Vector2(1, 1),
      Vector2(1, 2),
      Vector2(2, 0),
      Vector2(2, 1),
      Vector2(2, 2)
    }
  end
  return listReturn
end

function ComputeScopeRange.ComputeBodyArea(centrePos, nBodyAreaCount, nWalkStep)
  local listReturn = {}
  local listArea = ComputeScopeRange.GetBodyArea(nBodyAreaCount)
  for i = 1, #listArea do
    local posWork = centrePos + listArea[i]
    if nWalkStep then
      listReturn[#listReturn + 1] = ComputeWalkPos:New(posWork, nWalkStep)
    else
      listReturn[#listReturn + 1] = posWork
    end
  end
  return listReturn
end

function ComputeScopeRange.ComputeRange_Walk(centerPos, nBodyAreaCount, nWalkStep, callbackFilter, ...)
  local computeWalkRange = ComputeWalkRange:New()
  computeWalkRange:ComputeRange(centerPos, nBodyAreaCount, nWalkStep, callbackFilter, ...)
  return computeWalkRange:GetResult()
end

function ComputeScopeRange.ComputeRange_WalkOnlyPos(centerPos, nBodyAreaCount, nWalkStep, callbackFilter, ...)
  local computeWalkRange = ComputeWalkRange:New()
  computeWalkRange:ComputeRange(centerPos, nBodyAreaCount, nWalkStep, callbackFilter, ...)
  return computeWalkRange:GetResult()
end

function ComputeScopeRange.ComputeRange_WalkMathPos(centerPos, nBodyAreaCount, nWalkStep, callbackFilter, ...)
  local computeWalkRange = ComputeWalkRange:New()
  computeWalkRange:ComputeRangeByMath(centerPos, nBodyAreaCount, nWalkStep, callbackFilter, ...)
  return computeWalkRange:GetResult()
end

function ComputeScopeRange.ComputeRange_PreviewWithStepAndBlock(centerPos, bodyArea, calcMoveBase, nWalkStep, monsterBlockData, callbackFilter, ...)
  local computeWalkRange = ComputeWalkRange:New()
  computeWalkRange:_InsertTableBodyArea(computeWalkRange.m_listWalkRange, centerPos, centerPos, 0, bodyArea, monsterBlockData, callbackFilter, ...)
  local nextStepCalcPosList = {centerPos}
  for i = 1, nWalkStep do
    local stepIndex = i
    local curStepCalcPosList = {}
    for key, movePos in ipairs(nextStepCalcPosList) do
      local curwalkPosList = computeWalkRange:ComputeRangeWithStepAndBlock(movePos, bodyArea, calcMoveBase, stepIndex, monsterBlockData, callbackFilter, ...)
      for _, pos in ipairs(curwalkPosList) do
        if not table.icontains(curStepCalcPosList, pos) then
          table.insert(curStepCalcPosList, pos)
        end
      end
    end
    nextStepCalcPosList = curStepCalcPosList
  end
  return computeWalkRange:GetResult()
end

function ComputeScopeRange.ComputeRange_CrossScope(centerPos, nBodyAreaCount, nCrossStep)
  local dirs = {
    Vector2(0, 1),
    Vector2(1, 0),
    Vector2(0, -1),
    Vector2(-1, 0)
  }
  local posNeighbour = ComputeScopeRange.GetNeighbourPos(nBodyAreaCount)
  local nDicParam = math.floor(#posNeighbour / #dirs)
  local listReturn = {}
  for i, v in ipairs(posNeighbour) do
    local dir = dirs[math.floor((i + nDicParam - 1) / nDicParam)]
    for j = 0, nCrossStep - 1 do
      if nil == centerPos then
        table.insert(listReturn, v + dir * j)
      else
        table.insert(listReturn, centerPos + v + dir * j)
      end
    end
  end
  return listReturn
end

function ComputeScopeRange.ComputeRange_SquareRing(centerPos, nBodyAreaCount, ringCount, bOnlyMax)
  local nBodyLine = math.floor(math.sqrt(nBodyAreaCount) + 2 * ringCount)
  local listReturn = {}
  for i = 1, nBodyLine do
    for j = 1, nBodyLine do
      local bSelect = false
      if nil == bOnlyMax or false == bOnlyMax then
        if i <= ringCount or i > nBodyLine - ringCount or j <= ringCount or j > nBodyLine - ringCount or ringCount == 0 then
          bSelect = true
        end
      elseif i == 1 or i == nBodyLine or j == 1 or j == nBodyLine then
        bSelect = true
      end
      if bSelect then
        local posData = Vector2(i, j) - Vector2(ringCount + 1, ringCount + 1) + centerPos
        listReturn[#listReturn + 1] = posData
      end
    end
  end
  return listReturn
end

function ComputeScopeRange.ComputeRange_DirectionScope(centerPos, nBodyAreaCount, nStep)
  local dirs = {
    Vector2(0, 1),
    Vector2(1, 0),
    Vector2(0, -1),
    Vector2(-1, 0),
    Vector2(-1, 1),
    Vector2(1, 1),
    Vector2(1, -1),
    Vector2(-1, -1)
  }
  local bodyArea = ComputeScopeRange.GetBodyArea(nBodyAreaCount)
  local listReturn = {}
  for keyBody, valueBody in pairs(bodyArea) do
    for keyDir, valueDir in pairs(dirs) do
      for i = 1, nStep do
        local posWork = valueDir * i + valueBody
        if centerPos then
          posWork = centerPos + centerPos
        end
        if false == table.iconstains(listReturn, posWork) then
          listReturn[#listReturn + 1] = posWork
        end
      end
    end
  end
  return listReturn
end

_class("ComputeWalkPos", Object)
ComputeWalkPos = ComputeWalkPos

function ComputeWalkPos:Constructor(dataPos, dataStep)
  self.m_nPos = dataPos
  self.m_nStep = dataStep
end

function ComputeWalkPos:GetPos()
  return self.m_nPos
end

function ComputeWalkPos:GetStep()
  return self.m_nStep
end

_class("ComputeWalkRange", Object)
ComputeWalkRange = ComputeWalkRange

function ComputeWalkRange:Constructor()
  self.m_nMaxStep = 0
  self.m_listWalkRange = {}
  self.m_listHaveWork = {}
end

function ComputeWalkRange:GetResult()
  return self.m_listWalkRange
end

function ComputeWalkRange:_IsHaveCompute(posWork, nStepIndex)
  local walkStep = self.m_listHaveWork[posWork]
  if nil == walkStep then
    return false
  end
  if nStepIndex > walkStep then
    return true
  end
  return false
end

function ComputeWalkRange:_SetHaveCompute(posWork, nStepIndex)
  self.m_listHaveWork[posWork] = nStepIndex
end

function ComputeWalkRange:_IsHaveRecord(tableWork, dataPos)
  local nCount = #tableWork
  for i = 1, nCount do
    local dataWork = tableWork[i]
    if dataWork and dataWork.m_nPos == dataPos then
      return dataWork
    end
  end
  return nil
end

function ComputeWalkRange:_InsertTable(tableWork, dataPos, dataStep, callbackFilter, ...)
  if callbackFilter and false == callbackFilter:CallHaveReturn(dataPos, ...) then
    return
  end
  local posData = self:_IsHaveRecord(tableWork, dataPos)
  if posData then
    if nil == posData.m_nStep or dataStep < posData.m_nStep then
      posData.m_nStep = dataStep
    end
    return
  end
  local posWalk = ComputeWalkPos:New(dataPos, dataStep)
  table.insert(tableWork, posWalk)
end

function ComputeWalkRange:_CopyTable(tableA, tableB, dataStep, callbackFilter, ...)
  if nil == tableB or nil == tableA then
    return
  end
  for key, value in pairs(tableB) do
    self:_InsertTable(tableA, value, dataStep, callbackFilter, ...)
  end
end

function ComputeWalkRange:ComputeRange(centerPos, nBodyAreaCount, nWalkStep, callbackFilter, ...)
  if nWalkStep <= 0 then
    return
  end
  if 0 >= self.m_nMaxStep then
    self.m_nMaxStep = nWalkStep
    self:_InsertTable(self.m_listWalkRange, centerPos, 0, callbackFilter, ...)
  end
  local listPosCross = ComputeScopeRange.ComputeRange_CrossScope(centerPos, 1, 1)
  local nNewWalkStep = nWalkStep - 1
  local nStepIndex = self.m_nMaxStep - nNewWalkStep
  for key, value in pairs(listPosCross) do
    local listArea = ComputeScopeRange.ComputeBodyArea(value, nBodyAreaCount)
    self:_CopyTable(self.m_listWalkRange, listArea, nStepIndex, callbackFilter, ...)
  end
  self:_SetHaveCompute(centerPos, nStepIndex)
  if 0 < nNewWalkStep then
    for key, value in pairs(listPosCross) do
      local bEnable = true
      if callbackFilter and false == callbackFilter:CallHaveReturn(value, ...) then
        bEnable = false
      end
      if bEnable and false == self:_IsHaveCompute(value, nStepIndex) then
        self:ComputeRange(value, nBodyAreaCount, nNewWalkStep, callbackFilter, ...)
      end
    end
  end
end

function ComputeWalkRange:ComputeRangeByMath(centerPos, nBodyAreaCount, nWalkStep, callbackFilter, ...)
  for i = -nWalkStep, nWalkStep do
    for j = -nWalkStep, nWalkStep do
      local nStep = math.abs(i) + math.abs(j)
      if nWalkStep >= nStep then
        local posWork = Vector2.New(i, j) + centerPos
        local listArea = ComputeScopeRange.ComputeBodyArea(posWork, nBodyAreaCount)
        self:_CopyTable(self.m_listWalkRange, listArea, nStep, callbackFilter, ...)
      end
    end
  end
end

function ComputeWalkRange:ComputeRangeWithStepAndBlock(centerPos, bodyArea, calcMoveBase, nStepIndex, monsterBlockData, callbackFilter, ...)
  local nBodyAreaCount = table.count(bodyArea)
  local listPosCross = ComputeScopeRange.ComputeRange_CrossScope(centerPos, 1, 1)
  local listPosCrossCanMove = {}
  for key, value in ipairs(listPosCross) do
    local listArea
    if calcMoveBase == true then
      listArea = {value}
    else
      listArea = ComputeScopeRange.ComputeBodyArea(value, nBodyAreaCount)
    end
    if callbackFilter and true == callbackFilter:CallHaveReturn(centerPos, value, bodyArea, monsterBlockData, ...) then
      self:_CopyTableBodyArea(self.m_listWalkRange, listArea, nStepIndex, bodyArea, monsterBlockData, callbackFilter, ...)
      table.insert(listPosCrossCanMove, value)
    end
  end
  self:_SetHaveCompute(centerPos, nStepIndex)
  return listPosCrossCanMove
end

function ComputeWalkRange:_InsertTableBodyArea(tableWork, startPos, dataPos, dataStep, bodyArea, monsterBlockData, callbackFilter, ...)
  if callbackFilter and false == callbackFilter:CallHaveReturn(startPos, dataPos, bodyArea, monsterBlockData, ...) then
    return
  end
  local posData = self:_IsHaveRecord(tableWork, dataPos)
  if posData then
    if nil == posData.m_nStep or dataStep < posData.m_nStep then
      posData.m_nStep = dataStep
    end
    return
  end
  local posWalk = ComputeWalkPos:New(dataPos, dataStep)
  table.insert(tableWork, posWalk)
end

function ComputeWalkRange:_CopyTableBodyArea(tableA, tableB, dataStep, bodyArea, monsterBlockData, callbackFilter, ...)
  if nil == tableB or nil == tableA then
    return
  end
  for key, value in pairs(tableB) do
    self:_InsertTableBodyArea(tableA, value, value, dataStep, bodyArea, monsterBlockData, callbackFilter, ...)
  end
end

_class("AIWalkStepData", Object)
AIWalkStepData = AIWalkStepData

function AIWalkStepData:Constructor()
  self.m_posList = {}
end

function AIWalkStepData:AddData(posData)
  self.m_posList[#self.m_posList + 1] = posData
end

function AIWalkStepData:ReplaceListData(posListData)
  self.m_posList = posListData
end

function AIWalkStepData:GetStepCount()
  return table.count(self.m_posList)
end

function AIWalkStepData:GetStepPosList()
  return self.m_posList
end
