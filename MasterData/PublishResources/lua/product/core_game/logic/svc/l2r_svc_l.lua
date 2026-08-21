_class("L2RService", BaseService)
L2RService = L2RService

function L2RService:Constructor(world)
  self._world = world
end

function L2RService:L2RBoardLogicData()
  if self._world:RunAtServer() then
    return
  end
  local data = DataBoardLogicResult:New()
  local boardCmpt = self._world:GetBoardEntity():Board()
  local piecesEffectTypeList = boardCmpt:ClonePiecesEffectTypeList()
  data:SetPiecesEffectTypeList(piecesEffectTypeList)
  local prismEntityIDs = boardCmpt:ClonePrismEntityIDs()
  data:SetPrismEntityIDs(prismEntityIDs)
  local pieceTable = boardCmpt:ClonePieceTable()
  data:SetPieceTable(pieceTable)
  local pieceTypes = self:_CalcBoardPosPieceType(pieceTable)
  data:SetPieceTypes(pieceTypes)
  local blockFlags = self:_CalcBoardBlockFlags()
  data:SetBlockFlags(blockFlags)
  local immuneHitbackEIDs = self:_CalcImmuneHitbackEntities()
  data:SetImmuneHitbacks(immuneHitbackEIDs)
  local pieceEntities = boardCmpt:ClonePieceEntities()
  data:SetPieceEntities(pieceEntities)
  self._world:EventDispatcher():Dispatch(GameEventType.DataLogicResult, 0, data)
end

function L2RService:L2RSyncPieceType()
  if self._world:RunAtServer() then
    return
  end
  local data = DataPieceTypeResult:New()
  local boardCmpt = self._world:GetBoardEntity():Board()
  local pieceTable = boardCmpt:ClonePieceTable()
  data:SetPieceTable(pieceTable)
  local pieceTypes = self:_CalcBoardPosPieceType(pieceTable)
  data:SetPieceTypes(pieceTypes)
  self._world:EventDispatcher():Dispatch(GameEventType.DataLogicResult, 0, data)
end

function L2RService:_CalcBoardPosPieceType(pieceTable)
  local posColor = {}
  for x, row in pairs(pieceTable) do
    for y, color in pairs(row) do
      local posIdx = x * 100 + y
      posColor[posIdx] = color
    end
  end
  return posColor
end

function L2RService:_CalcBoardBlockFlags()
  local board = self._world:GetBoardEntity():Board()
  local arr = board:GetBlockFlagArray()
  local posBlockData = {}
  for x, row in pairs(arr) do
    for y, data in pairs(row) do
      local posIdx = x * 100 + y
      posBlockData[posIdx] = table_to_class(data)
    end
  end
  return posBlockData
end

function L2RService:_CalcImmuneHitbackEntities()
  local BuffLogicSvc = self._world:GetService("BuffLogic")
  local es = {}
  local group = self._world:GetGroup(self._world.BW_WEMatchers.AI)
  for i, e in ipairs(group:GetEntities()) do
    if not BuffLogicSvc:CheckCanBeHitBack(e) then
      es[#es + 1] = e:GetID()
    end
  end
  return es
end

function L2RService:L2RLoadingData()
  local res = L2R_LoadingResult:New()
  if self._world:MatchType() == MatchType.MT_Chess then
    local creationResult = self:_GetChessPetCreationResult()
    res:SetChessPetCreationResult(creationResult)
  end
  if self._world:MatchType() ~= MatchType.MT_Chess then
    local teamRes = self:_GetTeamCreationResult()
    res:SetTeamCreationResult(teamRes)
  end
  local monsterCreationSvc = self._world:GetService("MonsterCreationLogic")
  local monsterResList = monsterCreationSvc:GenerateMonsterCreationResult()
  res:SetLoadMonsterResultList(monsterResList)
  self._world:EventDispatcher():Dispatch(GameEventType.DataLogicResult, LogicStepType.Loading, res)
end

function L2RService:_GetTeamCreationResult()
  local teamRes = {}
  local teamEntity = self._world:Player():GetLocalTeamEntity()
  teamRes[1] = self:_CalcTeamCreationResult(teamEntity)
  local petResList = self:_CalcPetCreationResultList(teamEntity)
  teamRes[1]:SetPetCreationResultList(petResList)
  if self._world:MatchType() == MatchType.MT_BlackFist then
    local remoteTeamEntity = self._world:Player():GetRemoteTeamEntity()
    teamRes[2] = self:_CalcTeamCreationResult(remoteTeamEntity)
    local petResList = self:_CalcPetCreationResultList(remoteTeamEntity)
    teamRes[2]:SetPetCreationResultList(petResList)
  end
  return teamRes
end

function L2RService:_CalcPetCreationResultList(teamEntity)
  local creationResList = {}
  local petEntityList = teamEntity:Team():GetTeamPetEntities()
  for petIndex, petEntity in ipairs(petEntityList) do
    local petRes = DataPetCreationResult:New()
    local matchPet = petEntity:MatchPet():GetMatchPet()
    local eid = petEntity:GetID()
    petRes:SetPetCreationLogicEntityID(eid)
    local tplID = matchPet:GetTemplateID()
    petRes:SetPetCreationTemplateID(tplID)
    local pstID = matchPet:GetPstID()
    petRes:SetPetCreationPstID(pstID)
    local firstElement = matchPet:GetPetFirstElement()
    local secondElement = matchPet:GetPetSecondElement()
    petRes:SetPetCreationElementType(firstElement, secondElement)
    local petPrefab = matchPet:GetPetPrefab(PetSkinEffectPath.MODEL_INGAME)
    petRes:SetPetCreationRes(petPrefab)
    local gridLocCmpt = petEntity:GridLocation()
    local gridPos = gridLocCmpt:GetGridPos()
    petRes:SetPetCreationGridPos(gridPos)
    local attrCmpt = petEntity:Attributes()
    local hp = attrCmpt:GetCurrentHP()
    local maxHP = attrCmpt:CalcMaxHp()
    petRes:SetPetCreation_CurHp(hp)
    petRes:SetPetCreation_MaxHp(maxHP)
    creationResList[#creationResList + 1] = petRes
  end
  return creationResList
end

function L2RService:_CalcTeamCreationResult(teamEntity)
  local teamRes = DataTeamCreationResult:New()
  teamRes:SetCreationResultTeamEntityID(teamEntity:GetID())
  local heroPos = teamEntity:GetGridPosition()
  local heroRotation = teamEntity:GridLocation():GetGridDir()
  teamRes:SetCreationResultBornPos(heroPos)
  teamRes:SetCreationResultBornRotation(heroRotation)
  local utilDataSvc = self._world:GetService("UtilData")
  local firstElement = utilDataSvc:GetEntityElementPrimaryType(teamEntity)
  teamRes:SetCreationResultElement(firstElement)
  local leader = teamEntity:Team():GetTeamLeaderEntity()
  local petData = leader:MatchPet():GetMatchPet()
  local hpOffset = petData:GetHPOffset()
  teamRes:SetCreationResultHPOffset(hpOffset)
  local attributesComponent = teamEntity:Attributes()
  local hp = attributesComponent:GetCurrentHP()
  local maxHP = attributesComponent:CalcMaxHp()
  teamRes:SetCreationResultHP(hp)
  teamRes:SetCreationResultMaxHP(maxHP)
  teamRes:SetCreationResultFirstPetEntityID(leader:GetID())
  return teamRes
end

function L2RService:L2RNormalAttackData(normalSkillCalcor, teamEntity)
  if self._world:RunAtServer() then
    return
  end
  local battleSvc = self._world:GetService("Battle")
  local isFinalAtk = battleSvc:IsPlayerTurnFinalAttack()
  local playNormalSkillSequence = normalSkillCalcor:GetPlayNormalSkillSequence()
  local pathTriggerTrapsDic = normalSkillCalcor:GetTriggerTraps()
  local pathNormalSkillWaitTimeDic = normalSkillCalcor:GetPathNormalSkillWaitTimes()
  local pathMoveStartWaitTime = normalSkillCalcor:GetPathMoveStartWaitTime()
  local normalAtkData = self:_CloneNormalAtkData(teamEntity)
  local res = L2R_NormalAttackResult:New()
  res:SetPlayNormalSkillSequence(playNormalSkillSequence)
  res:SetChainPathTriggerTrap(pathTriggerTrapsDic)
  res:SetNormalSkillWaitTimeDic(pathNormalSkillWaitTimeDic)
  res:SetPathMoveStartWaitTime(pathMoveStartWaitTime)
  res:SetPetNormalAttackResultList(normalAtkData)
  res:SetPlayNormalAttackFinalAttack(isFinalAtk)
  self._world:EventDispatcher():Dispatch(GameEventType.DataLogicResult, LogicStepType.NormalAttack, res)
end

function L2RService:_CloneNormalAtkData(teamEntity)
  local normalAttackDataList = {}
  local petRoundTeam = teamEntity:LogicRoundTeam():GetPetRoundTeam()
  for petIndex = 1, #petRoundTeam do
    local petEntityID = petRoundTeam[petIndex]
    local petEntity = self._world:GetEntityByID(petEntityID)
    local petAttackCmpt = petEntity:SkillPetAttackData()
    local normalAtkData = petAttackCmpt:GetNormalAttackData()
    local newData = table_to_class(normalAtkData)
    normalAttackDataList[petEntityID] = newData
  end
  return normalAttackDataList
end

function L2RService:L2RChainAttackData(teamEntity)
  if self._world:RunAtServer() then
    return
  end
  local resultList = {}
  local logicTeamCmpt = teamEntity:LogicRoundTeam()
  local petRoundTeam = logicTeamCmpt:GetPetRoundTeam()
  local roundTeam = {}
  for _, v in ipairs(petRoundTeam) do
    roundTeam[#roundTeam + 1] = v
  end
  for petIndex = 1, #petRoundTeam do
    local petEntityID = petRoundTeam[petIndex]
    local petEntity = self._world:GetEntityByID(petEntityID)
    local petAtkDataCmpt = petEntity:SkillPetAttackData()
    local chainResData = DataChainAttackResult:New()
    resultList[petEntityID] = chainResData
    local atkData = petAtkDataCmpt:GetMultiStageChainAttackDataList()
    local newAtkData = table_to_class(atkData)
    chainResData:SetChainAttackResultAtkDataList(newAtkData)
    local shadowAtkData = petAtkDataCmpt:GetShadowChainAttackDataList()
    local newShadowAtkData = table_to_class(shadowAtkData)
    chainResData:SetChainAttackResultShadowAtkDataList(newShadowAtkData)
    local agentAtkData = petAtkDataCmpt:GetAgentChainAttackDataList()
    local newAgentAtkData = table_to_class(agentAtkData)
    chainResData:SetChainAttackResultAgentAtkDataList(newAgentAtkData)
    local replaceAtkData = petAtkDataCmpt:GetReplaceChainAttackDataList()
    local newReplaceAtkData = table_to_class(replaceAtkData)
    chainResData:SetChainAttackResultReplaceAtkDataList(newReplaceAtkData)
    local deadEntityIds = self:_CalcDeadEntityIDListByPet(petEntityID, #atkData)
    chainResData:SetDeadEntityIDList(deadEntityIds)
    chainResData:SetChainAttackResultCastSkillFlag(petAtkDataCmpt:GetCastChainSkill())
    chainResData:SetChainAttackResultSkillID(petAtkDataCmpt:GetChainSkillID())
  end
  local res = L2R_ChainAttackResult:New(resultList)
  res:SetChainTeamResult(roundTeam)
  self._world:EventDispatcher():Dispatch(GameEventType.DataLogicResult, LogicStepType.ChainAttack, res)
end

function L2RService:_CalcDeadEntityIDListByPet(petEntityID, chainTimes)
  local res = {}
  for chainTimeIdx = 1, chainTimes do
    local list = {}
    local deadGroup = self._world:GetGroup(self._world.BW_WEMatchers.DeadMark)
    for _, e in ipairs(deadGroup:GetEntities()) do
      local deadMarkCmpt = e:DeadMark()
      local chainTimeIndex = deadMarkCmpt:GetChainAttackIndex()
      local chainStageIndex = deadMarkCmpt:GetChainAttackStageIndex()
      if petEntityID == nil then
        if not list[chainStageIndex] then
          list[chainStageIndex] = {}
        end
        table.insert(list[chainStageIndex], e:GetID())
      elseif deadMarkCmpt:GetDeadCasterID() == petEntityID and chainTimeIdx == chainTimeIndex then
        if not list[chainStageIndex] then
          list[chainStageIndex] = {}
        end
        table.insert(list[chainStageIndex], e:GetID())
      end
    end
    res[chainTimeIdx] = list
  end
  return res
end

function L2RService:L2RActiveAttackData(casterEntity, activeSkillID)
  if self._world:RunAtServer() then
    return
  end
  local eid = casterEntity:GetID()
  local res = casterEntity:SkillContext():GetResultContainer()
  local data = L2RActiveAttackResult:New(eid, res)
  data:SetL2RActiveAttackResult_SkillID(activeSkillID)
  self._world:EventDispatcher():Dispatch(GameEventType.DataLogicResult, LogicStepType.ActiveAttack, data)
end

function L2RService:L2RFeatureAttackData(casterEntity, featureSkillID)
  if self._world:RunAtServer() then
    return
  end
  local eid = casterEntity:GetID()
  local res = casterEntity:SkillContext():GetResultContainer()
  local data = L2RFeatureAttackResult:New(eid, res)
  data:SetL2RFeatureAttackResult_SkillID(featureSkillID)
  self._world:EventDispatcher():Dispatch(GameEventType.DataLogicResult, LogicStepType.FeatureAttack, data)
end

function L2RService:L2RAILogicData()
  if self._world:RunAtServer() then
    return
  end
  local recordCmpt = self._world:GetBoardEntity():AIRecorder()
  local res = DataAILogicResult:New(recordCmpt)
  self._world:GetBoardEntity():ReplaceAIRecorder()
  self._world:EventDispatcher():Dispatch(GameEventType.DataLogicResult, 0, res)
end

function L2RService:L2ROneSkillData(casterEntity, key)
  if self._world:RunAtServer() then
    return
  end
  local skillResult = casterEntity:SkillContext():GetResultContainer()
  local data = DataSkillRoutineResult:New(casterEntity:GetID(), skillResult, key)
  self._world:EventDispatcher():Dispatch(GameEventType.DataLogicResult, 0, data)
end

function L2RService:L2RChainPathData(teamEntity)
  if self._world:RunAtServer() then
    return
  end
  local logicChainPathCmpt = teamEntity:LogicChainPath()
  local logicPath = logicChainPathCmpt:GetLogicChainPath()
  local logicElementType = logicChainPathCmpt:GetLogicPieceType()
  local pathRes = {}
  for _, v in ipairs(logicPath) do
    local point = Vector2(v.x, v.y)
    pathRes[#pathRes + 1] = point
  end
  local logicTeamCmpt = teamEntity:LogicRoundTeam()
  local petList = logicTeamCmpt:GetPetRoundTeam()
  local roundTeam = {}
  for _, v in ipairs(petList) do
    roundTeam[#roundTeam + 1] = v
  end
  local cutChainPath = logicChainPathCmpt:GetCutChainPath()
  local cutChainPathRes = {}
  for index, v in pairs(cutChainPath) do
    local point = Vector2(v.x, v.y)
    cutChainPathRes[index] = point
  end
  local pathChainRate = table_to_class(logicChainPathCmpt._pathChainRate)
  local res = DataChainPathResult:New()
  res:SetChainPathResult(pathRes)
  res:SetChainElementResult(logicElementType)
  res:SetChainTeamResult(roundTeam)
  res:SetCutChainPathResult(cutChainPathRes)
  res:SetPathChainRate(pathChainRate)
  self._world:EventDispatcher():Dispatch(GameEventType.DataLogicResult, 0, res)
end

function L2RService:_GetChessPetCreationResult()
  local chessPetCreationSvc = self._world:GetService("ChessPetCreationLogic")
  local chessPetResList = chessPetCreationSvc:GenerateChessPetCreationResult()
  return chessPetResList
end

function L2RService:L2RChessPathData()
  if self._world:RunAtServer() then
    return
  end
  local boardEntity = self._world:GetBoardEntity()
  local logicChessPathComponent = boardEntity:LogicChessPath()
  local chessPath = logicChessPathComponent:GetLogicChessPath()
  local chessPetEntityID = logicChessPathComponent:GetLogicChessPetEntityID()
  local walkResultList = logicChessPathComponent:GetLogicWalkResultList()
  local pickUpPos = logicChessPathComponent:GetLogicPickUpPos()
  local pathRes = {}
  for _, v in ipairs(chessPath) do
    local point = Vector2(v.x, v.y)
    pathRes[#pathRes + 1] = point
  end
  local res = DataChessPathResult:New()
  res:SetChessPathResult(pathRes)
  res:SetChessPetEntityID(chessPetEntityID)
  res:SetChessWalkResultList(walkResultList)
  res:SetChessPickUpPos(pickUpPos)
  self._world:EventDispatcher():Dispatch(GameEventType.DataLogicResult, 0, res)
end

function L2RService:L2RChessAttackData(casterEntity, activeSkillID)
  if self._world:RunAtServer() then
    return
  end
  local eid = casterEntity:GetID()
  local res = casterEntity:SkillContext():GetResultContainer()
  local data = L2RActiveAttackResult:New(eid, res)
  self._world:EventDispatcher():Dispatch(GameEventType.DataLogicResult, LogicStepType.ActiveAttack, data)
end

function L2RService:L2RSanRoundDecrease(curVal, oldVal, modifyValue, debtVal, modifyTimes)
  if self._world:RunAtServer() then
    return
  end
  local data = DataSanRoundDecreaseResult:New(curVal, oldVal, modifyValue, debtVal, modifyTimes)
  self._world:EventDispatcher():Dispatch(GameEventType.DataLogicResult, 0, data)
end

function L2RService:L2RDayNightRoundChange(curState, oldState, restRound)
  if self._world:RunAtServer() then
    return
  end
  local data = DataDayNightRoundChangeResult:New(curState, oldState, restRound)
  self._world:EventDispatcher():Dispatch(GameEventType.DataLogicResult, 0, data)
end

function L2RService:L2RSyncMoveData(entityID, syncMovePath)
  if self._world:RunAtServer() then
    return
  end
  local data = DataSyncMovePathResult:New(entityID, syncMovePath)
  self._world:EventDispatcher():Dispatch(GameEventType.DataLogicResult, 0, data)
end

function L2RService:L2RNTSelectRoundTeamNormalBefore(elementType, chainPath)
  if self._world:RunAtServer() then
    return
  end
  self._world:EventDispatcher():Dispatch(GameEventType.DataRenderNTSelectRoundTeamNormalBefore, elementType, chainPath)
end

function L2RService:L2RMirageWalkData(mirageWalkRes)
  if self._world:RunAtServer() then
    return
  end
  local res = L2RMirageMoveResult:New(mirageWalkRes)
  self._world:EventDispatcher():Dispatch(GameEventType.DataLogicResult, LogicStepType.MirageMove, res)
end

function L2RService:L2RMirageWarningData(warningPosList)
  if self._world:RunAtServer() then
    return
  end
  local res = L2RMirageWarningResult:New(warningPosList)
  self._world:EventDispatcher():Dispatch(GameEventType.DataLogicResult, LogicStepType.MirageWarning, res)
end

function L2RService:L2RPickUpComponentData(entityID, pickUpGridList, directionPickupData, reflectDir, pickUpExtraParam)
  if self._world:RunAtServer() then
    return
  end
  local data = DataPickUpComponentResult:New(entityID, pickUpGridList, directionPickupData, reflectDir, pickUpExtraParam)
  self._world:EventDispatcher():Dispatch(GameEventType.DataLogicResult, 0, data)
end

function L2RService:L2RNTClientUnscaledCountDownFinish(flagID)
  if self._world:RunAtServer() then
    return
  end
  local data = DataUnscaledCountDownFinish:New(flagID)
  self._world:EventDispatcher():Dispatch(GameEventType.DataLogicResult, 0, data)
end

function L2RService:L2RStepPointRoundChange(curVal, oldVal)
  if self._world:RunAtServer() then
    return
  end
  local data = DataStepPointRoundChangeResult:New(curVal, oldVal)
  self._world:EventDispatcher():Dispatch(GameEventType.DataLogicResult, 0, data)
end

function L2RService:L2RStepPointMoveCost(curVal, oldVal)
  if self._world:RunAtServer() then
    return
  end
  local data = DataStepPointMoveCostResult:New(curVal, oldVal)
  self._world:EventDispatcher():Dispatch(GameEventType.DataLogicResult, 0, data)
end

function L2RService:L2RAutoBeadkSkillData(teamEntity)
  if self._world:RunAtServer() then
    return
  end
  local autoBeadServiceLogic = self._world:GetService("AutoBeadLogic")
  local holderEntity = autoBeadServiceLogic:GetAutoBeadSkillHolder(teamEntity)
  if not holderEntity then
    return
  end
  local holderEntityID = holderEntity:GetID()
  local resultList = {}
  local autoBeadAtkDataCmpt = holderEntity:SkillAutoBeadAttackData()
  local autoBeadResData = DataAutoBeadAttackResult:New()
  resultList[holderEntityID] = autoBeadResData
  local atkData = autoBeadAtkDataCmpt:GetAutoBeadAttackDataList()
  autoBeadResData:SetAutoBeadAttackResultAtkDataList(atkData)
  local deadEntityIds = self:_CalcDeadEntityIDListByAutoBead(holderEntityID, #atkData)
  autoBeadResData:SetDeadEntityIDList(deadEntityIds)
  local res = L2R_AutoBeadAttackResult:New(resultList, holderEntityID)
  self._world:EventDispatcher():Dispatch(GameEventType.DataLogicResult, LogicStepType.AutoBeadAttack, res)
end

function L2RService:_CalcDeadEntityIDListByAutoBead(holderEntityID, skillCount)
  local res = {}
  for skillIndex = 1, skillCount do
    local list = {}
    local deadGroup = self._world:GetGroup(self._world.BW_WEMatchers.DeadMark)
    for _, e in ipairs(deadGroup:GetEntities()) do
      local deadMarkCmpt = e:DeadMark()
      local autoBeadSkillIndex = deadMarkCmpt:GetAutoBeadAttackIndex()
      if holderEntityID == nil then
        table.insert(list, e:GetID())
      elseif deadMarkCmpt:GetDeadCasterID() == holderEntityID and skillIndex == autoBeadSkillIndex then
        table.insert(list, e:GetID())
      end
    end
    res[skillIndex] = list
  end
  return res
end

function L2RService:L2RSyncColorPaletteData(entityID)
  if self._world:RunAtServer() then
    return
  end
  self._world:EventDispatcher():Dispatch(GameEventType.DataLogicResult, 0, DataColorPaletteResult:New(entityID))
end
