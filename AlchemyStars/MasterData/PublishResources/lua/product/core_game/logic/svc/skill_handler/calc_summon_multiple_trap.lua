_class("SkillEffectCalc_SummonMultipleTrap", Object)
SkillEffectCalc_SummonMultipleTrap = SkillEffectCalc_SummonMultipleTrap

function SkillEffectCalc_SummonMultipleTrap:Constructor(world)
  self._world = world
  self._skillEffectService = self._world:GetService("SkillEffectCalc")
end

function SkillEffectCalc_SummonMultipleTrap:DoSkillEffectCalculator(skillEffectCalcParam)
  local summonMultipleTrapParam = skillEffectCalcParam.skillEffectParam
  local colorDic = summonMultipleTrapParam:GetSelectedColorTable()
  local trapID = summonMultipleTrapParam:GetTrapID()
  local maxCount = summonMultipleTrapParam:GetMaxCount() or #skillEffectCalcParam.skillRange
  local randomSummon = summonMultipleTrapParam:IsRandom()
  local absPosArray = summonMultipleTrapParam:GetAbsPosArray()
  local isEmptyPosOnly = summonMultipleTrapParam:IsEmptyPosOnly()
  local useBoardRandom = summonMultipleTrapParam:IsUseBoardRandom()
  local blockSummonTrapType = summonMultipleTrapParam:GetBlockSummonTrapType()
  local sortValidPosType = summonMultipleTrapParam:GetSortValidPosType()
  local findPosEmptyOrTrap = summonMultipleTrapParam:IsEmptyOrTrap()
  local findPosTrapId = summonMultipleTrapParam:GetFindPosTrapId()
  local excludeTraps = summonMultipleTrapParam:GetExcludeTraps()
  local bFindRandEmptyPosIfNoValid = summonMultipleTrapParam:IsFindRandEmptyPosIfNoValid()
  local ignoreBlock = summonMultipleTrapParam:IgnoreBlock()
  local ignoreAbyss = summonMultipleTrapParam:GetIgnoreAbyss()
  local blockFlag = BlockFlag.SummonTrap
  if ignoreBlock or ignoreAbyss then
    blockFlag = 0
  end
  if summonMultipleTrapParam:IsUseTetrisFeatureCount() then
    local featureSvcL = self._world:GetService("FeatureLogic")
    maxCount = featureSvcL:GetTetrisMainColorCount()
    featureSvcL:ClearTetrisMainColorCount()
  end
  local randomSvc = self._world:GetService("RandomLogic")
  local boardServiceLogic = self._world:GetService("BoardLogic")
  local trapServiceLogic = self._world:GetService("TrapLogic")
  local utilData = self._world:GetService("UtilData")
  local boardCmpt = self._world:GetBoardEntity():Board()
  local teamLeaderElement = summonMultipleTrapParam:GetTeamLeaderElement()
  if teamLeaderElement ~= nil then
    local teamEntity = self._world:Player():GetCurrentTeamEntity()
    local teamLeader = teamEntity:Team():GetTeamLeaderEntity()
    local element = teamLeader:Element():GetPrimaryType()
    if teamLeaderElement == true then
      colorDic = {}
      colorDic[element] = true
    else
      colorDic[element] = nil
    end
  end
  local validPosArray = {}
  if 0 < #absPosArray then
    validPosArray = absPosArray
  else
    for _, gridPos in ipairs(skillEffectCalcParam.skillRange) do
      local checkPosType = utilData:FindPieceElement(gridPos)
      if colorDic[checkPosType] then
        table.insert(validPosArray, gridPos)
      end
    end
    if validPosArray then
      local _validPosArray = {}
      for _, gridPos in ipairs(validPosArray) do
        if trapServiceLogic:CanSummonTrapOnPos(gridPos, trapID, blockFlag, ignoreAbyss) and not self:IsPosHasBlockTrap(gridPos, blockSummonTrapType) then
          table.insert(_validPosArray, gridPos)
        end
      end
      validPosArray = _validPosArray
    end
  end
  if isEmptyPosOnly then
    local boardsvc = self._world:GetService("BoardLogic")
    local t = {}
    for _, gridPos in ipairs(validPosArray) do
      if boardsvc:IsPosEmptyExceptConveyorNoDeadMark(gridPos) then
        table.insert(t, gridPos)
      end
    end
    if 0 < #t then
      validPosArray = t
    end
  end
  local excludePosList = {}
  local trapSvc = self._world:GetService("TrapLogic")
  if excludeTraps then
    for _, excludeTrapID in ipairs(excludeTraps) do
      local trapPosList = trapSvc:FindTrapPosByTrapID(excludeTrapID)
      if 0 < #trapPosList then
        table.appendArray(excludePosList, trapPosList)
      end
    end
  end
  local oriValidPosArray = {}
  local tmpPosList = {}
  for _, pos in ipairs(validPosArray) do
    if not table.icontains(excludePosList, pos) then
      table.insert(tmpPosList, pos)
    end
    table.insert(oriValidPosArray, pos)
  end
  validPosArray = tmpPosList
  if bFindRandEmptyPosIfNoValid and #validPosArray == 0 and 0 < #oriValidPosArray then
    local utilScopeSvc = self._world:GetService("UtilScopeCalc")
    local pieces = utilScopeSvc:GetEmptyPieces()
    local r = randomSvc:LogicRand(1, #pieces)
    local dropPos = pieces[r]
    local centerPos = oriValidPosArray[1]
    local listArea = SortedArray:New(Algorithm.COMPARE_CUSTOM, AiSortByDistance._ComparerByNear)
    listArea:AllowDuplicate()
    for i = 1, #pieces do
      AINewNode.InsertSortedArray(listArea, centerPos, pieces[i], i)
    end
    local posSize = listArea:Size()
    for i = 1, posSize do
      local nearestPos = listArea:GetAt(i):GetPosData()
      if trapServiceLogic:CanSummonTrapOnPos(nearestPos, trapID) then
        table.insert(validPosArray, nearestPos)
        break
      end
    end
  end
  if findPosEmptyOrTrap then
    local utilScopeSvc = self._world:GetService("UtilScopeCalc")
    local pieces = utilScopeSvc:GetEmptyPieces(validPosArray)
    if #pieces == 0 then
      pieces = utilScopeSvc:GetTrapPiecesExceptTrapID(trapID, validPosArray)
    end
    validPosArray = pieces
  end
  local additionalCount = 0
  local scopeType = summonMultipleTrapParam:GetAdditionalCountScopeType()
  local rawScopeParam = summonMultipleTrapParam:GetAdditionalCountScopeParam()
  if scopeType then
    local parser = SkillScopeParamParser:New()
    local scopeParam = parser:ParseScopeParam(scopeType, rawScopeParam)
    local utilScopeSvc = self._world:GetService("UtilScopeCalc")
    local calcScope = utilScopeSvc:GetSkillScopeCalc()
    local additionalCountScopeResult = calcScope:ComputeScopeRange(scopeType, scopeParam, skillEffectCalcParam.centerPos, {
      Vector2.zero
    }, Vector2.up, SkillTargetType.Team, skillEffectCalcParam.centerPos)
    local elementDic = summonMultipleTrapParam:GetAdditionalCountElementDic()
    local blsvc = self._world:GetService("BoardLogic")
    for _, v2GridPos in ipairs(additionalCountScopeResult) do
      local pieceType = blsvc:GetPieceType(v2GridPos)
      if elementDic[pieceType] then
        additionalCount = additionalCount + 1
      end
    end
    local maxAdditionalCount = summonMultipleTrapParam:GetMaxAdditionalCount() or additionalCount
    additionalCount = math.min(additionalCount, maxAdditionalCount)
  end
  local summonTrapResultArray = {}
  if randomSummon then
    local randomFunc
    if useBoardRandom then
      randomFunc = randomSvc.BoardLogicRand
    else
      randomFunc = randomSvc.LogicRand
    end
    local randCount = maxCount
    local minRandCount, maxRandCount = summonMultipleTrapParam:GetRandCount()
    if minRandCount and maxRandCount then
      randCount = randomFunc(randomSvc, minRandCount, maxRandCount)
    end
    randCount = randCount + additionalCount
    while randCount > #summonTrapResultArray and 0 < #validPosArray do
      local randIdx = randomFunc(randomSvc, 1, #validPosArray)
      local gridPos = table.remove(validPosArray, randIdx)
      table.insert(summonTrapResultArray, SkillSummonTrapEffectResult:New(trapID, gridPos, summonMultipleTrapParam:IsTransferDisabled()))
    end
  else
    maxCount = maxCount + additionalCount
    local sortedValidPosArray = self:SortValidPiecePos(sortValidPosType, validPosArray, skillEffectCalcParam.centerPos, summonMultipleTrapParam)
    for _, gridPos in ipairs(sortedValidPosArray) do
      if maxCount <= #summonTrapResultArray then
        break
      end
      table.insert(summonTrapResultArray, SkillSummonTrapEffectResult:New(trapID, gridPos, summonMultipleTrapParam:IsTransferDisabled()))
    end
  end
  return summonTrapResultArray
end

function SkillEffectCalc_SummonMultipleTrap:IsPosHasBlockTrap(pos, blockSummonTrapType)
  if not blockSummonTrapType then
    return false
  end
  local utilSvc = self._world:GetService("UtilData")
  local isValidPos = utilSvc:IsValidPiecePos(pos)
  if not isValidPos then
    return false
  end
  local samePosTraps = utilSvc:GetTrapsAtPos(pos)
  if #samePosTraps == 0 then
    return false
  end
  for _, e in ipairs(samePosTraps) do
    local trapCmpt = e:Trap()
    local type = trapCmpt:GetTrapType()
    if table.icontains(blockSummonTrapType, type) and trapCmpt:IsBlockSummon() then
      return true
    end
  end
  return false
end

function SkillEffectCalc_SummonMultipleTrap:SortValidPiecePos(type, array, centerPos, summonMultipleTrapParam)
  if type == SummonMultipleTrapSortType.RingFarToNear then
    local t = self:_SortValidPiecePosByRingFarToNear(array, centerPos, summonMultipleTrapParam)
    return t
  elseif type == SummonMultipleTrapSortType.ByColorPriority then
    local t = self:_SortValidPiecePosByColorPriority(array, centerPos, summonMultipleTrapParam)
    return t
  end
  return array
end

function SkillEffectCalc_SummonMultipleTrap:_SortValidPiecePosByRingFarToNear(array, centerPos, summonMultipleTrapParam)
  local dicPosByRing = {}
  local tablePosByRing = {}
  for _, candidate in ipairs(array) do
    local disX = math.abs(centerPos.x - candidate.x)
    local disY = math.abs(centerPos.y - candidate.y)
    local disRingCount = math.max(disX, disY) - 1
    if not dicPosByRing[disRingCount] then
      local t = {
        array = {},
        ring = disRingCount
      }
      dicPosByRing[disRingCount] = t
      table.insert(tablePosByRing, t)
    end
    table.insert(dicPosByRing[disRingCount].array, candidate)
  end
  table.sort(tablePosByRing, function(a, b)
    return a.ring > b.ring
  end)
  local t = {}
  local randomSvc = self._world:GetService("RandomLogic")
  for _, data in ipairs(tablePosByRing) do
    local shuffled = table.cloneconf(data.array)
    local maxn = #data.array
    for i = 1, maxn do
      local rand = randomSvc:LogicRand(1, maxn)
      shuffled[i], shuffled[rand] = shuffled[rand], shuffled[i]
    end
    data.shuffled = shuffled
    table.appendArray(t, shuffled)
  end
  return t
end

function SkillEffectCalc_SummonMultipleTrap:_SortValidPiecePosByColorPriority(array, centerPos, summonMultipleTrapParam)
  local colorPriorityDic = summonMultipleTrapParam:GetColorPriorityDic()
  if colorPriorityDic then
    local utilData = self._world:GetService("UtilData")
    local dicPosByPriority = {}
    local tablePosByPriority = {}
    for _, gridPos in ipairs(array) do
      local posPieceType = utilData:FindPieceElement(gridPos)
      local piecePriority = colorPriorityDic[posPieceType]
      if piecePriority then
        if not dicPosByPriority[piecePriority] then
          local t = {
            array = {},
            priority = piecePriority
          }
          dicPosByPriority[piecePriority] = t
          table.insert(tablePosByPriority, t)
        end
        table.insert(dicPosByPriority[piecePriority].array, gridPos)
      end
    end
    table.sort(tablePosByPriority, function(a, b)
      return a.priority > b.priority
    end)
    local t = {}
    local randomSvc = self._world:GetService("RandomLogic")
    for _, data in ipairs(tablePosByPriority) do
      local shuffled = table.cloneconf(data.array)
      local maxn = #data.array
      for i = 1, maxn do
        local rand = randomSvc:LogicRand(1, maxn)
        shuffled[i], shuffled[rand] = shuffled[rand], shuffled[i]
      end
      data.shuffled = shuffled
      table.appendArray(t, shuffled)
    end
    return t
  end
  return array
end

SummonMultipleTrapSortType = {RingFarToNear = 1, ByColorPriority = 2}
_enum("SummonMultipleTrapSortType", SummonMultipleTrapSortType)
