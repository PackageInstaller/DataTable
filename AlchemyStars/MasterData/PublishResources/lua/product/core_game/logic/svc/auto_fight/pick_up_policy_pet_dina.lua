require("pick_up_policy_base")
_class("PickUpPolicy_PetDiNa", PickUpPolicy_Base)
PickUpPolicy_PetDiNa = PickUpPolicy_PetDiNa

function PickUpPolicy_PetDiNa:CalcAutoFightPickUpPolicy(calcParam)
  local petEntity = calcParam.petEntity
  local petPos = petEntity:GetGridPosition():Clone()
  local activeSkillID = calcParam.activeSkillID
  local posList = {}
  local attackPosList = {}
  local targetIDList = {}
  local configSvc = self._world:GetService("Config")
  local skillCfgData = configSvc:GetSkillConfigData(activeSkillID)
  local pickUpParam = skillCfgData:GetSkillPickParam()
  local depth = pickUpParam[1] or 0
  local pieceType = pickUpParam[2] or PieceType.Blue
  local canLinkMonster = (pickUpParam[3] or 0) == 1
  if depth == 0 then
    return posList, attackPosList, targetIDList
  end
  local pieceTypeList = {
    PieceType.Blue,
    PieceType.Red,
    PieceType.Green,
    PieceType.Yellow
  }
  table.removev(pieceTypeList, pieceType)
  local targetEntity
  if self._world:MatchType() == MatchType.MT_BlackFist then
    if petEntity:HasPet() then
      targetEntity = petEntity:Pet():GetOwnerTeamEntity():Team():GetEnemyTeamEntity()
    end
  else
    local utilScope = self._world:GetService("UtilScopeCalc")
    local monsterList, monsterPosList = utilScope:SelectNearestMonsterOnPos(petPos, 1)
    if monsterList and 0 < #monsterList then
      targetEntity = monsterList[1]
    end
  end
  if not targetEntity then
    return posList, attackPosList, targetIDList
  end
  table.insert(targetIDList, targetEntity:GetID())
  posList = self:FindPath_MonsterMoveGridByParam(petEntity, targetEntity, pieceTypeList, depth, canLinkMonster)
  attackPosList = posList
  return posList, attackPosList, targetIDList
end

function PickUpPolicy_PetDiNa:FindPath_MonsterMoveGridByParam(casterEntity, targetEntity, pieceTypeList, depth, canLinkMonster)
  local movePath = {}
  self._diNaChainPaths = {}
  self._diNaChainIndexPaths = {}
  self._diNaMoveForward = false
  self._diNaConnectMap = {}
  self._HighConnectRateCutLen = 0
  self._maxlen = 0
  self._cutlen = 0
  self:_BuildConnectMapByPieceTypeList(casterEntity, pieceTypeList)
  self._HighConnectRateCutLen = self:_CalcHighConnectRateCutLen(casterEntity)
  self:_CalcAllMovePathByPieceTypeList(casterEntity, pieceTypeList, depth)
  movePath = self:_FindPathNearToTarget4(targetEntity)
  if #movePath < 1 then
    local pos = casterEntity:GetGridPosition()
    movePath = {pos}
  end
  local targetPos = targetEntity:GetGridPosition()
  local utilDataSvc = self._world:GetService("UtilData")
  local tpPieceType = utilDataSvc:GetPieceType(targetPos)
  if canLinkMonster and tpPieceType ~= PieceType.None then
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

function PickUpPolicy_PetDiNa:_BuildConnectMapByPieceTypeList(entity, pieceTypeList)
  local boardCmpt = self._world:GetBoardEntity():Board()
  local pos = entity:GetGridPosition()
  local posIndex = Vector2.Pos2Index(pos)
  local blockFlag = BlockFlag.LinkLine
  local blockCanMoveMap = boardCmpt:GetBlockFlagCanMoveMap(blockFlag)
  self:_ConnectMapByPieceTypeList(posIndex, pieceTypeList, boardCmpt, blockCanMoveMap)
  boardCmpt:ClearBlockFlagCanMoveMap(blockFlag)
end

function PickUpPolicy_PetDiNa:_CanMatchPieceTypeList(type, typeList)
  if type == PieceType.None then
    return false
  end
  return table.icontains(typeList, type)
end

function PickUpPolicy_PetDiNa:_Offset2Index(i, j)
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

function PickUpPolicy_PetDiNa:_ConnectMapByPieceTypeList(posIndex, pieceTypeList, boardCmpt, blockCanMoveMap)
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
      if CanMatchPieceTypeList(surroundPiece, pieceTypeList) then
        ct[self:_Offset2Index(offsetVec.x, offsetVec.y)] = surroundIndex
        self:_ConnectMapByPieceTypeList(surroundIndex, pieceTypeList, boardCmpt, blockCanMoveMap)
      end
    end
  end
end

function PickUpPolicy_PetDiNa:_CalcAllMovePathByPieceTypeList(casterEntity, pieceTypeList, depth)
  local pos = casterEntity:GetGridPosition()
  local startPosIndex = Vector2.Pos2Index(pos)
  local chainPathIdx = {startPosIndex}
  self:_NextMoveByPieceTypeList(chainPathIdx, pieceTypeList, depth)
end

function PickUpPolicy_PetDiNa:_NextMoveByPieceTypeList(chainPathIdx, pieceTypeList, depth)
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
      self:_NextMoveByPieceTypeList(chainPathIdx, pieceTypeList, depth - 1)
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

function PickUpPolicy_PetDiNa:_FindPathNearToTarget4(targetEntity)
  local offsetList = Offset4
  local targetPos = targetEntity:GetGridPosition()
  local posIndex = Vector2.Pos2Index(targetPos)
  local highValuePosIdxList = self:_GetPosIndexListByOffset(posIndex, offsetList)
  local retPath = {}
  local unionCount = 0
  local retIndex = 0
  for i, chainPathIdx in ipairs(self._diNaChainIndexPaths) do
    local targetInPath = table.union(chainPathIdx, highValuePosIdxList)
    if unionCount < #targetInPath then
      unionCount = #targetInPath
      retIndex = i
      if unionCount == #highValuePosIdxList then
        break
      end
    end
  end
  local disMin = MAX_INT_32
  local chainPathIndex = 0
  if 0 < retIndex then
    chainPathIndex = retIndex
  else
    for i, chainPath in ipairs(self._diNaChainPaths) do
      local chainPos = chainPath[#chainPath]
      local dis = Vector2.Distance(chainPos, targetPos)
      if disMin > dis then
        disMin = dis
        chainPathIndex = i
      end
    end
  end
  if 0 < chainPathIndex then
    retPath = self._diNaChainPaths[chainPathIndex]
  end
  return retPath
end

function PickUpPolicy_PetDiNa:_GetPosIndexListByOffset(posIndex, offsetList)
  local posIndexList = {}
  for _, offset in ipairs(offsetList) do
    local offsetVec = Vector2(offset[1], offset[2])
    local index = posIndex + Vector2.Pos2Index(offsetVec)
    table.insert(posIndexList, index)
  end
  return posIndexList
end

function PickUpPolicy_PetDiNa:_CalcHighConnectRateCutLen(casterEntity)
  local connectMap = self._diNaConnectMap
  local playerPos = casterEntity:GetGridPosition()
  local playerPosIndex = Vector2.Pos2Index(playerPos)
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

function PickUpPolicy_PetDiNa:_CalcChainPathComplexityLen(chainPathIdx)
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
