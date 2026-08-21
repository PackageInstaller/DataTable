require("ai_node_new")
_class("ActionTarget_SelectBomb", AINewNode)
ActionTarget_SelectBomb = ActionTarget_SelectBomb

function ActionTarget_SelectBomb:Constructor()
end

function ActionTarget_SelectBomb:Reset()
  ActionTarget_SelectBomb.super.Reset(self)
end

function ActionTarget_SelectBomb:OnBegin()
  local aiCmpt = self.m_entityOwn:AI()
  local entityPlayer = aiCmpt:GetTargetDefault()
  local posPlayer = entityPlayer:GetGridPosition()
  local entityBombOld = aiCmpt:GetTargetEntity()
  if entityBombOld then
    self:_UnBindBomb(entityBombOld)
  end
  local nGameRound = self:GetGameRountNow()
  local nSaveRound = self:GetRuntimeData("BombRound")
  if nil == nSaveRound or nSaveRound ~= nGameRound then
    self:_AllocBomb(nGameRound, posPlayer)
  end
  local nMobilityValid = aiCmpt:GetMobilityValid()
  if nSaveRound == nGameRound then
    local listBindMonsterID = {}
    local pFindNewBomb = self:_FindValidBomb(posPlayer, 1)
    if nil == pFindNewBomb then
      local sortFreeBomb = self:_FindBombAllFree(listBindMonsterID, nGameRound, posPlayer)
      if sortFreeBomb:Size() > 0 then
        local posSelf = self.m_entityOwn:GetGridPosition()
        for i = 1, sortFreeBomb:Size() do
          local sortData = sortFreeBomb:GetAt(i)
          local posBomb = sortData:GetPosData()
          local listBombAround = self:ComputeWalkRange(posBomb, 1, true)
          for j = 1, #listBombAround do
            local walkData = listBombAround[j]
            local posPlan = walkData:GetPos()
            if nMobilityValid >= GameHelper.ComputeLogicStep(posSelf, posPlan) and self:_IsOneLine(posPlan, posBomb, posPlayer) then
              pFindNewBomb = self._world:GetEntityByID(sortData.m_nIndex)
              break
            end
          end
        end
      end
    end
    if pFindNewBomb then
      local pOldBomb
      local entityBombOld = aiCmpt:GetTargetEntity()
      if entityBombOld ~= entityPlayer then
        pOldBomb = entityBombOld
      end
      if pOldBomb and pOldBomb:GetID() == pFindNewBomb:GetID() then
      else
        self:_UnBindBomb(pOldBomb)
        self:_UnBindBomb(pFindNewBomb)
        self:_BindBombAndMonster(nGameRound, pFindNewBomb, self.m_entityOwn)
      end
    end
  end
end

function ActionTarget_SelectBomb:OnUpdate()
  local aiCmpt = self.m_entityOwn:AI()
  local entityPlayer = aiCmpt:GetTargetDefault()
  local posPlayer = entityPlayer:GetGridPosition()
  local nGameRound = self:GetGameRountNow()
  local nSelectBomb = false
  local entityTarget = aiCmpt:GetTargetEntity()
  if entityTarget == entityPlayer then
    nSelectBomb = false
    self:PrintLog("行动目标<无需修改>, nGameRound = ", nGameRound)
  else
    nSelectBomb = true
    local posSelf = self.m_entityOwn:GetGridPosition()
    local posBomb = entityTarget:GetGridPosition()
    local nDistanceFormBomb = GameHelper.ComputeLogicDistance(posSelf, posBomb)
    local nDistanceFormPlay = GameHelper.ComputeLogicDistance(posSelf, posPlayer)
    if nDistanceFormBomb > nDistanceFormPlay then
      aiCmpt:SetRuntimeData("Target", nil)
      nSelectBomb = false
      self:PrintLog("行动目标<修改失败>, nGameRound = ", nGameRound, ", BombID = ", entityTarget:GetID())
    else
      self:PrintLog("行动目标<修改成功>, nGameRound = ", nGameRound, ", BombID = ", entityTarget:GetID())
    end
  end
  if nSelectBomb then
    return AINewNodeStatus.Success
  end
  return AINewNodeStatus.Failure
end

function ActionTarget_SelectBomb:OnEnd()
end

function ActionTarget_SelectBomb:_FindBombAllFree(listBindMonsterID, nRoundData, posPlayer)
  local utilSvc = self._world:GetService("TrapLogic")
  local listBomb = utilSvc:FindTrapByType(TrapType.BombByHitBack)
  local sortFreeBomb = SortedArray:New(Algorithm.COMPARE_CUSTOM, AiSortByDistance._ComparerByNear)
  for i = 1, #listBomb do
    local entityBomb = listBomb[i]
    local trapCmpt = listBomb[i]:Trap()
    local bFindFree = true
    if trapCmpt:IsTrapHaveOwner(nRoundData) then
      local nOwnerEntity = self._world:GetEntityByID(trapCmpt:GetOwnerID())
      if nOwnerEntity and not AINewNode.IsEntityDead(nOwnerEntity) then
        bFindFree = false
      end
    end
    if not bFindFree then
      table.insert(listBindMonsterID, trapCmpt:GetOwnerID())
    else
      local posBomb = entityBomb:GetGridPosition()
      sortFreeBomb:Insert(AiSortByDistance:New(posPlayer, posBomb, entityBomb:GetID()))
    end
  end
  return sortFreeBomb
end

function ActionTarget_SelectBomb:_UnBindBomb(entityBomb)
  if nil == entityBomb then
    return
  end
  local cmptTrap = entityBomb:Trap()
  if nil == cmptTrap then
    return
  end
  local nMonsterID = cmptTrap:GetOwnerID()
  if nMonsterID and 0 < nMonsterID then
    local entityMonster = self._world:GetEntityByID(nMonsterID)
    if entityMonster then
      local aiCmpt = entityMonster:AI()
      if aiCmpt then
        aiCmpt:SetRuntimeData("Target", nil)
      end
    end
  end
  cmptTrap:SetOwner(nil, -1)
end

function ActionTarget_SelectBomb:_BindBombAndMonster(nRoundData, entityBomb, entityMonster)
  local trapCmpt = entityBomb:Trap()
  trapCmpt:SetOwner(entityMonster:GetID(), nRoundData)
  local aiCmpt = entityMonster:AI()
  if aiCmpt then
    local nBombEntityID = entityBomb:GetID()
    aiCmpt:SetRuntimeData("Target", nBombEntityID)
    aiCmpt:SetRuntimeData("BombRound", nRoundData)
  end
  return entityMonster:GetID()
end

function ActionTarget_SelectBomb:_AllocBomb(nRoundData, posPlayer)
  local listBindMonsterID = {}
  local sortFreeBomb = self:_FindBombAllFree(listBindMonsterID, nRoundData, posPlayer)
  local sortArrayByBomb, sortArrayByMonster = self:_ComputeDistance_BombToMonster(sortFreeBomb)
  for i = 1, sortFreeBomb:Size() do
    local sortBombData = sortFreeBomb:GetAt(i)
    local entityBomb = self._world:GetEntityByID(sortBombData.m_nIndex)
    local entityBindMonster = self:_FindBindMonsterByBomb(sortArrayByBomb, sortArrayByMonster, listBindMonsterID, sortBombData, posPlayer)
    if entityBindMonster then
      self:_BindBombAndMonster(nRoundData, entityBomb, entityBindMonster)
      table.insert(listBindMonsterID, entityBindMonster:GetID())
    end
  end
  return sortFreeBomb
end

function ActionTarget_SelectBomb:_FindSortArray(sortArrayList, nKeyID)
  local sortArray = sortArrayList[nKeyID]
  if nil == sortArray then
    sortArray = SortedArray:New(Algorithm.COMPARE_CUSTOM, AiSortByDistance._ComparerByNear)
    sortArrayList[nKeyID] = sortArray
  end
  return sortArray
end

function ActionTarget_SelectBomb:_ComputeDistance_BombToMonster(listFreeBomb)
  local listDistanceByBomb = {}
  local listDistanceByMonster = {}
  local listMonster = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID):GetEntities()
  for j = 1, #listMonster do
    local entityMonster = listMonster[j]
    local nMonsterType = entityMonster:MonsterID():GetMonsterType()
    if MonsterType.HitFly == nMonsterType then
      local posMonster = entityMonster:GetGridPosition()
      local nMonsterID = entityMonster:GetID()
      local sortByMonster = self:_FindSortArray(listDistanceByMonster, nMonsterID)
      for i = 1, listFreeBomb:Size() do
        local sortData = listFreeBomb:GetAt(i)
        local posBomb = sortData:GetPosData()
        local nBombID = sortData.m_nIndex
        local sortByBomb = self:_FindSortArray(listDistanceByBomb, nBombID)
        sortByBomb:Insert(AiSortByDistance:New(posBomb, posMonster, nMonsterID))
        sortByMonster:Insert(AiSortByDistance:New(posMonster, posBomb, nBombID))
      end
    end
  end
  return listDistanceByBomb, listDistanceByMonster
end

function ActionTarget_SelectBomb:_FindBindMonsterByBomb(listDistanceByBomb, listDistanceByMonster, listBindID, sortBombData, posPlayer)
  local posBomb = sortBombData:GetPosData()
  local nBombEntityID = sortBombData.m_nIndex
  local sortDistanceByMonsterID = self:_FindSortArray(listDistanceByBomb, nBombEntityID)
  if nil == sortDistanceByMonsterID then
    return nil
  end
  local listFindMonsterID = {}
  for i = 1, sortDistanceByMonsterID:Size() do
    local sortData_Monster = sortDistanceByMonsterID:GetAt(i)
    local nMonsterID = sortData_Monster.m_nIndex
    if not table.icontains(listBindID, nMonsterID) then
      local nDistance = sortData_Monster:GetDistance()
      local nFindBombID = self:_FindNearBombByMonster(listDistanceByMonster, nMonsterID, nDistance, posPlayer)
      if nil == nFindBombID or nFindBombID == nBombEntityID then
        table.insert(listFindMonsterID, nMonsterID)
        break
      end
    end
  end
  local entityFind
  local nFindCount = table.count(listFindMonsterID)
  for i = 1, nFindCount do
    local entityWork = self._world:GetEntityByID(listFindMonsterID[i])
    local posMonster = entityWork:GetGridPosition()
    if self:_IsOneLine(posMonster, posBomb, posPlayer) then
      entityFind = entityWork
      break
    end
  end
  if nil == entityFind and 0 < nFindCount then
    entityFind = self._world:GetEntityByID(listFindMonsterID[1])
  end
  return entityFind
end

function ActionTarget_SelectBomb:_FindNearBombByMonster(listDistanceByMonster, nMonsterID, nDistance, posPlayer)
  local nFindBombID
  local sortDistanceByBombID = self:_FindSortArray(listDistanceByMonster, nMonsterID)
  for j = 1, sortDistanceByBombID:Size() do
    local sortData_Bomb = sortDistanceByBombID:GetAt(j)
    local nDistanceTemp = sortData_Bomb:GetDistance()
    if nDistance > nDistanceTemp then
      nFindBombID = sortData_Bomb.m_nIndex
      break
    elseif nDistanceTemp == nDistance and self:_IsHaveValidWalkPos(nMonsterID, sortData_Bomb.m_nIndex, posPlayer) then
      nFindBombID = sortData_Bomb.m_nIndex
    end
  end
  return nFindBombID
end

function ActionTarget_SelectBomb:_IsHaveValidWalkPos(nMonsterID, nBombID, posPlayer)
  local entityMonster = self._world:GetEntityByID(nMonsterID)
  local aiCmpt = entityMonster:AI()
  local posMonster = entityMonster:GetGridPosition()
  local posBomb = self._world:GetEntityByID(nBombID):GetGridPosition()
  local listBombAround = ComputeScopeRange.ComputeRange_CrossScope(posBomb, 1, 1)
  local nWalkStep = aiCmpt:GetMobilityValid()
  for i = 1, #listBombAround do
    local posWork = listBombAround[i]
    local nStep = GameHelper.ComputeLogicStep(posMonster, posWork)
    if nWalkStep >= nStep and self:_IsOneLine(posWork, posBomb, posPlayer) then
      return nBombID
    end
  end
  return nil
end

function ActionTarget_SelectBomb:_FindValidBomb(posPlayer, nStep)
  local entitySelf = self.m_entityOwn
  local cmptAI = entitySelf:AI()
  local posSelf = entitySelf:GetGridPosition()
  local selfBodyArea = entitySelf:BodyArea():GetArea()
  local listWalkRange = ComputeScopeRange.ComputeRange_WalkMathPos(posSelf, #selfBodyArea, nStep, nil)
  local utilDataSvc = self._world:GetService("UtilData")
  for i = 1, #listWalkRange do
    local posWork = listWalkRange[i]:GetPos()
    local listBomb = utilDataSvc:FindEntityByPosAndType(posWork, EnumTargetEntity.Trap, TrapType.BombByHitBack)
    if table.count(listBomb) > 0 then
      for k = 1, #listBomb do
        local entityBombID = listBomb[k]
        if self:_IsOneLine(posSelf, posWork, posPlayer) then
          local entity = self._world:GetEntityByID(entityBombID)
          if not entity:HasDeadMark() then
            return entity
          end
        end
      end
    end
  end
  return nil
end

_class("BombSortByDistance", AiSortByDistance)
BombSortByDistance = BombSortByDistance

function BombSortByDistance:Constructor(centrePos, dataPos, nIndex, posPlayer, entityBind)
  self.m_posPlayer = posPlayer
  self.m_entityBind = entityBind
  self.m_nDisPlayer = self:Distance(self.centre, self.m_posPlayer)
end

function BombSortByDistance:GetEntityBind()
  return self.m_entityBind
end

function BombSortByDistance._ComparerByBomb(dataNew, dataOld)
  local nDistanceA = dataNew:GetDistance()
  local nDistanceB = dataOld:GetDistance()
  if nDistanceA > nDistanceB then
    return -1
  elseif nDistanceA < nDistanceB then
    return 1
  else
    local nDis = dataNew.m_nDisPlayer - dataOld.m_nDisPlayer
    if 0 == nDis then
      return dataOld.m_nIndex - dataNew.m_nIndex
    else
      return nDis
    end
  end
end
