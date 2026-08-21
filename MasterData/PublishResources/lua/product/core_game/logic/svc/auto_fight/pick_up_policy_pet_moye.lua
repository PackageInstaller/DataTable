require("pick_up_policy_base")
_class("PickUpPolicy_PetMoye", PickUpPolicy_Base)
PickUpPolicy_PetMoye = PickUpPolicy_PetMoye

function PickUpPolicy_PetMoye:CalcAutoFightPickUpPolicy(calcParam)
  local petEntity = calcParam.petEntity
  local petPos = petEntity:GetGridPosition():Clone()
  local activeSkillID = calcParam.activeSkillID
  local posList = {}
  local attackPosList = {}
  local targetIDList = {}
  if self._world:MatchType() == MatchType.MT_BlackFist then
    return posList, attackPosList, targetIDList
  end
  local configSvc = self._world:GetService("Config")
  local skillCfgData = configSvc:GetSkillConfigData(activeSkillID)
  local pickUpParam = skillCfgData:GetSkillPickParam()
  local depth = pickUpParam[1] or 0
  local pieceType = pickUpParam[2] or PieceType.Blue
  local canLinkMonster = (pickUpParam[3] or 0) == 1
  if depth == 0 then
    return posList, attackPosList, targetIDList
  end
  local firstPickValidScopeParam = pickUpParam.firstPickValidScopeList or {}
  local trapIDList = pickUpParam.trapIdList or {}
  local pieceTypeList = {pieceType}
  local targetEntity
  local utilScope = self._world:GetService("UtilScopeCalc")
  local monsterList, monsterPosList = utilScope:SelectNearestMonsterOnPos(petPos, 99)
  local utilDataSvc = self._world:GetService("UtilData")
  local trapPosIndexList = {}
  local trapGroup = self._world:GetGroup(self._world.BW_WEMatchers.TrapID)
  for _, trap in ipairs(trapGroup:GetEntities()) do
    if not trap:HasDeadMark() and table.icontains(trapIDList, trap:Trap():GetTrapID()) then
      local trapPos = trap:GetGridPosition()
      local trapPosIndex = Vector2.Pos2Index(trapPos)
      table.insert(trapPosIndexList, trapPosIndex)
    end
  end
  local firstScopeType = firstPickValidScopeParam[1].ScopeType
  local firstScopeParam = firstPickValidScopeParam[1].ScopeParam
  local firstTargetType = firstPickValidScopeParam[1].TargetType
  local firstScopeCenterType = firstPickValidScopeParam[1].ScopeCenterType
  local scopeCalculator = utilScope:GetSkillScopeCalc()
  local tmpResult = scopeCalculator:ComputeScopeRange(firstScopeType, firstScopeParam, petPos, petEntity:BodyArea():GetArea(), petEntity:GetGridDirection(), firstTargetType, petPos, petEntity)
  local attackRange = tmpResult:GetAttackRange()
  for i, pos in ipairs(monsterPosList) do
    table.removev(attackRange, pos)
  end
  local targetBodyAreaPosList = {}
  local canBeHitMonsterList = {}
  if monsterList and 0 < #monsterList then
    for i, monster in ipairs(monsterList) do
      local targetBodyArea = monster:BodyArea():GetArea()
      local targetPos = monster:GetGridPosition()
      for _, value in ipairs(targetBodyArea) do
        local workPos = targetPos + value
        local pieceTypeWork = utilDataSvc:GetPieceType(targetPos)
        if pieceTypeWork == pieceType then
          if not table.icontains(canBeHitMonsterList, monster) then
            table.insert(canBeHitMonsterList, monster)
          end
          break
        end
      end
      if targetEntity then
      end
    end
  end
  if 0 < table.count(canBeHitMonsterList) then
    for i, monster in ipairs(canBeHitMonsterList) do
      local targetBodyArea = monster:BodyArea():GetArea()
      local targetPos = monster:GetGridPosition()
      for _, value in ipairs(targetBodyArea) do
        local workPos = targetPos + value
        local pieceTypeWork = utilDataSvc:GetPieceType(targetPos)
        if pieceTypeWork == pieceType then
          table.insert(targetBodyAreaPosList, workPos)
        end
      end
      table.sort(targetBodyAreaPosList, function(a, b)
        local disA = Vector2.Distance(petPos, a)
        local disB = Vector2.Distance(petPos, b)
        return disA < disB
      end)
      local nearestBodyPos = targetBodyAreaPosList[1]
      table.sort(attackRange, function(a, b)
        local disA = Vector2.Distance(nearestBodyPos, a)
        local disB = Vector2.Distance(nearestBodyPos, b)
        return disA < disB
      end)
      local posStart = attackRange[1]
      targetEntity = monster
      targetIDList = {
        targetEntity:GetID()
      }
      posList = self:FindPath_MonsterMoveGridByParam(petEntity, targetEntity, pieceTypeList, depth, canLinkMonster, trapPosIndexList, posStart)
      attackPosList = posList
      if posList and 1 < table.count(posList) then
        return posList, attackPosList, targetIDList
      end
    end
  end
  if monsterList and 0 < #monsterList then
    targetEntity = monsterList[1]
  end
  if not targetEntity then
    return posList, attackPosList, targetIDList
  end
  targetIDList = {
    targetEntity:GetID()
  }
  local posStart = petPos
  local targetBodyArea = targetEntity:BodyArea():GetArea()
  local targetPos = targetEntity:GetGridPosition()
  targetBodyAreaPosList = {}
  for _, value in ipairs(targetBodyArea) do
    local workPos = targetPos + value
    table.insert(targetBodyAreaPosList, workPos)
    if table.icontains(attackRange, workPos) then
    end
  end
  table.sort(targetBodyAreaPosList, function(a, b)
    local disA = Vector2.Distance(petPos, a)
    local disB = Vector2.Distance(petPos, b)
    return disA < disB
  end)
  local nearestBodyPos = targetBodyAreaPosList[1]
  table.sort(attackRange, function(a, b)
    local disA = Vector2.Distance(nearestBodyPos, a)
    local disB = Vector2.Distance(nearestBodyPos, b)
    return disA < disB
  end)
  posStart = attackRange[1]
  posList = self:FindPath_MonsterMoveGridByParam(petEntity, targetEntity, pieceTypeList, depth, canLinkMonster, trapPosIndexList, posStart)
  attackPosList = posList
  return posList, attackPosList, targetIDList
end

function PickUpPolicy_PetMoye:FindPath_MonsterMoveGridByParam(casterEntity, targetEntity, pieceTypeList, depth, canLinkMonster, trapPosIndexList, posStart)
  local movePath = {}
  self._diNaChainPaths = {}
  self._diNaChainIndexPaths = {}
  self._diNaMoveForward = false
  self._diNaConnectMap = {}
  self._HighConnectRateCutLen = 0
  self._maxlen = 0
  self._cutlen = 0
  self:_BuildConnectMapByPieceTypeList(casterEntity, pieceTypeList, trapPosIndexList, posStart)
  self._HighConnectRateCutLen = self:_CalcHighConnectRateCutLen(casterEntity, posStart)
  self:_CalcAllMovePathByPieceTypeList(casterEntity, pieceTypeList, depth, trapPosIndexList, posStart)
  movePath = self:_FindPathNearToTarget4(targetEntity, trapPosIndexList)
  if #movePath < 1 then
    movePath = {posStart}
  end
  local targetPos = targetEntity:GetGridPosition()
  local utilDataSvc = self._world:GetService("UtilData")
  local tpPieceType = utilDataSvc:GetPieceType(targetPos)
  if canLinkMonster and tpPieceType == PieceType.Blue then
    local endPos = movePath[#movePath]
    local endPosIndex = Vector2.Pos2Index(endPos)
    local posIndex = Vector2.Pos2Index(targetPos)
    local aroundPosList = self:_GetPosIndexListByOffset(posIndex, Offset8)
    if table.icontains(aroundPosList, endPosIndex) then
      movePath[#movePath + 1] = targetPos
    end
  end
  if #movePath <= 1 then
    movePath = {}
  end
  self._diNaChainPaths = {}
  self._diNaChainIndexPaths = {}
  self._diNaMoveForward = false
  self._diNaConnectMap = {}
  self._HighConnectRateCutLen = 0
  self._maxlen = 0
  self._cutlen = 0
  return movePath
end

function PickUpPolicy_PetMoye:_BuildConnectMapByPieceTypeList(entity, pieceTypeList, trapPosIndexList, posStart)
  local boardCmpt = self._world:GetBoardEntity():Board()
  local posIndex = Vector2.Pos2Index(posStart)
  local blockFlag = BlockFlag.LinkLine
  local blockCanMoveMap = boardCmpt:GetBlockFlagCanMoveMap(blockFlag)
  self:_ConnectMapByPieceTypeList(posIndex, pieceTypeList, boardCmpt, blockCanMoveMap, trapPosIndexList)
  boardCmpt:ClearBlockFlagCanMoveMap(blockFlag)
end

function PickUpPolicy_PetMoye:_CanMatchPieceTypeList(type, typeList)
  if type == PieceType.None then
    return false
  end
  return table.icontains(typeList, type)
end

function PickUpPolicy_PetMoye:_Offset2Index(i, j)
  local t = {
    [1] = {
      6,
      7,
      8
    },
    [2] = {
      5,
      0,
      1
    },
    [3] = {
      4,
      3,
      2
    }
  }
  return t[i + 2][j + 2]
end

function PickUpPolicy_PetMoye:_ConnectMapByPieceTypeList(posIndex, pieceTypeList, boardCmpt, blockCanMoveMap, trapPosIndexList)
  if self._diNaConnectMap[posIndex] then
    return
  end
  local ct = {}
  self._diNaConnectMap[posIndex] = ct
  for _, offset in ipairs(Offset8) do
    local offsetVec = Vector2(offset[1], offset[2])
    local surroundIndex = posIndex + Vector2.Pos2Index(offsetVec)
    if blockCanMoveMap[surroundIndex] then
      local surroundPiece = boardCmpt:GetPieceTypeByIndex(surroundIndex)
      if CanMatchPieceTypeList(surroundPiece, pieceTypeList) or table.icontains(trapPosIndexList, surroundIndex) then
        ct[self:_Offset2Index(offsetVec.x, offsetVec.y)] = surroundIndex
        self:_ConnectMapByPieceTypeList(surroundIndex, pieceTypeList, boardCmpt, blockCanMoveMap, trapPosIndexList)
      end
    end
  end
end

function PickUpPolicy_PetMoye:_CalcAllMovePathByPieceTypeList(casterEntity, pieceTypeList, depth, trapPosIndexList, posStart)
  local pos = posStart
  local startPosIndex = Vector2.Pos2Index(pos)
  local chainPathIdx = {startPosIndex}
  self:_NextMoveByPieceTypeList(chainPathIdx, pieceTypeList, depth, trapPosIndexList)
end

function PickUpPolicy_PetMoye:_NextMoveByPieceTypeList(chainPathIdx, pieceTypeList, depth, trapPosIndexList)
  if depth == 0 then
    return
  end
  local startPosIdx = chainPathIdx[#chainPathIdx]
  local ct = self._diNaConnectMap[startPosIdx]
  if not ct or table.count(ct) == 0 then
    return
  end
  for i = 1, 8 do
    if startPosIdx ~= chainPathIdx[#chainPathIdx] then
      return
    end
    local posIdx = ct[i]
    if posIdx and not table.icontains(chainPathIdx, posIdx) then
      chainPathIdx[#chainPathIdx + 1] = posIdx
      local s = table.concat(chainPathIdx, " ")
      self._diNaMoveForward = true
      self:_NextMoveByPieceTypeList(chainPathIdx, pieceTypeList, depth - 1, trapPosIndexList)
      if self._diNaMoveForward and 1 < #chainPathIdx then
        self._diNaMoveForward = false
        local chainPath = {}
        for n = 1, #chainPathIdx do
          chainPath[#chainPath + 1] = Vector2.Index2Pos(chainPathIdx[n])
        end
        if table.icontains(self._diNaChainIndexPaths, chainPathIdx) then
          return
        end
        self._diNaChainPaths[#self._diNaChainPaths + 1] = chainPath
        self._diNaChainIndexPaths[#self._diNaChainIndexPaths + 1] = table.cloneconf(chainPathIdx)
        local s = table.concat(chainPathIdx, " ")
        self._maxlen = #chainPathIdx
        self._cutlen = self:_CalcChainPathComplexityLen(chainPathIdx)
      end
      if startPosIdx == chainPathIdx[#chainPathIdx - 1] then
        local len = #chainPathIdx
        chainPathIdx[len] = nil
        local s = table.concat(chainPathIdx, " ")
      end
      if self._maxlen - #chainPathIdx == 4 then
        for n = #chainPathIdx, self._cutlen, -1 do
          local len = #chainPathIdx
          chainPathIdx[len] = nil
          local s = table.concat(chainPathIdx, " ")
        end
      end
    end
  end
end

function PickUpPolicy_PetMoye:_FindPathNearToTarget4(targetEntity, trapPosIndexList)
  if self._diNaChainIndexPaths and table.count(self._diNaChainIndexPaths) == 0 then
    return {}
  end
  local offsetList = Offset4
  local targetPos = targetEntity:GetGridPosition()
  local posIndex = Vector2.Pos2Index(targetPos)
  local retPath = {}
  local checkTrapSuc = false
  table.sort(self._diNaChainIndexPaths, function(a, b)
    local hasTrapCountA = 0
    local hasTrapCountB = 0
    for i, chainPosIndex in ipairs(a) do
      if table.intable(trapPosIndexList, chainPosIndex) then
        hasTrapCountA = hasTrapCountA + 1
      end
    end
    for i, chainPosIndex in ipairs(b) do
      if table.intable(trapPosIndexList, chainPosIndex) then
        hasTrapCountB = hasTrapCountB + 1
      end
    end
    if 0 < hasTrapCountA or 0 < hasTrapCountB then
      checkTrapSuc = true
    end
    return hasTrapCountA > hasTrapCountB
  end)
  if checkTrapSuc == false then
    table.sort(self._diNaChainIndexPaths, function(a, b)
      local countA = table.count(a)
      local countB = table.count(b)
      return countA > countB
    end)
  end
  local selectPath = self._diNaChainIndexPaths[1]
  for i, chainPathIdx in ipairs(selectPath) do
    local pos = Vector2.Index2Pos(chainPathIdx)
    table.insert(retPath, pos)
  end
  return retPath
end

function PickUpPolicy_PetMoye:_GetPosIndexListByOffset(posIndex, offsetList)
  local posIndexList = {}
  for _, offset in ipairs(offsetList) do
    local offsetVec = Vector2(offset[1], offset[2])
    local index = posIndex + Vector2.Pos2Index(offsetVec)
    table.insert(posIndexList, index)
  end
  return posIndexList
end

function PickUpPolicy_PetMoye:_CalcHighConnectRateCutLen(casterEntity, posStart)
  local connectMap = self._diNaConnectMap
  local playerPosIndex = Vector2.Pos2Index(posStart)
  local touchIdx = {}
  local totalConnect = 0
  local totalPosNum = 0
  local search
  
  function search(posIndex)
    touchIdx[posIndex] = true
    totalPosNum = totalPosNum + 1
    local ct = connectMap[posIndex]
    for i = 1, 8 do
      local nextIdx = ct[i]
      if nextIdx then
        totalConnect = totalConnect + 1
        if not touchIdx[nextIdx] then
          search(nextIdx)
        end
      end
    end
  end
  
  search(playerPosIndex)
  local rate = totalConnect / totalPosNum
  local cutlen = 0
  local idx = BattleConst.AutoFightMoveEnhanced and 2 or 1
  if totalPosNum > BattleConst.AutoFightPathLengthCutPosNum and rate > BattleConst.AutoFightPathLengthCutConnectRate[idx] then
    cutlen = BattleConst.AutoFightPathLengthCut
  end
  Log.debug("[AutoFight] _CalcHighConnectRateCutLen() totalPosNum=", totalPosNum, " ConnectRate=", rate)
  return cutlen
end

function PickUpPolicy_PetMoye:_CalcChainPathComplexityLen(chainPathIdx)
  if self._HighConnectRateCutLen > 0 then
    return self._HighConnectRateCutLen
  end
  local m = BattleConst.AutoFightMoveEnhanced and 2 or 1
  local cc = 1
  local len = #chainPathIdx
  for i, idx in ipairs(chainPathIdx) do
    cc = cc * table.count(self._diNaConnectMap[idx])
    if cc > BattleConst.AutoFightPathComplexity[m] then
      len = i - 1
      break
    end
  end
  return len
end
