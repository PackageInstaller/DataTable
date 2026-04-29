_class("NormalSkillCalculator", Object)
NormalSkillCalculator = NormalSkillCalculator

function NormalSkillCalculator:Constructor(world)
  self._world = world
  self._configService = self._world:GetService("Config")
  self._skillLogicService = self._world:GetService("SkillLogic")
  self._skillEffectCalcService = self._world:GetService("SkillEffectCalc")
  self._trapServiceLogic = self._world:GetService("TrapLogic")
  self._battleService = self._world:GetService("Battle")
  self._triggerService = self._world:GetService("Trigger")
  self._skillScopeTargetSelector = self._world:GetSkillScopeTargetSelector()
  self._frameTimeMultipleDic = {}
  self._deadChainIndx = 10000
  self._playNormalSkillSequence = {}
  self._pathTriggerTrapsDic = {}
  self._pathNormalSkillWaitTimeDic = {}
  self._pathMoveStartWaitTime = 0
end

function NormalSkillCalculator:DoCalculateNormalSkill(teamEntity)
  self:_OnInitializeData(teamEntity)
  self:_NotifyNormalAttackStart()
  self:_OnGetTimeAttackListDic(teamEntity)
  self:_OnCalcAndApply(teamEntity)
  self:_OnCheckTriggerTrapAfterAttackAll(teamEntity)
  local pos = teamEntity:GridLocation():GetMoveLastPosition()
  teamEntity:SetGridPosition(pos)
  self:_NotifyNormalAttackEnd()
  self:_SetNormalAttackDead()
end

function NormalSkillCalculator:_OnInitializeData(teamEntity)
  local logicChainPathCmpt = teamEntity:LogicChainPath()
  self._chainPathData = logicChainPathCmpt:GetLogicChainPath()
  self._chainPathElementType = logicChainPathCmpt:GetLogicPieceType()
  local LogicRoundTeam = teamEntity:LogicRoundTeam()
  self._petRoundTeam = LogicRoundTeam:GetPetRoundTeam()
  self._timeTrapDic = SortedDictionary:New()
  self._triggerService:Notify(NTTeamNormalAttackStart:New(self._chainPathElementType, self._chainPathData))
  self._indexTrapDic = self:_GetIndexTrapDic(teamEntity)
  local pathSuperGridCount = self:_GetPathSuperGridCount()
  pathSuperGridCount = self:_ModifyPathSuperGridCount(pathSuperGridCount, teamEntity)
  logicChainPathCmpt:SetPathSuperGridCount(pathSuperGridCount)
  local pathPoorGridCount = self:_GetPathPoorGridCount()
  logicChainPathCmpt:SetPathPoorGridCount(pathPoorGridCount)
  self._triggerTrapIndex = 1
  self._timeAttackListDic = SortedDictionary:New()
  self._frameTimeMultipleDic = {}
  self._stopChainIndex = nil
  self._stopPos = nil
end

function NormalSkillCalculator:_NotifyNormalAttackStart()
  for petIndex = 1, #self._petRoundTeam do
    local petEntityID = self._petRoundTeam[petIndex]
    local petEntity = self._world:GetEntityByID(petEntityID)
    self._triggerService:Notify(NTNormalAttackStart:New(petEntity, self._chainPathElementType, self._chainPathData))
  end
end

function NormalSkillCalculator:_NotifyNormalAttackEnd()
  for petIndex = 1, #self._petRoundTeam do
    local petEntityID = self._petRoundTeam[petIndex]
    local petEntity = self._world:GetEntityByID(petEntityID)
    self._triggerService:Notify(NTNormalAttackEnd:New(petEntity))
  end
end

function NormalSkillCalculator:_GetOneGridMoveTime(pathPosition, chainIndex)
  local oneGridMoveTime = 0
  if self:_IsPosInCrossLine(pathPosition, self._chainPathData[chainIndex - 1]) then
    oneGridMoveTime = self:_MakeTimeFrameTimeMultiple(BattleConst.OneGridMoveTime)
  else
    oneGridMoveTime = self:_MakeTimeFrameTimeMultiple(BattleConst.OneGridObliqueMoveTime)
  end
  return oneGridMoveTime
end

function NormalSkillCalculator:_OnGetTimeAttackListDic(teamEntity)
  local currentTime = 0
  local petGridTimeDic = {}
  local petsAttactList = self:_OnGetPathAttackList(teamEntity, self._chainPathData)
  self._pathMoveStartWaitTime = self:_OnGetPathMoveStartWaitTime(petsAttactList)
  for petIndex = 1, #self._petRoundTeam do
    local petEntityID = self._petRoundTeam[petIndex]
    local petEntity = self._world:GetEntityByID(petEntityID)
    local petAttackDataCmpt = petEntity:SkillPetAttackData()
    local normalAttackData = petAttackDataCmpt:GetNormalAttackData()
    petGridTimeDic[petIndex] = {}
    for chainIndex, pathPosition in ipairs(self._chainPathData) do
      petGridTimeDic[petIndex][chainIndex] = {}
      currentTime = self:_OnCalcAttackFinishTimeBeforeMove(currentTime, petIndex, chainIndex, pathPosition)
      currentTime, petGridTimeDic = self:_OnCalcMoveFinishTime(currentTime, petIndex, chainIndex, pathPosition, petGridTimeDic)
      local pathPointAttackData = normalAttackData:GetPathPointAttackData(pathPosition)
      if pathPointAttackData ~= nil then
        currentTime = self:_OnCalcAttackFinishTime(currentTime, petIndex, chainIndex, pathPosition)
      end
      petGridTimeDic[petIndex][chainIndex][2] = currentTime + BattleConst.FrameTime
      if chainIndex <= #self._chainPathData and chainIndex == 2 and petIndex == #self._petRoundTeam then
        self._world:GetService("Trigger"):Notify(NTPlayerFirstMoveEnd:New(petEntity, self._chainPathData[1]))
      end
    end
  end
end

function NormalSkillCalculator:_OnCalcMoveFinishTime(currentTime, petIndex, chainIndex, pathPosition, petGridTimeDic)
  local petEntityID = self._petRoundTeam[petIndex]
  local petEntity = self._world:GetEntityByID(petEntityID)
  local utilCalcSvc = self._world:GetService("UtilCalc")
  local prePetAttackTime = 0
  if 1 < petIndex then
    prePetAttackTime = self:_GetNormalAttackTime(petIndex - 1, pathPosition)
  end
  local curPetAttackTime = self:_GetNormalAttackTime(petIndex, pathPosition)
  local waitAttactTime = prePetAttackTime - curPetAttackTime
  if waitAttactTime < 0 then
    waitAttactTime = 0
  end
  if not self._pathNormalSkillWaitTimeDic[petIndex] then
    self._pathNormalSkillWaitTimeDic[petIndex] = {}
  end
  self._pathNormalSkillWaitTimeDic[petIndex][chainIndex] = waitAttactTime
  if petIndex == 1 and chainIndex == 1 then
    petGridTimeDic[petIndex][chainIndex][1] = 0
    currentTime = 0
  elseif petIndex == 1 then
    local oneGridMoveTime = self:_GetOneGridMoveTime(pathPosition, chainIndex)
    local t = currentTime + BattleConst.FrameTime + oneGridMoveTime
    petGridTimeDic[petIndex][chainIndex][1] = t
    currentTime = petGridTimeDic[petIndex][chainIndex][1]
    local attackList = {}
    if self._timeAttackListDic:ContainsKey(t) then
      attackList = self._timeAttackListDic:Find(t)
    else
      self._timeAttackListDic:Insert(t, attackList)
    end
    table.insert(attackList, ChainMoveData:New(petEntityID, pathPosition, chainIndex))
    if self._indexTrapDic[chainIndex] then
      self._timeTrapDic:Insert(currentTime, chainIndex)
      local trapDelay = self:_GetTrapDelay(self._indexTrapDic[chainIndex])
      currentTime = petGridTimeDic[petIndex][chainIndex][1] + self:_MakeTimeFrameTimeMultiple(trapDelay)
    end
  elseif chainIndex == 1 then
    petGridTimeDic[petIndex][chainIndex][1] = petGridTimeDic[petIndex - 1][chainIndex][1] + self:_MakeTimeFrameTimeMultiple(self._pathMoveStartWaitTime) + waitAttactTime
    currentTime = petGridTimeDic[petIndex][chainIndex][1]
    local attackList = {}
    if self._timeAttackListDic:ContainsKey(currentTime) then
      attackList = self._timeAttackListDic:Find(currentTime)
    else
      self._timeAttackListDic:Insert(currentTime, attackList)
    end
    table.insert(attackList, ChainMoveData:New(petEntityID, pathPosition, chainIndex))
  else
    local oneGridMoveTime = self:_GetOneGridMoveTime(pathPosition, chainIndex)
    local prePetFinishActionTime = petGridTimeDic[petIndex - 1][chainIndex][2]
    if chainIndex ~= #self._chainPathData and currentTime <= prePetFinishActionTime then
      local nextChainIndex = chainIndex + 1
      local nextPathPosition = self._chainPathData[nextChainIndex]
      local prePetLeaveMoveTime = 0
      currentTime = prePetFinishActionTime + prePetLeaveMoveTime + BattleConst.FrameTime
    end
    petGridTimeDic[petIndex][chainIndex][1] = currentTime + oneGridMoveTime + waitAttactTime
    currentTime = petGridTimeDic[petIndex][chainIndex][1]
    local attackList = {}
    if self._timeAttackListDic:ContainsKey(currentTime) then
      attackList = self._timeAttackListDic:Find(currentTime)
    else
      self._timeAttackListDic:Insert(currentTime, attackList)
    end
    table.insert(attackList, ChainMoveData:New(petEntityID, pathPosition, chainIndex))
  end
  return currentTime, petGridTimeDic
end

function NormalSkillCalculator:_OnCalcAttackFinishTime(currentTime, petIndex, chainIndex, pathPosition)
  local petEntityID = self._petRoundTeam[petIndex]
  local petEntity = self._world:GetEntityByID(petEntityID)
  local buffComp = petEntity:BuffComponent()
  local forbidPetNormalSkill = buffComp:GetBuffValue("ForbidPetNormalSkill")
  if forbidPetNormalSkill then
    return currentTime
  end
  local normalSkillBeforeMove = buffComp:GetBuffValue("NormalSkillBeforeMove")
  if normalSkillBeforeMove then
    return currentTime
  end
  local petAttackDataCmpt = petEntity:SkillPetAttackData()
  local normalAttackData = petAttackDataCmpt:GetNormalAttackData()
  local pathPointAttackData = normalAttackData:GetPathPointAttackData(pathPosition)
  local attackGridDic = pathPointAttackData:GetAttackGridDic()
  local attackGridDicAdditional = pathPointAttackData:GetAttackGridDicAdditional()
  local orderGridArray = pathPointAttackData:GetPetOrderGridArray(petEntity, pathPosition)
  local gridCount = #orderGridArray
  if petEntity:BuffComponent():GetBuffValue("ForcePetNormalAttackAfterMove") then
    if chainIndex ~= 1 then
      orderGridArray = {pathPosition}
      gridCount = 1
    else
      orderGridArray = {}
      gridCount = 0
    end
  end
  local hasCalcPosList = {}
  for i, beAttackPos in ipairs(orderGridArray) do
    local attackGridData = self:_FindAttackGridData(attackGridDic, beAttackPos)
    local attackGridDataAdditional = self:_FindAttackGridData(attackGridDicAdditional, beAttackPos)
    local isLastAttackPos = i == gridCount
    if attackGridData then
      local normalAttackDataParam = {
        chainIndex = chainIndex,
        pathPosition = pathPosition,
        beAttackPos = beAttackPos,
        isLastAttackPos = isLastAttackPos
      }
      if attackGridDataAdditional then
        if not table.icontains(hasCalcPosList, beAttackPos) then
          currentTime = self:_OnAddNormalAttackDataForTimeDic(currentTime, attackGridData, normalAttackDataParam, 1)
          table.insert(hasCalcPosList, beAttackPos)
        else
          currentTime = self:_OnAddNormalAttackDataForTimeDic(currentTime, attackGridDataAdditional, normalAttackDataParam, 2)
        end
      else
        currentTime = self:_OnAddNormalAttackDataForTimeDic(currentTime, attackGridData, normalAttackDataParam)
      end
    end
  end
  return currentTime
end

function NormalSkillCalculator:_OnAddNormalAttackDataForTimeDic(currentTime, attackGridData, normalAttackDataParam, normalAttackIndex)
  local chainIndex = normalAttackDataParam.chainIndex
  local pathPosition = normalAttackDataParam.pathPosition
  local beAttackPos = normalAttackDataParam.beAttackPos
  local isLastAttackPos = normalAttackDataParam.isLastAttackPos
  local petEntityID = attackGridData:GetPetEntityID()
  local petEntity = self._world:GetEntityByID(petEntityID)
  local normalSkillID = attackGridData:GetAttackGridSkillId()
  currentTime = currentTime + BattleConst.FrameTime
  local normalAttackData = NormalAttackData:New(attackGridData, petEntityID, normalSkillID, beAttackPos, chainIndex, pathPosition, isLastAttackPos)
  if normalAttackIndex then
    normalAttackData:SetNormalAttackIndex(normalAttackIndex)
  end
  local hitTime, length = self:_GetNormalAttackHitTimeAndLength(normalSkillID, isLastAttackPos, petEntity)
  local attackTime = currentTime + self:_MakeTimeFrameTimeMultiple(hitTime)
  currentTime = currentTime + self:_MakeTimeFrameTimeMultiple(length)
  self._world:GetSyncLogger():Trace({
    key = "NormalAttackGridDataTime",
    entityID = petEntityID,
    attackTime = attackTime,
    chainIndex = chainIndex,
    beAttackPos = tostring(beAttackPos),
    attackPos = tostring(pathPosition)
  })
  local attackList = {}
  if self._timeAttackListDic:ContainsKey(attackTime) then
    attackList = self._timeAttackListDic:Find(attackTime)
  else
    self._timeAttackListDic:Insert(attackTime, attackList)
  end
  attackList[#attackList + 1] = normalAttackData
  return currentTime
end

function NormalSkillCalculator:_OnCalcAttackFinishTimeBeforeMove(currentTime, petIndex, chainIndex, pathPosition)
  local petEntityID = self._petRoundTeam[petIndex]
  local petEntity = self._world:GetEntityByID(petEntityID)
  local buffComp = petEntity:BuffComponent()
  local normalSkillBeforeMove = buffComp:GetBuffValue("NormalSkillBeforeMove")
  if not normalSkillBeforeMove then
    return currentTime
  end
  local petAttackDataCmpt = petEntity:SkillPetAttackData()
  local normalAttackData = petAttackDataCmpt:GetNormalAttackData()
  local pathPointAttackData = normalAttackData:GetPathPointAttackData(pathPosition)
  if not pathPointAttackData then
    return currentTime
  end
  local attackGridDic = pathPointAttackData:GetAttackGridDic()
  local orderGridArray = pathPointAttackData:GetPetOrderGridArray(petEntity, pathPosition)
  local gridCount = #orderGridArray
  if petEntity:BuffComponent():GetBuffValue("ForcePetNormalAttackAfterMove") then
    if chainIndex ~= 1 then
      orderGridArray = {pathPosition}
      gridCount = 1
    else
      orderGridArray = {}
      gridCount = 0
    end
  end
  for i, beAttackPos in ipairs(orderGridArray) do
    local attackGridData = self:_FindAttackGridData(attackGridDic, beAttackPos)
    local isLastAttackPos = i == gridCount
    if attackGridData then
      local normalSkillID = attackGridData:GetAttackGridSkillId()
      local normalAttackData = NormalAttackData:New(attackGridData, petEntityID, normalSkillID, beAttackPos, chainIndex, pathPosition, isLastAttackPos)
      local hitTime, length = self:_GetNormalAttackHitTimeAndLength(normalSkillID, isLastAttackPos, petEntity)
      local attackTime = currentTime + self:_MakeTimeFrameTimeMultiple(hitTime)
      self._world:GetSyncLogger():Trace({
        key = "NormalAttackGridDataTime",
        entityID = petEntityID,
        attackTime = attackTime,
        chainIndex = chainIndex,
        beAttackPos = tostring(beAttackPos),
        attackPos = tostring(pathPosition)
      })
      local attackList = {}
      if self._timeAttackListDic:ContainsKey(attackTime) then
        attackList = self._timeAttackListDic:Find(attackTime)
      else
        self._timeAttackListDic:Insert(attackTime, attackList)
      end
      attackList[#attackList + 1] = normalAttackData
    end
  end
  return currentTime
end

function NormalSkillCalculator:_OnCalcAndApply(teamEntity)
  self._playNormalSkillSequence = {}
  self._pathTriggerTrapsDic = {}
  local normalSkillIndex = 1
  local trapServiceLogic = self._world:GetService("TrapLogic")
  local triggerSvc = self._world:GetService("Trigger")
  local boardService = self._world:GetService("BoardLogic")
  local utilData = self._world:GetService("UtilData")
  local board = self._world:GetBoardEntity():Board()
  local battleStatCmpt = self._world:BattleStat()
  local teamEntityLeader = teamEntity:GetTeamLeaderPetEntity()
  local logicChainPathCmpt = teamEntity:LogicChainPath()
  local chainPath = logicChainPathCmpt:GetLogicChainPath()
  for petIndex = 1, #self._petRoundTeam do
    local petEntityID = self._petRoundTeam[petIndex]
    local petEntity = self._world:GetEntityByID(petEntityID)
    local ntPetChainMoveBegin = NTPetChainMoveBegin:New(petEntity, chainPath[1], 0, nil, 1)
    triggerSvc:Notify(ntPetChainMoveBegin)
  end
  for i = 1, self._timeAttackListDic:Size() do
    self:_OnCheckTriggerTrapBeforeAttack(teamEntity, i)
    local attackList = self._timeAttackListDic:GetAt(i)
    for k = 1, #attackList do
      local data = attackList[k]
      if data._className == "NormalAttackData" then
        local normalAttackData = attackList[k]
        local attackGridData = normalAttackData:GetAttackGridData()
        local petEntityID = normalAttackData:GetPetEntityID()
        local casterEntity = self._world:GetEntityByID(petEntityID)
        local originaBeAttackPos = normalAttackData:GetBeAttackPos()
        local originalSkillID = attackGridData:GetAttackGridSkillId()
        local originalAttackPosList = attackGridData:GetAttackPosList()
        local originalTargetIdList = attackGridData:GetTargetIdList()
        local newAttackSkillId = originalSkillID
        local directReplace = 0
        local attackPos = normalAttackData:GetPathPosition()
        self._world:GetService("Trigger"):Notify(NTNormalAttackChangeBefore:New(casterEntity, attackPos, originaBeAttackPos))
        attackGridData, newAttackSkillId, directReplace = self:_CalcNormalSkillExtraScope(normalAttackData)
        if self:CanAttackByPos(attackPos) then
          self:_CalcNormalSkillEffect(teamEntity, normalAttackData, attackGridData, originalSkillID, originaBeAttackPos, directReplace, false)
          self:_SaveAttackGridData(normalAttackData, attackGridData)
          self:_OnSavePlayNormalSkillSequence(casterEntity, normalSkillIndex, originalSkillID, newAttackSkillId, normalAttackData, originaBeAttackPos, attackGridData)
          if self:_OnCheckNormalAttackDouble(casterEntity, normalAttackData) then
            self:_ForNormalAttackDouble(teamEntity, casterEntity, normalAttackData, originalAttackPosList, originalTargetIdList, originaBeAttackPos, originalSkillID)
          end
        end
        self._world:GetService("Trigger"):Notify(NTNormalAttackChangeAfter:New(casterEntity, attackPos, originaBeAttackPos))
      elseif data._className == "ChainMoveData" then
        local chainMoveData = data
        local v2Pos = chainMoveData:GetPos()
        if self:CanMoveToPos(v2Pos) then
          local petEntityID = chainMoveData:GetPetEntityID()
          local petEntity = self._world:GetEntityByID(petEntityID)
          local pieceType = utilData:FindPieceElement(v2Pos)
          local chainIndex = chainMoveData:GetChainIndex()
          local ntPlayerEachMoveStart = NTPlayerEachMoveStart:New(petEntity, v2Pos, pieceType, chainIndex, self._world:BattleStat():IsActiveSkillLinkLine())
          triggerSvc:Notify(ntPlayerEachMoveStart)
          local pieceEffectType = PieceEffectType.Normal
          local traps = self._pathTriggerTrapsDic[chainIndex]
          if traps then
            for _, e in ipairs(traps) do
              local prismGridValue = e:Trap():GetPrismGridValue()
              if prismGridValue then
                pieceEffectType = prismGridValue
                break
              end
            end
          end
          petEntity:SetGridPosition(v2Pos)
          local chainIndexOld = math.max(1, chainIndex - 1)
          local posOld = chainPath[chainIndexOld]
          local ntPlayerEachMoveEnd = NTPlayerEachMoveEnd:New(petEntity, v2Pos, pieceType, posOld, chainIndex, self._world:BattleStat():IsActiveSkillLinkLine())
          ntPlayerEachMoveEnd:SetPieceEffectType(pieceEffectType)
          triggerSvc:Notify(ntPlayerEachMoveEnd)
          if petEntityID == teamEntityLeader:GetID() or battleStatCmpt:IsActiveSkillLinkLine() then
            local v2TeamMoveBeginPos = teamEntity:GetGridPosition()
            teamEntity:SetGridPosition(v2Pos)
            local ntTeamLeaderEachMoveStart = NTTeamLeaderEachMoveStart:New(petEntity, v2Pos, pieceType, posOld)
            triggerSvc:Notify(ntTeamLeaderEachMoveStart)
            local ntTeamEachMoveStart = NTTeamEachMoveStart:New(teamEntity, v2Pos, pieceType, posOld)
            triggerSvc:Notify(ntTeamEachMoveStart)
            local ntTeamLeaderEachMoveEnd = NTTeamLeaderEachMoveEnd:New(petEntity, v2Pos, pieceType, posOld)
            ntTeamLeaderEachMoveEnd:SetPieceEffectType(pieceEffectType)
            triggerSvc:Notify(ntTeamLeaderEachMoveEnd)
            local ntTeamEachMoveEnd = NTTeamEachMoveEnd:New(teamEntity, v2Pos, pieceType, posOld)
            ntTeamEachMoveEnd:SetPieceEffectType(pieceEffectType)
            triggerSvc:Notify(ntTeamEachMoveEnd)
          end
        end
      end
    end
  end
end

function NormalSkillCalculator:_CalcNormalSkillExtraScope(normalAttackData)
  local attackGridData = normalAttackData:GetAttackGridData()
  local petEntityID = normalAttackData:GetPetEntityID()
  local petEntity = self._world:GetEntityByID(petEntityID)
  local normalSkillID = attackGridData:GetAttackGridSkillId()
  local beAttackPos = normalAttackData:GetBeAttackPos()
  local chainIndex = normalAttackData:GetChainIndex()
  local pathPosition = normalAttackData:GetPathPosition()
  local buffComp = petEntity:BuffComponent()
  local newAttackSkillId = buffComp:GetBuffValue("ChangeNormalSkillID") or normalSkillID
  local newAttackSkillCount = buffComp:GetBuffValue("ChangeNormalSkillCount") or 0
  local normalSkillDirectReplace = buffComp:GetBuffValue("NormalSkillDirectReplace")
  local onlyReplaceNormalSkillInXScope = buffComp:GetBuffValue("OnlyReplaceNormalSkillInXScope")
  local newNormalSkillExcludeOriPos = buffComp:GetBuffValue("ChangeNormalSkillExcludeOriPos") or 0
  local useAttackPosAsCenter = buffComp:GetBuffValue("ChangeNormalSkillUseAttackPosAsCenter") or 0
  local normalAttackRemoveSameTarget = buffComp:GetBuffValue("NormalAttackRemoveSameTarget") or 0
  local normalAttackCrossTwoCount = buffComp:GetBuffValue("NormalAttackCrossTwoCount") or 0
  local normalAttackUseSkillTarget = buffComp:GetBuffValue("NormalAttackUseSkillTarget") or 0
  local bScopeCheckOk = true
  if onlyReplaceNormalSkillInXScope and onlyReplaceNormalSkillInXScope == 1 and (pathPosition.x == beAttackPos.x or pathPosition.y == beAttackPos.y) then
    bScopeCheckOk = false
  end
  if 0 < normalAttackUseSkillTarget then
    Log.fatal("触发替换 skillID", newAttackSkillId)
    newAttackSkillCount = 1
  end
  local normalAttackIndex = normalAttackData:GetNormalAttackIndex()
  if normalAttackIndex and 1 < normalAttackIndex then
    local separateDoubleSkillID = buffComp:GetBuffValue("NormalAttackSeparateDoubleSkillID")
    newAttackSkillId = separateDoubleSkillID
  end
  if newAttackSkillId and 0 < newAttackSkillCount and bScopeCheckOk then
    if normalAttackUseSkillTarget == 0 then
      buffComp:SetBuffValue("ChangeNormalSkillCount", newAttackSkillCount - 1)
    end
    local targetIds = {}
    local gridPosArr = {}
    if normalSkillDirectReplace == 1 then
      attackGridData:SetAttackGridSkillID(newAttackSkillId)
    else
      local centerPos = beAttackPos
      if useAttackPosAsCenter == 1 then
        centerPos = pathPosition
      end
      local skillConfigData = self._configService:GetSkillConfigData(newAttackSkillId)
      local skillTargetType = skillConfigData:GetSkillTargetType()
      local casterDir = beAttackPos - pathPosition
      local utilScopeSvc = self._world:GetService("UtilScopeCalc")
      local scopeResult = utilScopeSvc:CalcSkillScope(skillConfigData, centerPos, petEntity, casterDir)
      local skill_range_grid_list = scopeResult:GetAttackRange()
      if newNormalSkillExcludeOriPos == 1 then
        table.removev(skill_range_grid_list, beAttackPos)
      end
      if 0 < normalAttackCrossTwoCount then
        local tmpRange = {}
        for _, gridPos in ipairs(skill_range_grid_list) do
          local distance = Vector2.Distance(gridPos, beAttackPos)
          if distance == 1 then
            table.insert(tmpRange, gridPos)
          end
        end
        skill_range_grid_list = tmpRange
      end
      skill_range_grid_list[#skill_range_grid_list + 1] = beAttackPos
      local targetEntities
      if self._world:MatchType() == MatchType.MT_BlackFist then
        targetEntities = {
          self._world:Player():GetCurrentEnemyTeamEntity()
        }
      else
        local monster_group = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
        targetEntities = monster_group:GetEntities()
      end
      if 0 < normalAttackUseSkillTarget then
        targetEntities = {}
        local targetEntityIDArray = self._skillScopeTargetSelector:DoSelectSkillTarget(petEntity, skillTargetType, scopeResult, newAttackSkillId, {1})
        for _, id in ipairs(targetEntityIDArray) do
          local entity = self._world:GetEntityByID(id)
          table.insert(targetEntities, entity)
        end
      end
      for _, e in ipairs(targetEntities) do
        if self._skillScopeTargetSelector:SelectConditionFilter(e, true) then
          local monster_grid_pos = e:GetGridPosition()
          local monster_body_area_cmpt = e:BodyArea()
          local monster_body_area = monster_body_area_cmpt:GetArea()
          local targetBodyPosInSkillRangePosList = {}
          for i, bodyArea in ipairs(monster_body_area) do
            local curMonsterBodyPos = monster_grid_pos + bodyArea
            if table.icontains(skill_range_grid_list, curMonsterBodyPos) then
              table.insert(targetBodyPosInSkillRangePosList, curMonsterBodyPos)
            end
          end
          if 0 < table.count(targetBodyPosInSkillRangePosList) then
            if normalAttackRemoveSameTarget == 1 then
              table.sort(targetBodyPosInSkillRangePosList, function(a, b)
                local disA = Vector2.Distance(pathPosition, a)
                local disB = Vector2.Distance(pathPosition, b)
                return disA < disB
              end)
              table.insert(targetIds, e:GetID())
              table.insert(gridPosArr, targetBodyPosInSkillRangePosList[1])
            else
              for i, pos in ipairs(targetBodyPosInSkillRangePosList) do
                table.insert(targetIds, e:GetID())
                table.insert(gridPosArr, pos)
              end
            end
          end
        end
      end
      local NewAttackGridData = attackGridData
      if normalSkillID ~= newAttackSkillId then
        NewAttackGridData = AttackGridData:New(nil, nil, nil, newAttackSkillId, petEntityID)
      end
      NewAttackGridData:ClearTargetIdList()
      for i = 1, #targetIds do
        NewAttackGridData:AddTargetId(targetIds[i])
      end
      NewAttackGridData:ClearAttackPosList()
      for i = 1, #gridPosArr do
        NewAttackGridData:AddAttackPos(gridPosArr[i])
      end
      attackGridData = NewAttackGridData
      normalAttackData:SetAttackGridData(NewAttackGridData)
    end
    normalSkillID = newAttackSkillId
  end
  return attackGridData, normalSkillID, normalSkillDirectReplace
end

function NormalSkillCalculator:_CalcNormalSkillEffect(teamEntity, normalAttackData, attackGridData, originalSkillID, originaBeAttackPos, directReplace, isNormalAttackDouble)
  local endChainIndx = self:_CalcEndIndex()
  local petEntityID = normalAttackData:GetPetEntityID()
  local petEntity = self._world:GetEntityByID(petEntityID)
  local normalSkillID = attackGridData:GetAttackGridSkillId()
  local chainIndex = normalAttackData:GetChainIndex()
  local beAttackEntityIdList = attackGridData:GetTargetIdList()
  local gridPosArr = attackGridData:GetAttackPosList()
  local normalAttackIndex = normalAttackData:GetNormalAttackIndex()
  if normalAttackIndex then
    attackGridData:SetNormalAttackIndex(normalAttackIndex)
  end
  local buffComp = petEntity:BuffComponent()
  local normalAttackOneDamageOneCombo = buffComp:GetBuffValue("NormalAttackOneDamageOneCombo")
  if chainIndex < self._deadChainIndx and endChainIndx > chainIndex then
    local petAtkComponent = petEntity:SkillPetAttackData()
    local utilCalcSvc = self._world:GetService("UtilCalc")
    local logicChainPathCmpt = teamEntity:LogicChainPath()
    local chainRate = logicChainPathCmpt:GetChainRateAtIndex(chainIndex)
    petAtkComponent:SetCurrentChainDamageRate(chainRate)
    local superGridNum = logicChainPathCmpt:GetSuperGridCountAtPathIndex(chainIndex)
    petAtkComponent:SetCurrentSuperGridNum(superGridNum)
    local poorGridNum = logicChainPathCmpt:GetPoorGridCountAtPathIndex(chainIndex)
    petAtkComponent:SetCurrentPoorGridNum(poorGridNum)
    local chainPathPoint = self._chainPathData[chainIndex]
    self._world:GetService("Trigger"):Notify(NTNormalAttackCalcStart:New(petEntity, attackGridData))
    local firstDefender, firstDefenderPos, firstDamagePos
    for i = 1, #beAttackEntityIdList do
      local beAttackEntityID = beAttackEntityIdList[i]
      local defenderEntity = self._world:GetEntityByID(beAttackEntityID)
      local pos = defenderEntity:GridLocation().Position
      if not firstDefender then
        firstDefender = defenderEntity
        firstDefenderPos = pos
      end
      local gridPos = pos
      if gridPosArr and gridPosArr[i] then
        gridPos = gridPosArr[i]
      end
      firstDamagePos = firstDamagePos or gridPos
      local skillID = normalSkillID
      if gridPos == originaBeAttackPos and directReplace == 0 then
        skillID = originalSkillID
      end
      local calcParam = SkillEffectCalcParam:New(petEntityID, {beAttackEntityID}, nil, skillID, nil, chainPathPoint, gridPos)
      calcParam:SetDamageGridPos(gridPos)
      if normalAttackIndex then
        calcParam:SetNormalAttackIndex(normalAttackIndex)
      end
      self:_OnApplyEachSkillEffect(petEntity, attackGridData, calcParam, isNormalAttackDouble)
      if normalAttackOneDamageOneCombo == 1 and i ~= #beAttackEntityIdList then
        self:_AddCombo(teamEntity)
        local skillAddComboResult = SkillAddComboNumEffectResult:New()
        attackGridData:AddEffectResult(skillAddComboResult)
      end
    end
    local hasDamageEffect = false
    local svcCfgDeco = self._world:GetService("ConfigDecoration")
    local skillEffectArray = svcCfgDeco:GetLatestEffectParamArray(petEntity:GetID(), normalSkillID)
    for _, v in ipairs(skillEffectArray) do
      local skillEffectParam = v
      local skillEffectType = skillEffectParam:GetEffectType()
      if skillEffectType == SkillEffectType.Damage then
        hasDamageEffect = true
        break
      end
    end
    if hasDamageEffect then
      self:_AddCombo(teamEntity)
    end
    local nt = NTNormalAttackCalcEnd:New(petEntity, firstDefender, chainPathPoint, firstDamagePos)
    nt:SetSkillID(normalSkillID)
    nt:SetSkillType(SkillType.Normal)
    nt:SetNormalAttackIndex(normalAttackIndex)
    self._world:GetService("Trigger"):Notify(nt)
    local nt1 = NTNormalAttackCalcEndUseOriPos:New(petEntity, firstDefender, chainPathPoint, originaBeAttackPos)
    nt1:SetSkillID(normalSkillID)
    nt1:SetSkillType(SkillType.Normal)
    nt1:SetNormalAttackIndex(normalAttackIndex)
    self._world:GetService("Trigger"):Notify(nt1)
  end
end

function NormalSkillCalculator:_AddCombo(teamEntity)
  local battleSvc = self._world:GetService("Battle")
  local battleStatComponent = self._world:BattleStat()
  local curComboNum = battleSvc:GetLogicComboNum()
  curComboNum = curComboNum + 1
  battleSvc:SetLogicComboNum(curComboNum)
  battleStatComponent:SetOneChainMaxNormalAttack(teamEntity, curComboNum)
end

function NormalSkillCalculator:_OnApplyEachSkillEffect(petEntity, attackGridData, t, isNormalAttackDouble)
  local logger = self._world:GetMatchLogger()
  logger:BeginSkill(t.casterEntityID, t.attackPos, t.skillID, t.skillRange)
  self:_NotifyNormalSkillBegin(t, attackGridData)
  local saveSkillDamageEffectResult = self:_SaveDamageResultBeforeAddBlood(t)
  local totalDamage = 0
  local damageType
  local skillEffectResultArray = self._skillEffectCalcService:CalcSkillEffect_All(t)
  for effectResultIndex = 1, #skillEffectResultArray do
    local skillResultData = skillEffectResultArray[effectResultIndex]
    local skillEffectType = skillResultData:GetEffectType()
    attackGridData:AddEffectResult(skillResultData)
    if skillEffectType == SkillEffectType.Damage then
      local skillDamageEffectResult = skillResultData
      local damageInfo = skillDamageEffectResult:GetDamageInfo(1)
      local targetID = skillDamageEffectResult:GetTargetID()
      local castDamage = skillDamageEffectResult:GetTotalDamage()
      if isNormalAttackDouble then
        skillDamageEffectResult:SetNormalAttackDouble(true)
      end
      local normalAttackIndex = attackGridData:GetNormalAttackIndex()
      if normalAttackIndex then
        skillDamageEffectResult:SetNormalAttackIndex(normalAttackIndex)
        skillDamageEffectResult:SetDamageStageIndex(normalAttackIndex)
      end
      damageType = damageInfo:GetDamageType()
      attackGridData:AddDamageValue(targetID, castDamage)
      totalDamage = totalDamage + castDamage
    elseif skillEffectType == SkillEffectType.AddBlood then
      damageType = DamageType.Invalid
      attackGridData:AddEffectResult(saveSkillDamageEffectResult)
      local addBloodResult = skillResultData
      local targetID = addBloodResult:GetTargetID()
      local healValue = addBloodResult:GetAddValue()
      local addHpDamageInfo = DamageInfo:New(healValue, DamageType.Recover)
      local calcDamageSvc = self._world:GetService("CalcDamage")
      calcDamageSvc:AddTargetHP(targetID, addHpDamageInfo)
      addBloodResult:SetDamageInfo(addHpDamageInfo)
      attackGridData:AddEffectResult(addBloodResult)
    elseif skillEffectType == SkillEffectType.WeikeNotify then
      local executor = SkillEffectLogicExecutor:New(self._world)
      executor:_ApplyWeikeNotify(petEntity, {}, {skillResultData})
      attackGridData:AddEffectResult(skillResultData)
    end
  end
  self:_NotifyNormalSkillEnd(t, damageType, totalDamage, saveSkillDamageEffectResult, attackGridData)
  logger:EndSkill(t.casterEntityID)
  self._world:GetDataLogger():AddDataLog("OnNormalSkillEnd", petEntity, t.skillID, totalDamage)
end

function NormalSkillCalculator:_SaveDamageResultBeforeAddBlood(t)
  local damageInfo = DamageInfo:New(0, DamageType.Invalid)
  local skillDamageEffectResult = SkillDamageEffectResult:New(t.gridPos, t.targetEntityIDs[1], 0, {damageInfo})
  return skillDamageEffectResult
end

function NormalSkillCalculator:_NotifyNormalSkillBegin(t, attackGridData)
  local triggerSvc = self._world:GetService("Trigger")
  local attacker = self._world:GetEntityByID(t.casterEntityID)
  local defender = self._world:GetEntityByID(t.targetEntityIDs[1])
  local nt = NTNormalEachAttackStart:New(attacker, defender, t.attackPos, t.gridPos)
  nt:SetSkillID(t.skillID)
  nt:SetSkillType(SkillType.Normal)
  nt:SetNormalAttackIndex(attackGridData:GetNormalAttackIndex())
  triggerSvc:Notify(nt)
end

function NormalSkillCalculator:_NotifyNormalSkillEnd(t, damageType, damageValue, damageResult, attackGridData)
  local triggerSvc = self._world:GetService("Trigger")
  local attacker = self._world:GetEntityByID(t.casterEntityID)
  local defender = self._world:GetEntityByID(damageResult:GetTargetID())
  local battleStatComponent = self._world:BattleStat()
  local heroLastAttackMonster = {
    defender:GetID(),
    damageResult:GetGridPos()
  }
  battleStatComponent:SetHeroLastAttackMonster(heroLastAttackMonster)
  local nt = NTNormalEachAttackEnd:New(attacker, defender, t.attackPos, damageResult:GetGridPos())
  nt:SetSkillID(t.skillID)
  nt:SetSkillType(SkillType.Normal)
  nt:SetDamageValue(damageValue)
  nt:SetDamageType(damageType)
  nt:SetNormalAttackIndex(attackGridData:GetNormalAttackIndex())
  triggerSvc:Notify(nt)
end

function NormalSkillCalculator:_SaveAttackGridData(normalAttackData, attackGridData)
  local petEntityID = normalAttackData:GetPetEntityID()
  local petEntity = self._world:GetEntityByID(petEntityID)
  local chainIndex = normalAttackData:GetChainIndex()
  local beAttackPos = normalAttackData:GetBeAttackPos()
  local skillPetAttackDataComponent = petEntity:SkillPetAttackData()
  local normalAtkData = skillPetAttackDataComponent:GetNormalAttackData()
  local pos = self._chainPathData[chainIndex]
  local pathPointNormalAttackData = normalAtkData:GetPathPointAttackData(pos)
  local attackGridDic = {}
  local normalAttackIndex = normalAttackData:GetNormalAttackIndex()
  if normalAttackIndex and normalAttackIndex == 2 then
    attackGridDic = pathPointNormalAttackData:GetAttackGridDicAdditional()
  else
    attackGridDic = pathPointNormalAttackData:GetAttackGridDic()
  end
  for k, v in pairs(attackGridDic) do
    local kPos = Vector2.Index2Pos(k)
    if kPos.x == beAttackPos.x and kPos.y == beAttackPos.y then
      attackGridDic[k] = attackGridData
      break
    end
  end
end

function NormalSkillCalculator:_GetNormalAttackHitTimeAndLength(skillID, isLastAttackPos, casterEntity)
  local skinId = 1
  if casterEntity:MatchPet() then
    skinId = casterEntity:MatchPet():GetMatchPet():GetSkinId()
  end
  local skillConfigData = self._configService:GetSkillConfigData(skillID)
  local skillPhaseArray = skillConfigData:GetSkillPhaseArray(skinId)
  if skillPhaseArray == nil or #skillPhaseArray == 0 then
    if self._skillViewParser == nil then
      self._skillViewParser = SkillViewParamParser:New()
    end
    local skillConfig = BattleSkillCfg(skillID)
    local skillViewID = skillConfig.ViewID
    if skillConfig.SpecialView then
      local skinSkillViewID = skillConfig.SpecialView[skinId]
      if skinSkillViewID then
        skillViewID = skinSkillViewID
      end
    end
    skillPhaseArray = self._skillViewParser:ParseSkillView(skillViewID)
  end
  if #skillPhaseArray < 1 then
    Log.fatal("_GetNormalAttackHitTimeAndLength, skill phase array size < 1, skillID:" .. skillID)
    return 0, 0
  end
  local phaseData
  for i = 1, #skillPhaseArray do
    local tmpPhaseData = skillPhaseArray[i]
    local posdirParam = tmpPhaseData:GetPosDirParam()
    local phaseParam = tmpPhaseData:GetPhaseParam()
    local phaseType = phaseParam:GetPhaseType()
    if phaseType == SkillViewPhaseType.AttackAnimation or phaseType == SkillViewPhaseType.NormalAttackForAddBlood or phaseType == SkillViewPhaseType.NormalAttackOnlyAnimation or phaseType == SkillViewPhaseType.NormalAttackWithMove then
      phaseData = tmpPhaseData
      break
    end
  end
  if not phaseData then
    Log.fatal("_GetNormalAttackHitTimeAndLength, phaseType ~= SkillViewPhaseType.AttackAnimation, skillID:" .. skillID)
    return 0, 0
  end
  local phaseParam = phaseData:GetPhaseParam()
  return phaseParam:GetHitPointDelay(isLastAttackPos) / 1000, phaseParam:GetCastTotalTime(isLastAttackPos) / 1000
end

function NormalSkillCalculator:_MakeTimeFrameTimeMultiple(time)
  if not self._frameTimeMultipleDic[time] then
    self._frameTimeMultipleDic[time] = math.ceil(time / BattleConst.FrameTime) * BattleConst.FrameTime
  end
  return self._frameTimeMultipleDic[time]
end

function NormalSkillCalculator:_IsPosInCrossLine(pos1, pos2)
  return pos1.x - pos2.x == 0 or pos1.y - pos2.y == 0
end

function NormalSkillCalculator:_FindAttackGridData(attackGridDic, beAttackPos)
  for k, v in pairs(attackGridDic) do
    local v2 = Vector2.Index2Pos(k)
    if v2 == beAttackPos then
      return v
    end
  end
  return nil
end

function NormalSkillCalculator:_GetTrapDelay(trapEntityList)
  return 0
end

function NormalSkillCalculator:_CalcTrapTrigger(trapEntityList, targetID)
  local maxLevel = -1
  local minLevel = 100000
  for key, _ in pairs(trapEntityList) do
    if key then
      if key > maxLevel then
        maxLevel = key
      end
      if key < minLevel then
        minLevel = key
      end
    end
  end
  local triggerTraps = {}
  for i = maxLevel, minLevel, -1 do
    local trap = trapEntityList[i]
    if trap then
      local eTarget = self._world:GetEntityByID(targetID)
      local taps = self._trapServiceLogic:CalcTrapTriggerSkill(trap, eTarget)
      table.appendArray(triggerTraps, taps)
    end
  end
  return triggerTraps
end

function NormalSkillCalculator:_GetIndexTrapDic(teamEntity)
  local trapServiceLogic = self._world:GetService("TrapLogic")
  local utilDataSvc = self._world:GetService("UtilData")
  local res = {}
  if utilDataSvc:IsPreviewNeedShowLinkageNumForCostStep() then
    return res
  end
  local trapGroup = self._world:GetGroup(self._world.BW_WEMatchers.Trap)
  for _, e in ipairs(trapGroup:GetEntities()) do
    local trapCmpt = e:Trap()
    if trapServiceLogic:CanSelectByRaceType(e, teamEntity) and trapCmpt:GetTriggerSkillID() then
      local pos = e:GridLocation().Position
      for i = 1, #self._chainPathData do
        if pos == self._chainPathData[i] then
          if not res[i] then
            res[i] = {}
          end
          res[i][trapCmpt:GetTrapLevel()] = e
        end
      end
    end
  end
  return res
end

function NormalSkillCalculator:_GetPathSuperGridCount()
  local trapServiceLogic = self._world:GetService("TrapLogic")
  local mapSuperGridTrapEntities = {}
  local GLOBALtrapGroupEntities = self._world:GetGroupEntities(self._world.BW_WEMatchers.Trap)
  for _, e in ipairs(GLOBALtrapGroupEntities) do
    local cTrap = e:Trap()
    if cTrap:IsSuperGrid() and not e:HasDeadMark() then
      local posIndex = e:GetGridPosition():Pos2Index()
      mapSuperGridTrapEntities[posIndex] = e
    end
  end
  local t = {}
  local count = 0
  for i = 1, #self._chainPathData do
    local posIndex = self._chainPathData[i]:Pos2Index()
    if mapSuperGridTrapEntities[posIndex] then
      count = count + 1
    end
    t[i] = count
  end
  return t
end

function NormalSkillCalculator:_ModifyPathSuperGridCount(pathSuperGridCount, teamEntity)
  local buffComp = teamEntity:BuffComponent()
  local addCountVal = buffComp:GetBuffValue("PetAbsorbSuperGridCount")
  if addCountVal then
    local addCount = tonumber(addCountVal)
    if 0 < addCount then
      for index, count in ipairs(pathSuperGridCount) do
        pathSuperGridCount[index] = count + addCount
      end
    end
  end
  return pathSuperGridCount
end

function NormalSkillCalculator:_GetPathPoorGridCount()
  local trapServiceLogic = self._world:GetService("TrapLogic")
  local poorGridEntityByPosIndex = {}
  local globalTrapEntities = self._world:GetGroupEntities(self._world.BW_WEMatchers.Trap)
  for _, e in ipairs(globalTrapEntities) do
    local cTrap = e:Trap()
    if cTrap:IsPoorGrid() and not e:HasDeadMark() then
      local posIndex = e:GetGridPosition():Pos2Index()
      poorGridEntityByPosIndex[posIndex] = e
    end
  end
  local t = {}
  local count = 0
  for i = 1, #self._chainPathData do
    local posIndex = self._chainPathData[i]:Pos2Index()
    if poorGridEntityByPosIndex[posIndex] then
      count = count + 1
    end
    t[i] = count
  end
  return t
end

function NormalSkillCalculator:_CalcEndIndex()
  if self._chainPathData then
    local utilDataSvc = self._world:GetService("UtilData")
    local lastIdx = table.count(self._chainPathData)
    local lastPos = self._chainPathData[lastIdx]
    if utilDataSvc:IsPosExit(lastPos) then
      return lastIdx
    end
  end
  return 99999
end

function NormalSkillCalculator:_OnCheckTriggerTrapBeforeAttack(teamEntity, index)
  local attackTime = self._timeAttackListDic:GetKeyAt(index)
  while self._timeTrapDic:Size() >= self._triggerTrapIndex and attackTime >= self._timeTrapDic:GetKeyAt(self._triggerTrapIndex) do
    local jump = self:_OnCheckTriggerTrap(teamEntity)
    if jump then
      break
    end
  end
end

function NormalSkillCalculator:_OnCheckTriggerTrapAfterAttackAll(teamEntity)
  while self._timeTrapDic:Size() >= self._triggerTrapIndex and not teamEntity:HasTeamDeadMark() do
    local jump = self:_OnCheckTriggerTrap(teamEntity)
    if jump then
      break
    end
  end
end

function NormalSkillCalculator:_OnCheckTriggerTrap(teamEntity)
  local chainIndex = self._timeTrapDic:GetAt(self._triggerTrapIndex)
  if self._stopChainIndex and chainIndex >= self._stopChainIndex then
    return true
  end
  if chainIndex >= self._deadChainIndx then
    return true
  end
  local utilData = self._world:GetService("UtilData")
  if utilData:PlayerIsDead(teamEntity) then
    self._deadChainIndx = chainIndex
    if teamEntity:HasTeamDeadMark() then
      Log.fatal("Player already dead")
    else
      teamEntity:AddTeamDeadMark(self._chainPathData[chainIndex])
      Log.info("Trap cause player dead at", self._chainPathData[chainIndex])
    end
    return true
  end
  local position = self._chainPathData[chainIndex]
  teamEntity:SetGridPosition(position)
  local triggerTraps = self:_CalcTrapTrigger(self._indexTrapDic[chainIndex], teamEntity:GetID())
  self._pathTriggerTrapsDic[chainIndex] = triggerTraps
  if teamEntity:BuffComponent():HasFlag(BuffFlags.Benumb) and not self._stopChainIndex then
    self._stopChainIndex = chainIndex
    self:RebuildChainPath(teamEntity)
  end
  self._triggerTrapIndex = self._triggerTrapIndex + 1
  return false
end

function NormalSkillCalculator:_SetNormalAttackDead()
  local sMonsterShowLogic = self._world:GetService("MonsterShowLogic")
  local monsterGroup = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
  for _, e in ipairs(monsterGroup:GetEntities()) do
    sMonsterShowLogic:AddMonsterDeadMark(e)
  end
end

function NormalSkillCalculator:_GetNormalAttackTime(petIndex, pathPosition)
  local attackCount = self:_GetNormalAttackCount(petIndex, pathPosition)
  local attackTime = 0
  if 0 < attackCount then
    attackTime = attackTime + 0.5 + BattleConst.FrameTime * 3
    if 1 < attackCount then
      local addTime = 0.333 + BattleConst.FrameTime * 3
      attackTime = attackTime + (attackCount - 1) * addTime
    end
  end
  return attackTime
end

function NormalSkillCalculator:_GetNormalAttackCount(petIndex, pathPosition)
  local petEntityID = self._petRoundTeam[petIndex]
  local petEntity = self._world:GetEntityByID(petEntityID)
  local attackCount = 0
  local petAttackDataCmpt = petEntity:SkillPetAttackData()
  local normalAttackData = petAttackDataCmpt:GetNormalAttackData()
  local pathPointAttackData = normalAttackData:GetPathPointAttackData(pathPosition)
  if pathPointAttackData ~= nil then
    local orderGridArray = pathPointAttackData:GetPetOrderGridArray(petEntity, pathPosition)
    if petEntity:BuffComponent():GetBuffValue("ForcePetNormalAttackAfterMove") then
      local chainPath = petEntity:Pet():GetOwnerTeamEntity():LogicChainPath():GetLogicChainPath()
      local beginGrid = chainPath[1]
      if beginGrid ~= pathPosition then
        orderGridArray = {}
      else
        orderGridArray = {pathPosition}
      end
    end
    attackCount = attackCount + #orderGridArray
  end
  return attackCount
end

function NormalSkillCalculator:_OnGetPathAttackList(teamEntity, chain_path)
  local petsAttactList = {}
  local logicTeamCmpt = teamEntity:LogicRoundTeam()
  local petRoundTeam = logicTeamCmpt:GetPetRoundTeam()
  for i, petEntityID in ipairs(petRoundTeam) do
    local petEntity = self._world:GetEntityByID(petEntityID)
    local attackCount = 0
    for chainIndex, pathPosition in ipairs(chain_path) do
      local petAttackDataCmpt = petEntity:SkillPetAttackData()
      local normalAttackData = petAttackDataCmpt:GetNormalAttackData()
      local pathPointAttackData = normalAttackData:GetPathPointAttackData(pathPosition)
      if pathPointAttackData ~= nil then
        local orderGridArray = pathPointAttackData:GetPetOrderGridArray(petEntity, pathPosition)
        if petEntity:BuffComponent():GetBuffValue("ForcePetNormalAttackAfterMove") then
          if chainIndex ~= 1 then
            orderGridArray = {pathPosition}
          else
            orderGridArray = {}
          end
        end
        attackCount = attackCount + #orderGridArray
      end
    end
    if 0 < attackCount then
      table.insert(petsAttactList, attackCount)
    end
  end
  return petsAttactList
end

function NormalSkillCalculator:_OnGetPathMoveStartWaitTime(petsAttactList)
  local moveWaitTime = 0
  if #petsAttactList == 0 then
    moveWaitTime = 10 * BattleConst.FrameTime
  else
    local hasEightDirectionAttack = false
    local petAttackCount = 0
    for i, attackCount in ipairs(petsAttactList) do
      if i ~= 1 and petAttackCount ~= attackCount then
        hasEightDirectionAttack = true
        break
      end
      petAttackCount = attackCount
    end
    moveWaitTime = (petAttackCount - 1) * 0.333 + 0.5
    if 1 < moveWaitTime then
      moveWaitTime = 1
    end
  end
  return moveWaitTime
end

function NormalSkillCalculator:GetPlayNormalSkillSequence()
  return self._playNormalSkillSequence
end

function NormalSkillCalculator:GetTriggerTraps()
  return self._pathTriggerTrapsDic
end

function NormalSkillCalculator:GetPathNormalSkillWaitTimes()
  return self._pathNormalSkillWaitTimeDic
end

function NormalSkillCalculator:GetPathMoveStartWaitTime()
  return self._pathMoveStartWaitTime
end

function NormalSkillCalculator:CanAttackByPos(attackPos)
  if self._stopChainIndex then
    for i, v in ipairs(self._chainPathData) do
      if v.x == attackPos.x and v.y == attackPos.y and i ~= self._stopChainIndex then
        return true
      end
    end
    return false
  else
    return true
  end
end

function NormalSkillCalculator:CanMoveToPos(movePos)
  if self._stopChainIndex then
    for i, v in ipairs(self._chainPathData) do
      if v.x == movePos.x and v.y == movePos.y and i <= self._stopChainIndex then
        return true
      end
    end
    return false
  else
    return true
  end
end

function NormalSkillCalculator:RebuildChainPath(teamEntity)
  self._chainPathData = table.sub(self._chainPathData, 1, self._stopChainIndex)
  local logicChainPathCmpt = teamEntity:LogicChainPath()
  local logicPath = logicChainPathCmpt:GetLogicChainPath()
  local cutChainPath = {}
  for index, pos in ipairs(logicPath) do
    if index > self._stopChainIndex then
      cutChainPath[index] = pos
    end
  end
  logicPath = table.sub(logicPath, 1, self._stopChainIndex)
  logicChainPathCmpt:SetLogicChainPath(logicPath, logicChainPathCmpt:GetLogicPieceType())
  logicChainPathCmpt:SetCutChainPath(cutChainPath)
  self._skillLogicService:UpdateTeamGridLocationByChainPath(teamEntity, logicPath)
end

function NormalSkillCalculator:_OnSavePlayNormalSkillSequence(casterEntity, normalSkillIndex, originalSkillID, newAttackSkillId, normalAttackData, originaBeAttackPos, attackGridData)
  local hitTime, length = self:_GetNormalAttackHitTimeAndLength(originalSkillID, normalAttackData:GetisLastAttackPos(), casterEntity)
  local playNormalSkill = {}
  playNormalSkill.order = normalSkillIndex
  playNormalSkill.skillID = newAttackSkillId
  playNormalSkill.attackPos = normalAttackData:GetPathPosition()
  playNormalSkill.beAttackPos = originaBeAttackPos
  playNormalSkill.attackGridData = attackGridData
  playNormalSkill.hitPointDelay = hitTime * 1000
  playNormalSkill.playStartTime = 0
  table.insert(self._playNormalSkillSequence, playNormalSkill)
  normalSkillIndex = normalSkillIndex + 1
end

function NormalSkillCalculator:_OnCheckNormalAttackDouble(casterEntity, normalAttackData)
  local buffComponent = casterEntity:BuffComponent()
  local normalAttackDoubleCountKey = "NormalAttackDoubleCount"
  local normalAttackDoubleCount = buffComponent:GetBuffValue(normalAttackDoubleCountKey)
  if normalAttackDoubleCount and 0 < normalAttackDoubleCount then
    local newCount = normalAttackDoubleCount - 1
    buffComponent:SetBuffValue(normalAttackDoubleCountKey, newCount)
    return true
  end
  local normalAttackDoubleBaseRateKey = "NormalAttackDoubleBaseRate"
  local normalAttackDoubleEachMoveIncreaseRateKey = "NormalAttackDoubleEachMoveIncreaseRate"
  local normalAttackDoubleBaseRate = buffComponent:GetBuffValue(normalAttackDoubleBaseRateKey)
  local normalAttackDoubleEachMoveIncreaseRate = buffComponent:GetBuffValue(normalAttackDoubleEachMoveIncreaseRateKey)
  local chainIndex = normalAttackData:GetChainIndex()
  if normalAttackDoubleBaseRate then
    local doubleRate = normalAttackDoubleBaseRate
    if normalAttackDoubleEachMoveIncreaseRate and normalAttackDoubleEachMoveIncreaseRate ~= 0 then
      doubleRate = doubleRate + (chainIndex - 1) * normalAttackDoubleEachMoveIncreaseRate
    end
    if 1 < doubleRate then
      doubleRate = 1
    end
    if 0 < doubleRate then
      local checkParam = doubleRate * 1000
      local randomSvc = self._world:GetService("RandomLogic")
      local nRandNum = randomSvc:LogicRand(1, 1000)
      if checkParam >= nRandNum then
        return true
      end
    end
  end
  return false
end

function NormalSkillCalculator:_ForNormalAttackDouble(teamEntity, casterEntity, normalAttackData, originalAttackPosList, originalTargetIdList, originaBeAttackPos, originalSkillID)
  local attackGridData = normalAttackData:GetAttackGridData()
  attackGridData:SetAttackPosList(originalAttackPosList)
  attackGridData:SetTargetIdList(originalTargetIdList)
  local attackPos = normalAttackData:GetPathPosition()
  self._world:GetService("Trigger"):Notify(NTNormalAttackChangeBefore:New(casterEntity, attackPos, originaBeAttackPos))
  local newAttackSkillId = originalSkillID
  local directReplace = 0
  attackGridData, newAttackSkillId, directReplace = self:_CalcNormalSkillExtraScope(normalAttackData)
  local isNormalAttackDouble = true
  self:_CalcNormalSkillEffect(teamEntity, normalAttackData, attackGridData, originalSkillID, originaBeAttackPos, directReplace, isNormalAttackDouble)
  self._world:GetService("Trigger"):Notify(NTNormalAttackChangeAfter:New(casterEntity, attackPos, originaBeAttackPos))
end
