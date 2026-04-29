_class("ChainSkillCalculator", Object)
ChainSkillCalculator = ChainSkillCalculator

function ChainSkillCalculator:Constructor(world)
  self._world = world
  self._skillLogicService = self._world:GetService("SkillLogic")
  self._configService = self._world:GetService("Config")
  self._targetSelector = world:GetSkillScopeTargetSelector()
  self._skillEffectLogicExecutor = SkillEffectLogicExecutor:New(world)
  self._calcRandDamageSameHalfCalc = SkillEffectCalcRandDamageSameHalf:New(world)
  self._calcSplashPreDamageCalc = SkillEffectCalc_SplashPreDamage:New(world)
  self._damageCanRepeatCalculator = SkillEffectCalc_DamageCanRepeat:New(world)
  self._calcDamageOnTargetCountCalc = SkillEffectCalc_DamageOnTargetCount:New(world)
  self._dynamicCenterDamageCalc = SkillEffectCalc_DynamicCenterDamage:New(world)
  self._generalEffectCalculator = GeneralEffectCalculator:New(world)
end

function ChainSkillCalculator:DoCalculateChainSkill(teamEntity, skillCastPos)
  local ntChainStart = NTChainSkillTurnStart:New(teamEntity)
  self._world:GetService("Trigger"):Notify(ntChainStart)
  local logicTeamCmpt = teamEntity:LogicRoundTeam()
  local petRoundTeam = logicTeamCmpt:GetPetRoundTeam()
  local logicChainPathCmpt = teamEntity:LogicChainPath()
  local chainCount = self:_CalcChainPathRate(teamEntity)
  local chainPath = logicChainPathCmpt:GetLogicChainPath()
  local superGridNum = logicChainPathCmpt:GetSuperGridCountAtPathIndex(#chainPath) or 0
  local poorGridNum = logicChainPathCmpt:GetPoorGridCountAtPathIndex(#chainPath) or 0
  local chainPathPieceType = logicChainPathCmpt:GetLogicPieceType()
  local utilData = self._world:GetService("UtilData")
  local battleService = self._world:GetService("Battle")
  local affixService = self._world:GetService("Affix")
  local chainSkillCnt = 0
  local teamLeaderId = teamEntity:Team():GetTeamLeaderEntityID()
  for petIndex = 1, #petRoundTeam do
    local skillHitbackResultDic = {}
    local petEntityID = petRoundTeam[petIndex]
    local petCanChainAttack = utilData:OnCheckPetCanCastChainSkill(petEntityID)
    if petCanChainAttack ~= false then
      local petEntity = self._world:GetEntityByID(petEntityID)
      if teamLeaderId ~= petEntityID or utilData:IsTeamLeaderCanAttack(teamEntity, chainPathPieceType) then
        local chainCountFix = petEntity:Attributes():GetAttribute("ChainSkillReleaseFix")
        local chainCountMul = petEntity:Attributes():GetAttribute("ChainSkillReleaseMul") or 0
        local finalChainRate = math.ceil((chainCount + chainCountFix) * (1 + chainCountMul))
        self:_CalcOnePetChainSkill(petEntity, skillCastPos, skillHitbackResultDic, finalChainRate, superGridNum, poorGridNum)
        local ret = self:_RefreshPetChainSkillFlag(petEntity)
        if ret then
          chainSkillCnt = chainSkillCnt + 1
        end
      end
    end
  end
  self._world:GetService("Trigger"):Notify(NTChainSkillTurnEnd:New(chainSkillCnt))
end

function ChainSkillCalculator:_CalcChainPathRate(teamEntity)
  local logicChainPathCmpt = teamEntity:LogicChainPath()
  local chainPath = logicChainPathCmpt:GetLogicChainPath()
  return logicChainPathCmpt:GetChainRateAtIndex(#chainPath)
end

function ChainSkillCalculator:_CalcOnePetChainSkill(petEntity, castPos, skillHitbackResultDic, finalChainRate, superGridNum, poorGridNum)
  local sTrigger = self._world:GetService("Trigger")
  local nt = NTChainPathSelectTarget:New()
  nt:SetNotifyEntity(petEntity)
  nt:SetChainCount(finalChainRate)
  sTrigger:Notify(nt)
  local skillInfoComponent = petEntity:SkillInfo()
  local utilData = self._world:GetService("UtilData")
  local chainExtraFix = utilData:GetEntityBuffValue(petEntity, "ChangeExtraChainSkillReleaseFixForSkill")
  local chainSkillID, chainSkillStage = utilData:GetChainSkillByChainCount(petEntity, finalChainRate, chainExtraFix)
  if chainSkillID <= 0 then
    return
  end
  self:_OnSetSkillPetAttackData(petEntity, chainSkillID, chainSkillStage, finalChainRate, superGridNum, poorGridNum)
  self:_CalcFirstChainTimeFrontOfLast(petEntity, castPos, skillHitbackResultDic)
  self:_CalcFirstChainTimeLast(petEntity, castPos, skillHitbackResultDic)
  self:_CalcOtherChainTime(petEntity, castPos, skillHitbackResultDic)
  local ntEachPetChainSkillFinish = NTEachPetChainSkillFinish:New()
  ntEachPetChainSkillFinish:SetNotifyEntity(petEntity)
  ntEachPetChainSkillFinish:SetChainCount(finalChainRate)
  sTrigger:Notify(ntEachPetChainSkillFinish)
end

function ChainSkillCalculator:_OnSetSkillPetAttackData(petEntity, chainSkillID, chainSkillStage, finalChainRate, superGridNum, poorGridNum)
  local petAttackDataCmpt = petEntity:SkillPetAttackData()
  petAttackDataCmpt:SetChainSkillID(chainSkillID)
  petAttackDataCmpt:SetCurChainSkillStage(chainSkillStage)
  petAttackDataCmpt:SetCurrentChainDamageRate(finalChainRate)
  petAttackDataCmpt:SetCurrentSuperGridNum(superGridNum)
  petAttackDataCmpt:SetCurrentPoorGridNum(poorGridNum)
  petAttackDataCmpt:ClearPetChainAttackData()
end

function ChainSkillCalculator:_CalcFirstChainTimeFrontOfLast(petEntity, castPos, skillHitbackResultDic)
  local chainTimeIndex = 1
  local sTrigger = self._world:GetService("Trigger")
  sTrigger:Notify(NTSingleChainSkillAttackBegin:New(petEntity, chainTimeIndex, true))
  local utilData = self._world:GetService("UtilData")
  local petCanMultiStageChainSkill = utilData:OnCheckPetCanMultiStageChainSkill(petEntity)
  if petCanMultiStageChainSkill == false then
    return
  end
  local chainSkillStageInfoList = utilData:OnGetPetChainSkillConfigIDList(petEntity, chainTimeIndex)
  for index = 1, table.count(chainSkillStageInfoList) - 1 do
    if index ~= 1 then
      chainSkillStageInfoList = utilData:OnGetPetChainSkillConfigIDList(petEntity, chainTimeIndex)
    end
    local chainSkillStageInfo = chainSkillStageInfoList[index]
    local chainSkillID = chainSkillStageInfo:GetChainSkillID()
    self:_CalcSingleChainSkill(chainTimeIndex, index, petEntity, castPos, chainSkillID, skillHitbackResultDic)
    self:_CalcAndApplyChainSkillHitback(petEntity, castPos, skillHitbackResultDic, chainTimeIndex, index)
  end
end

function ChainSkillCalculator:_CalcFirstChainTimeLast(petEntity, castPos, skillHitbackResultDic)
  local chainTimeIndex = 1
  local petAttackDataCmpt = petEntity:SkillPetAttackData()
  local finalChainRate = petAttackDataCmpt:GetCurrentChainDamageRate()
  local utilData = self._world:GetService("UtilData")
  local chainSkillStageInfoList = utilData:OnGetPetChainSkillConfigIDList(petEntity, chainTimeIndex)
  local chainStageIndex = table.count(chainSkillStageInfoList)
  local chainSkillID = chainSkillStageInfoList[chainStageIndex]:GetChainSkillID()
  self:_CalcChainSkillScopeOverlap(petEntity, chainSkillID, castPos)
  self:_SaveChainSkillScope(petEntity, chainSkillID, castPos, finalChainRate)
  self:_CalcSingleChainSkill(chainTimeIndex, chainStageIndex, petEntity, castPos, chainSkillID, skillHitbackResultDic)
  self:_ProjectionEntityCastSkill(petEntity, skillHitbackResultDic, chainTimeIndex, chainStageIndex)
  self:_AgentEntityCastSkill(chainTimeIndex, chainStageIndex, petEntity)
  self:_CalcAndApplyChainSkillHitback(petEntity, castPos, skillHitbackResultDic, chainTimeIndex, chainStageIndex)
  self:OnAddDataLogChainSkillEnd(petEntity, chainTimeIndex, chainStageIndex)
  local sTrigger = self._world:GetService("Trigger")
  sTrigger:Notify(NTSingleChainSkillAttackFinish:New(petEntity, chainTimeIndex, chainStageIndex))
end

function ChainSkillCalculator:_CalcOtherChainTime(petEntity, castPos, skillHitbackResultDic)
  local sTrigger = self._world:GetService("Trigger")
  local petAttackDataCmpt = petEntity:SkillPetAttackData()
  local chainSkillID = petAttackDataCmpt:GetChainSkillID()
  local utilData = self._world:GetService("UtilData")
  local castChainSkillCount, extraTime = utilData:OnGetPetChainTimes(petEntity)
  for chainTimeIndex = 2, castChainSkillCount do
    if extraTime and chainTimeIndex == extraTime then
      sTrigger:Notify(NTExtraChainSkillAttackBegin:New(petEntity, chainTimeIndex, true))
    end
    sTrigger:Notify(NTSingleChainSkillAttackBegin:New(petEntity, chainTimeIndex, true))
    local chainSkillStageInfoList = utilData:OnGetPetChainSkillConfigIDList(petEntity, chainTimeIndex)
    local chainStageIndex = table.count(chainSkillStageInfoList)
    self:_CalcSingleChainSkill(chainTimeIndex, chainStageIndex, petEntity, castPos, chainSkillID, skillHitbackResultDic)
    self:_AgentEntityCastSkill(chainTimeIndex, chainStageIndex, petEntity)
    self:_CalcAndApplyChainSkillHitback(petEntity, castPos, skillHitbackResultDic, chainTimeIndex, chainStageIndex)
    self:OnAddDataLogChainSkillEnd(petEntity, chainTimeIndex, chainStageIndex)
    sTrigger:Notify(NTSingleChainSkillAttackFinish:New(petEntity, chainTimeIndex, chainStageIndex))
    if extraTime and chainTimeIndex == extraTime then
      sTrigger:Notify(NTExtraChainSkillAttackFinish:New(petEntity, chainTimeIndex, chainStageIndex))
    end
  end
end

function ChainSkillCalculator:OnAddDataLogChainSkillEnd(petEntity, chainTimeIndex, index)
  local petAttackDataCmpt = petEntity:SkillPetAttackData()
  local attdt = petAttackDataCmpt:GetMultiStageChainAttackData(chainTimeIndex, index)
  if attdt then
    local totalDmg = attdt:GetTotalDamage()
    local chainSkillID = attdt:GetSkillID()
    self._world:GetDataLogger():AddDataLog("OnChainSkillEnd", petEntity, chainSkillID, totalDmg)
  end
end

function ChainSkillCalculator:_SaveChainSkillScope(casterEntity, chainSkillID, castPos, finalChainRate)
  local petBuffCmpt = casterEntity:BuffComponent()
  local saveChainSkillID = petBuffCmpt:GetBuffValue("SavePetChainScope")
  if not saveChainSkillID then
    return
  end
  saveChainSkillID = chainSkillID
  local scopeResultPet = self:CalcChainSkillScope(casterEntity, chainSkillID, castPos)
  local targetListPet = self:_CalcTargetListInScopeResult(casterEntity, scopeResultPet)
  if #targetListPet <= 0 then
    return
  end
  local levelRound = self._world:BattleStat():GetLevelTotalRoundCount()
  local levelRoundAndScopeRange = petBuffCmpt:GetBuffValue("LevelRoundAndScopeRange") or {}
  local lastChainSkillID = levelRoundAndScopeRange[levelRound] or 0
  if lastChainSkillID and saveChainSkillID < lastChainSkillID then
    saveChainSkillID = lastChainSkillID
  end
  levelRoundAndScopeRange[levelRound] = saveChainSkillID
  petBuffCmpt:SetBuffValue("SavePetChainScope", saveChainSkillID)
  petBuffCmpt:SetBuffValue("LevelRoundAndScopeRange", levelRoundAndScopeRange)
  local saveFinalChainRate = finalChainRate
  local levelRoundAndFinalChainRate = petBuffCmpt:GetBuffValue("LevelRoundAndFinalChainRate") or {}
  local lastFinalChainRate = levelRoundAndFinalChainRate[levelRound] or 0
  if lastFinalChainRate and saveFinalChainRate < lastFinalChainRate then
    saveFinalChainRate = lastFinalChainRate
  end
  levelRoundAndFinalChainRate[levelRound] = saveFinalChainRate
  petBuffCmpt:SetBuffValue("SaveFinalChainRate", saveFinalChainRate)
  petBuffCmpt:SetBuffValue("LevelRoundAndFinalChainRate", levelRoundAndFinalChainRate)
end

function ChainSkillCalculator:_CalcChainSkillScopeOverlap(casterEntity, chainSkillID, castPos)
  local petBuffCmpt = casterEntity:BuffComponent()
  local chainScopeOverlapChangeDamage = petBuffCmpt:GetBuffValue("ChainScopeOverlapChangeDamage")
  if not chainScopeOverlapChangeDamage then
    return
  end
  local scopeOverlapList = {}
  petBuffCmpt:SetBuffValue("ChainScopeOverlapPosList", scopeOverlapList)
  local scopeResultPet = self:CalcChainSkillScope(casterEntity, chainSkillID, castPos)
  local targetListPet = self:_CalcTargetListInScopeResult(casterEntity, scopeResultPet)
  if #targetListPet <= 0 then
    return
  end
  local teamEntity = casterEntity:Pet():GetOwnerTeamEntity()
  local logicChainPathCmpt = teamEntity:LogicChainPath()
  local castPosShadow = logicChainPathCmpt:GetChainPathStartPos()
  local scopeResultShadow = self:CalcChainSkillScope(casterEntity, chainSkillID, castPosShadow)
  local targetListShadow = self:_CalcTargetListInScopeResult(casterEntity, scopeResultPet)
  if #targetListShadow <= 0 then
    return
  end
  local hasSameTarget = false
  for _, targetEntityID in ipairs(targetListPet) do
    if table.intable(targetListShadow, targetEntityID) then
      hasSameTarget = true
      break
    end
  end
  if hasSameTarget == false then
    return
  end
  local attackRangePet = scopeResultPet:GetAttackRange()
  local attackRangeShadow = scopeResultShadow:GetAttackRange()
  for _, pos in ipairs(attackRangePet) do
    if table.intable(attackRangeShadow, pos) then
      table.insert(scopeOverlapList, pos)
    end
  end
  petBuffCmpt:SetBuffValue("ChainScopeOverlapPosList", scopeOverlapList)
end

function ChainSkillCalculator:_CalcSingleChainSkill(chainTimeIndex, index, casterEntity, castPos, chainSkillID, skillHitbackResultDic)
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local configService = self._world:GetService("Config")
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local logicChainPathCmpt = teamEntity:LogicChainPath()
  local uniqueBattleStat = self._world:BattleStat()
  uniqueBattleStat:AffixBeginSkillDamageRecord(casterEntity:GetID(), chainSkillID)
  local skillConfigData = configService:GetSkillConfigData(chainSkillID, casterEntity)
  local utilData = self._world:GetService("UtilData")
  skillConfigData = utilData:ProcessChianSkillConfig(skillConfigData, casterEntity)
  local boardEntity = self._world:GetBoardEntity()
  local boardCmpt = boardEntity:Board()
  local buffService = self._world:GetService("BuffLogic")
  if not buffService:IsCanCastChainSkill(casterEntity) then
    return
  end
  if buffService:IsChainSkillUseChainScope(casterEntity) and not self._world:BattleStat():IsCastChainByDimensionDoor() then
    local chainPath = logicChainPathCmpt:GetLogicChainPath()
    local chainPathPieceType = logicChainPathCmpt:GetLogicPieceType()
    boardCmpt:AddTmpPieceType(chainPath[1], PieceType.None)
    for i = 2, #chainPath do
      local pos = chainPath[i]
      boardCmpt:AddTmpPieceType(pos, chainPathPieceType)
    end
  end
  local svcCfgDeco = self._world:GetService("ConfigDecoration")
  local skillEffectArray = svcCfgDeco:GetLatestEffectParamArray(casterEntity:GetID(), chainSkillID)
  local effectType191, effectType203
  for _, effect in ipairs(skillEffectArray) do
    if effect:GetEffectType() == SkillEffectType.DynamicCenterDamage then
      effectType191 = effect
    end
    if effect:GetEffectType() == SkillEffectType.DynamicScopeChainDamage then
      effectType203 = effect
    end
  end
  local scopeResult
  local targetList = {}
  local petBuffCmpt = casterEntity:BuffComponent()
  local replaceChainEntityID = petBuffCmpt:GetBuffValue("ReplaceEntityID")
  local replaceChainEntity = self._world:GetEntityByID(replaceChainEntityID)
  if replaceChainEntity and not replaceChainEntity:HasDeadMark() then
    castPos = replaceChainEntity:GridLocation().Position
  end
  if effectType191 then
    local calc191 = SkillEffectCalc_DynamicCenterDamage:New(self._world)
    targetList, scopeResult = calc191:SelectCenter(casterEntity, effectType191, castPos, chainSkillID)
  elseif effectType203 then
    local calc203 = SkillEffectCalc_DynamicScopeChainDamage:New(self._world)
    scopeResult = calc203:CalcChainReplaceScope(casterEntity, effectType203)
    utilScopeSvc:ExpandMaxChainSkillScope(casterEntity, chainSkillID, scopeResult, castPos)
    targetList = self:_CalcTargetListInScopeResult(casterEntity, scopeResult)
  else
    scopeResult = utilScopeSvc:CalcSkillScope(skillConfigData, castPos, casterEntity)
    utilScopeSvc:ExpandMaxChainSkillScope(casterEntity, chainSkillID, scopeResult, castPos)
    boardCmpt:ClearTmpPieceType()
    targetList = self:_CalcTargetListInScopeResult(casterEntity, scopeResult)
  end
  if #targetList <= 0 then
    return targetList
  end
  local sTrigger = self._world:GetService("Trigger")
  if chainTimeIndex == 2 then
    sTrigger:Notify(NTSecondChainSkillAttackStart:New(casterEntity))
  end
  local petAttackDataCmpt = casterEntity:SkillPetAttackData()
  petAttackDataCmpt:AddMultiStageChainAttackData(chainTimeIndex, index, chainSkillID)
  local chainAttackData = petAttackDataCmpt:GetMultiStageChainAttackData(chainTimeIndex, index)
  chainAttackData:SetSkillID(chainSkillID)
  chainAttackData:SetScopeResult(scopeResult)
  petAttackDataCmpt:SetCurChainSkillTimeIndex(chainTimeIndex)
  local scopeFilterParam = skillConfigData:GetScopeFilterParam()
  local chainSkillStageInfoList = utilData:OnGetPetChainSkillConfigIDList(casterEntity, chainTimeIndex)
  local curChainTimeSkillStageCount = table.count(chainSkillStageInfoList)
  if chainTimeIndex == 1 and index ~= curChainTimeSkillStageCount then
    local calcChainMoveCount = skillConfigData:GetSkillTriggerParam()
    petAttackDataCmpt:SetChainRateList(chainSkillID, calcChainMoveCount)
    local superGridNum = logicChainPathCmpt:GetSuperGridCountAtPathIndex(calcChainMoveCount)
    if superGridNum == nil then
      local pathSuperGridCount = logicChainPathCmpt:GetPathSuperGridCount()
      superGridNum = pathSuperGridCount[#pathSuperGridCount]
    end
    petAttackDataCmpt:SetChainSuperGridNumList(chainSkillID, superGridNum)
    local poorGridNum = logicChainPathCmpt:GetPoorGridCountAtPathIndex(calcChainMoveCount)
    if poorGridNum == nil then
      local pathPoorGridCount = logicChainPathCmpt:GetPathPoorGridCount()
      poorGridNum = pathPoorGridCount[#pathPoorGridCount]
    end
    petAttackDataCmpt:SetChainPoorGridNumList(chainSkillID, poorGridNum)
  end
  self:_CalcChainSkillInScopeResult(casterEntity, castPos, chainAttackData, targetList, skillHitbackResultDic, scopeFilterParam, chainTimeIndex, index)
  local affixRecordSkillDamageTargetCount = uniqueBattleStat:AffixEndSkillDamageRecordAndGetCount(casterEntity:GetID(), chainSkillID)
  Log.info("Skill Record end skill, _CalcOnePetChainSkill chain skillID=", chainSkillID, " casterEntityID=", casterEntity:GetID(), " index=", chainTimeIndex, " targetCount=", affixRecordSkillDamageTargetCount)
  if targetList and 0 < #targetList then
    local petAttackDataCmpt = casterEntity:SkillPetAttackData()
    local finalChainRate = petAttackDataCmpt:GetCurrentChainDamageRate()
    local chainSkillStage = petAttackDataCmpt:GetCurChainSkillStage()
    local nt = NTChainSkillAttackEnd:New(casterEntity, targetList)
    nt:SetChainCount(finalChainRate)
    nt:SetChainSkillTimeIndex(chainTimeIndex)
    nt:SetChainSkillStageIndex(index)
    nt:SetChainSkillId(chainSkillID)
    nt:SetChainSkillStage(chainSkillStage)
    nt:SetSkillDamageTargetCount(affixRecordSkillDamageTargetCount)
    nt:SetPetActiveLinkLineState(self._world:BattleStat():IsActiveSkillLinkLine())
    sTrigger:Notify(nt)
    if chainTimeIndex == 2 then
      sTrigger:Notify(NTSecondChainSkillAttackEnd:New(casterEntity))
    end
  end
  return targetList
end

function ChainSkillCalculator:_CalcTargetListInScopeResult(casterEntity, scopeResult)
  local petAttackDataCmpt = casterEntity:SkillPetAttackData()
  local chainSkillID = petAttackDataCmpt:GetChainSkillID()
  local attackRange = scopeResult:GetAttackRange()
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(chainSkillID, casterEntity)
  local skillTargetType = skillConfigData:GetSkillTargetType()
  local targetEntityIDArray = self._targetSelector:DoSelectSkillTarget(casterEntity, skillTargetType, scopeResult, chainSkillID)
  return targetEntityIDArray
end

function ChainSkillCalculator:_CalcChainSkillInScopeResult(casterEntity, castPos, chainAttackData, targetList, skillHitbackResultDic, scopeFilterParam, chainTimeIndex, chainStageIndex, bAgentChainSkillUseCfgID)
  local petAttackDataCmpt = casterEntity:SkillPetAttackData()
  local chainSkillID = chainAttackData:GetSkillID()
  if bAgentChainSkillUseCfgID == false then
    chainSkillID = petAttackDataCmpt:GetChainSkillID()
  end
  local chainSkillStage = petAttackDataCmpt:GetCurChainSkillStage()
  local scopeResult = chainAttackData:GetScopeResult()
  local battleService = self._world:GetService("Battle")
  local isFinalAttackBeforeSkill = battleService:IsFinalAttack()
  self:_AddTargetToScopeResult(targetList, scopeResult, scopeFilterParam)
  self:_NotifyChainAttackStart(casterEntity, chainAttackData, castPos, chainSkillID, chainSkillStage)
  self:_CalcChainSkillResult(chainSkillID, chainAttackData, casterEntity, skillHitbackResultDic)
  self:_NotifyChainDamageEnd(casterEntity, chainAttackData)
  self:_HandleChainAttackDead(casterEntity:GetID(), chainTimeIndex, chainStageIndex, chainSkillID)
  local isFinalAttack = battleService:IsFinalAttack()
  if not isFinalAttackBeforeSkill and isFinalAttack then
    chainAttackData:SetFinalAttack(true)
  end
end

function ChainSkillCalculator:_AddTargetToScopeResult(targetEntityIDArray, scopeResult, scopeFilterParam)
  local attackRange = scopeResult:GetAttackRange()
  local targetSelectionMode = scopeFilterParam:GetTargetSelectionMode()
  local isTargetSelected = {}
  for _, gridPos in ipairs(attackRange) do
    for _, targetEntityID in ipairs(targetEntityIDArray) do
      if targetSelectionMode ~= SkillTargetSelectionMode.Entity or not isTargetSelected[targetEntityID] then
        local targetEntity = self._world:GetEntityByID(targetEntityID)
        if targetEntity then
          local gridLocationCmpt = targetEntity:GridLocation()
          local bodyAreaCmpt = targetEntity:BodyArea()
          local bodyAreaList = bodyAreaCmpt:GetArea()
          for i, bodyArea in ipairs(bodyAreaList) do
            local curBodyPos = Vector2(gridLocationCmpt.Position.x + bodyArea.x, gridLocationCmpt.Position.y + bodyArea.y)
            if curBodyPos == gridPos then
              scopeResult:AddTargetIDAndPos(targetEntityID, gridPos)
              isTargetSelected[targetEntityID] = true
            end
          end
        end
      end
    end
  end
end

function ChainSkillCalculator:_NotifyChainAttackStart(casterEntity, chainAttackData, castPos, chainSkillId, chainSkillStage)
  local defenderList = {}
  local defendMonsterList = {}
  local attackPosList = {}
  local scopeResult = chainAttackData:GetScopeResult()
  local dic = scopeResult:GetGridPosTargetIDDic()
  if dic == nil then
    return
  end
  for i = 1, dic:Size() do
    local pos, targetEntityID = dic:GetPairAt(i)
    defenderList[#defenderList + 1] = targetEntityID
    attackPosList[#attackPosList + 1] = pos
    local e = self._world:GetEntityByID(targetEntityID)
    if not e:HasTrapID() then
      table.insert(defendMonsterList, targetEntityID)
    end
  end
  if #defenderList <= 0 then
    return
  end
  local triggerSvc = self._world:GetService("Trigger")
  local notifyObj = NTChainSkillAttackStart:New(casterEntity, defenderList, castPos, attackPosList, defendMonsterList)
  notifyObj:SetChainSkillTimeIndex(chainAttackData:GetChainSkillTimeIndex())
  notifyObj:SetChainSkillStageIndex(chainAttackData:GetChainSkillStageIndex())
  notifyObj:SetChainSkillId(chainSkillId)
  notifyObj:SetChainSkillStage(chainSkillStage)
  triggerSvc:Notify(notifyObj)
  local chainSkillAttackNotifyObj = NTChainSkillAttack:New(casterEntity, defenderList, castPos, attackPosList)
  triggerSvc:Notify(chainSkillAttackNotifyObj)
end

function ChainSkillCalculator:_NotifyChainDamageEnd(casterEntity, chainAttackData)
  local damageValue = 0
  local damageResArr = chainAttackData:GetEffectResultsAsArray(SkillEffectType.Damage)
  if damageResArr then
    for _, damageRes in ipairs(damageResArr) do
      damageValue = damageValue + damageRes:GetTotalDamage()
    end
  end
  local petAttackDataCmpt = casterEntity:SkillPetAttackData()
  local finalChainRate = petAttackDataCmpt:GetCurrentChainDamageRate()
  local nt = NTChainSkillDamageEnd:New(casterEntity, damageValue)
  nt:SetChainCount(finalChainRate)
  self._world:GetService("Trigger"):Notify(nt)
  self._world:GetService("Trigger"):Notify(NTAfterPetSkillDamage:New(casterEntity, chainAttackData:GetChainAttackDataSkillID()))
end

function ChainSkillCalculator:_ProjectionEntityCastSkill(casterEntity, skillHitbackResultDic, chainTimeIndex, chainStageIndex)
  local petBuffCmpt = casterEntity:BuffComponent()
  local buffInstance = petBuffCmpt:GetSingleBuffByBuffEffect(BuffEffectType.ShadowChainSKill)
  local buffInstancePro = petBuffCmpt:GetSingleBuffByBuffEffect(BuffEffectType.ShadowChainSKillPro)
  if buffInstance == nil and buffInstancePro == nil then
    return
  end
  if not buffInstance and buffInstancePro then
    buffInstance = buffInstancePro
  end
  local ShadowEntityID = petBuffCmpt:GetBuffValue("ShadowChainEntityID")
  local ShadowEntity = self._world:GetEntityByID(ShadowEntityID)
  if not ShadowEntity then
    return
  end
  local sTrigger = self._world:GetService("Trigger")
  local petAttackDataCmpt = casterEntity:SkillPetAttackData()
  local chainSkillID = petAttackDataCmpt:GetChainSkillID()
  local configSvc = self._world:GetService("Config")
  local skillConfigData = configSvc:GetSkillConfigData(chainSkillID, casterEntity)
  local teamEntity = casterEntity:Pet():GetOwnerTeamEntity()
  local logicChainPathCmpt = teamEntity:LogicChainPath()
  local castPos = logicChainPathCmpt:GetChainPathStartPos()
  casterEntity:SetGridPosition(castPos)
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local scopeResult = self:CalcChainSkillScope(casterEntity, chainSkillID, castPos)
  local attackRange = scopeResult:GetAttackRange()
  local wholeRange = scopeResult:GetWholeGridRange()
  local targetList = self:_CalcTargetListInScopeResult(casterEntity, scopeResult)
  if #targetList <= 0 then
    casterEntity:SetGridPosition(teamEntity:GetGridPosition())
    return
  end
  petBuffCmpt:SetBuffValue("ShadowChainPos", castPos)
  ShadowEntity:SetGridPosition(castPos)
  self._world:EventDispatcher():Dispatch(GameEventType.DataBuffValue, casterEntity:GetID(), "ShadowChainPos", castPos)
  local buffLogicSvc = self._world:GetService("BuffLogic")
  local damagePercent = petBuffCmpt:GetBuffValue("ShadowChainDamagePercent") or 1
  buffLogicSvc:ChangeSkillFinalParam(casterEntity, buffInstance:BuffSeq(), ModifySkillParamType.ChainSkill, damagePercent)
  petAttackDataCmpt:AddChainShadowData(1)
  local chainAttackData = petAttackDataCmpt:GetChainShadowData(1)
  chainAttackData:SetScopeResult(scopeResult)
  chainAttackData:SetSkillID(chainSkillID)
  local scopeFilterParam = skillConfigData:GetScopeFilterParam()
  self:_CalcChainSkillInScopeResult(casterEntity, castPos, chainAttackData, targetList, skillHitbackResultDic, scopeFilterParam, chainTimeIndex, chainStageIndex)
  casterEntity:SetGridPosition(teamEntity:GetGridPosition())
  buffLogicSvc:RemoveSkillFinalParam(casterEntity, buffInstance:BuffSeq(), ModifySkillParamType.ChainSkill, damagePercent, scopeFilterParam)
end

function ChainSkillCalculator:_AgentEntityCastSkill(chainTimeIndex, chainStageIndex, casterEntity)
  local petBuffCmpt = casterEntity:BuffComponent()
  local agentChainEntityID = petBuffCmpt:GetBuffValue("AgentChainEntityID")
  local agentChainEntity = self._world:GetEntityByID(agentChainEntityID)
  if not agentChainEntity then
    return
  end
  if agentChainEntity:HasDeadMark() then
    return
  end
  local sTrigger = self._world:GetService("Trigger")
  local chainCountMultiple = petBuffCmpt:GetBuffValue("AgentChainCountMultiple")
  local AgentChainSkillList = petBuffCmpt:GetBuffValue("AgentChainSkillList")
  local agentChainSkillUseCfgID = petBuffCmpt:GetBuffValue("AgentChainSkillUseCfgID") or 0
  local teamEntity = casterEntity:Pet():GetOwnerTeamEntity()
  local logicChainPathCmpt = teamEntity:LogicChainPath()
  local chain_path_data = logicChainPathCmpt:GetLogicChainPath()
  local chain_path_count = table.count(chain_path_data)
  local realChainCount = chain_path_count - 1
  if realChainCount == 0 then
    return
  end
  local chainSkillID = 0
  for i = 1, #AgentChainSkillList do
    if realChainCount >= AgentChainSkillList[i].chainCount then
      chainSkillID = AgentChainSkillList[i].skill
      break
    end
  end
  if chainSkillID <= 0 then
    return
  end
  Log.fatal("Calc ChainSkill Agent Skill:", chainSkillID)
  local configSvc = self._world:GetService("Config")
  local skillConfigData = configSvc:GetSkillConfigData(chainSkillID, casterEntity)
  local castPos = agentChainEntity:GridLocation().Position
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local scopeResult = self:CalcChainSkillScope(casterEntity, chainSkillID, castPos)
  local attackRange = scopeResult:GetAttackRange()
  local wholeRange = scopeResult:GetWholeGridRange()
  local targetList = self:_CalcTargetListInScopeResult(casterEntity, scopeResult)
  local petAttackDataCmpt = casterEntity:SkillPetAttackData()
  petAttackDataCmpt:AddChainAgentData(chainTimeIndex)
  local chainAttackData = petAttackDataCmpt:GetChainAgentData(chainTimeIndex)
  chainAttackData:SetScopeResult(scopeResult)
  chainAttackData:SetSkillID(chainSkillID)
  local scopeFilterParam = skillConfigData:GetScopeFilterParam()
  local bAgentChainSkillUseCfgID = agentChainSkillUseCfgID == 1
  self:_CalcChainSkillInScopeResult(casterEntity, castPos, chainAttackData, targetList, {}, scopeFilterParam, chainTimeIndex, chainStageIndex, bAgentChainSkillUseCfgID)
end

function ChainSkillCalculator:_CalcChainSkillResult(chainSkillID, attdata, petEntity, skillHitbackResultDic)
  local petEntityID = petEntity:GetID()
  local effectCalcService = self._world:GetService("SkillEffectCalc")
  local scopeResult = attdata:GetScopeResult()
  local dic = scopeResult:GetGridPosTargetIDDic()
  if not dic then
    return
  end
  local skillResult = petEntity:SkillContext():GetResultContainer()
  skillResult:Clear()
  skillResult:SetSkillID(chainSkillID)
  scopeResult:ClearTargetIDs()
  local configService = self._configService
  local skillConfigData = configService:GetSkillConfigData(chainSkillID, petEntity)
  local targetType = skillConfigData:GetSkillTargetType()
  local targetEntityIDArray = self._targetSelector:DoSelectSkillTarget(petEntity, targetType, scopeResult, chainSkillID)
  if targetEntityIDArray then
    for _, v in ipairs(targetEntityIDArray) do
      local targetEntity = self._world:GetEntityByID(v)
      local pos
      if targetEntity:GridLocation() then
        pos = targetEntity:GridLocation().Position
      else
        pos = Vector2(0, 0)
      end
      scopeResult:AddTargetIDAndPos(v, pos)
    end
  end
  skillResult:SetScopeResult(scopeResult)
  local attackPos = scopeResult:GetCenterPos()
  local attackRange = scopeResult:GetAttackRange()
  local logger = self._world:GetMatchLogger()
  logger:BeginSkill(petEntityID, attackPos, chainSkillID, attackRange)
  local skillEffectResultArray = self:_CalcAndApplyChainSkillEffect(attdata, skillHitbackResultDic, petEntityID, chainSkillID, attackPos)
  logger:EndSkill(petEntityID)
end

function ChainSkillCalculator:_CalcAndApplyChainSkillEffect(chainAttackData, skillHitbackResultDic, petEntityID, chainSkillID, attackPos)
  local effectCalcService = self._world:GetService("SkillEffectCalc")
  local svcCfgDeco = self._world:GetService("ConfigDecoration")
  local skillEffectArray = svcCfgDeco:GetLatestEffectParamArray(petEntityID, chainSkillID)
  for skillEffectIndex = 1, #skillEffectArray do
    local skillEffectParam = skillEffectArray[skillEffectIndex]
    if skillEffectParam:GetEffectType() == SkillEffectType.RandDamageSameHalf then
      local scopeResult = self:_CalcSkillEffectChildScope(chainAttackData, skillEffectParam, petEntityID, chainSkillID, attackPos)
      self:_CalcAndApplyChainSkillEffect_RandDamageSameHalf(chainAttackData, skillHitbackResultDic, petEntityID, chainSkillID, attackPos, skillEffectParam, scopeResult)
    elseif skillEffectParam:GetEffectType() == SkillEffectType.SplashPreDamage then
      local scopeResult = self:_CalcSkillEffectChildScope(chainAttackData, skillEffectParam, petEntityID, chainSkillID, attackPos)
      self:_CalcAndApplyChainSkillEffect_SplashPreDamage(chainAttackData, skillHitbackResultDic, petEntityID, chainSkillID, attackPos, skillEffectParam, scopeResult)
    elseif skillEffectParam:GetEffectType() == SkillEffectType.DamageTargetCanRepeat then
      local scopeResult = self:_CalcSkillEffectChildScope(chainAttackData, skillEffectParam, petEntityID, chainSkillID, attackPos)
      local casterEntity = self._world:GetEntityByID(petEntityID)
      local results = self._damageCanRepeatCalculator:CalculateEffect(casterEntity, skillEffectParam, chainSkillID)
      local skillEffectCalcParam = SkillEffectCalcParam:New(petEntityID, {}, skillEffectParam, chainSkillID, scopeResult:GetAttackRange(), attackPos)
      for _, result in ipairs(results) do
        result:SetSkillEffectScopeResult(scopeResult)
        self:_OnApplyChainSkillEffectResult(skillEffectCalcParam, result, chainAttackData, skillHitbackResultDic)
      end
    elseif skillEffectParam:GetEffectType() == SkillEffectType.DamageOnTargetCount then
      local scopeResult = self:_CalcSkillEffectChildScope(chainAttackData, skillEffectParam, petEntityID, chainSkillID, attackPos)
      self:_CalcAndApplyChainSkillEffect_DamageOnTargetCount(chainAttackData, skillHitbackResultDic, petEntityID, chainSkillID, attackPos, skillEffectParam, scopeResult)
    elseif skillEffectParam:GetEffectType() == SkillEffectType.DynamicCenterDamage then
      local scopeResult = self:_CalcSkillEffectChildScope(chainAttackData, skillEffectParam, petEntityID, chainSkillID, attackPos)
      self:_CalcAndApplyChainSkillEffect_DynamicCenterDamage(chainAttackData, skillHitbackResultDic, petEntityID, chainSkillID, attackPos, skillEffectParam, scopeResult)
    else
      local casterEntity = self._world:GetEntityByID(petEntityID)
      local skillConfigData = self._configService:GetSkillConfigData(chainSkillID, casterEntity)
      local scopeFilterParam = skillConfigData:GetScopeFilterParam()
      local skillEffectType = skillEffectParam:GetEffectType()
      local effectScopeFilterParam = skillEffectParam:GetScopeFilterParam()
      local finalScopeFilterParam = effectScopeFilterParam:IsDefault() and scopeFilterParam or effectScopeFilterParam
      local petEntity = self._world:GetEntityByID(petEntityID)
      local chainIndex = chainAttackData:GetChainSkillTimeIndex()
      if skillEffectParam.SetChainIndex then
        skillEffectParam:SetChainIndex(chainIndex)
      end
      local resultArray = self._generalEffectCalculator:DoGeneralEffectCalc(petEntity, skillEffectParam, finalScopeFilterParam)
      for _, result in ipairs(resultArray) do
        local scopeResult = result:GetSkillEffectScopeResult()
        local targetIDs = scopeResult:GetTargetIDs()
        local skillEffectCalcParam = SkillEffectCalcParam:New(petEntityID, targetIDs, skillEffectParam, chainSkillID, scopeResult:GetAttackRange(), attackPos)
        self:_OnApplyChainSkillEffectResult(skillEffectCalcParam, result, chainAttackData, skillHitbackResultDic)
      end
    end
  end
  effectCalcService:ResetSkillContext(petEntityID)
end

function ChainSkillCalculator:_CalcAndApplyChainSkillEffect_RandDamageSameHalf(chainAttackData, skillHitbackResultDic, petEntityID, chainSkillID, attackPos, skillEffectParam, scopeResult)
  local targetIDs = scopeResult:GetTargetIDs()
  local skillEffectCalcParam = SkillEffectCalcParam:New(petEntityID, targetIDs, skillEffectParam, chainSkillID, scopeResult:GetAttackRange(), attackPos)
  local skillResult = self._calcRandDamageSameHalfCalc:DoSkillEffectCalculator(skillEffectCalcParam)
  local attacker = self._world:GetEntityByID(skillEffectCalcParam.casterEntityID)
  local skillEffectResultContainer = attacker:SkillContext():GetResultContainer()
  for _, v in ipairs(skillResult) do
    skillEffectResultContainer:AddEffectResult(v)
  end
  for _, result in ipairs(skillResult) do
    result:SetSkillEffectScopeResult(scopeResult)
    self:_OnApplyChainSkillEffectResult(skillEffectCalcParam, result, chainAttackData, skillHitbackResultDic)
  end
end

function ChainSkillCalculator:_CalcAndApplyChainSkillEffect_SplashPreDamage(chainAttackData, skillHitbackResultDic, petEntityID, chainSkillID, attackPos, skillEffectParam, scopeResult)
  local targetIDs = scopeResult:GetTargetIDs()
  local skillEffectCalcParam = SkillEffectCalcParam:New(petEntityID, targetIDs, skillEffectParam, chainSkillID, scopeResult:GetAttackRange(), attackPos)
  local skillResult = self._calcSplashPreDamageCalc:DoSkillEffectCalculator(skillEffectCalcParam)
  for _, result in ipairs(skillResult) do
    result:SetSkillEffectScopeResult(scopeResult)
    self:_OnApplyChainSkillEffectResult(skillEffectCalcParam, result, chainAttackData, skillHitbackResultDic)
  end
end

function ChainSkillCalculator:_CalcSkillEffectChildScope(chainAttackData, skillEffectParam, petEntityID, chainSkillID, attackPos)
  local scopeType = skillEffectParam:GetSkillEffectScopeType()
  if not scopeType then
    local scopeResult = chainAttackData:GetScopeResult()
    return scopeResult
  end
  local attacker = self._world:GetEntityByID(petEntityID)
  local casterEntity = attacker
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local scopeResult = utilScopeSvc:CalcSkillEffectScopeResult(skillEffectParam, attackPos, attacker)
  local skillEffectTargetType = skillEffectParam:GetSkillEffectTargetType()
  local filterParam = skillEffectParam:GetScopeFilterParam()
  local skillEffectTargetTypeParam = skillEffectParam:GetSkillEffectTargetTypeParam()
  local targetSelectionMode = filterParam:GetTargetSelectionMode()
  local targetIDList = utilScopeSvc:SelectSkillTarget(attacker, skillEffectTargetType, scopeResult, nil, skillEffectTargetTypeParam)
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(chainSkillID, casterEntity)
  local scopeFilterParam = skillConfigData:GetScopeFilterParam()
  self:_AddTargetToScopeResult(targetIDList, scopeResult, scopeFilterParam)
  return scopeResult
end

function ChainSkillCalculator:_OnApplyChainSkillEffectResult(skillEffectCalcParam, skillResult, chainAttackData, skillHitbackResultDic)
  local petEntityID = skillEffectCalcParam.casterEntityID
  local petEntity = self._world:GetEntityByID(skillEffectCalcParam.casterEntityID)
  local chainIndex = chainAttackData:GetChainSkillTimeIndex()
  local skillEffectType = skillResult:GetEffectType()
  local trapServiceLogic = self._world:GetService("TrapLogic")
  if skillEffectType ~= SkillEffectType.HitBack then
    chainAttackData:AddEffectResult(skillResult)
  end
  local skillEffectType = skillResult:GetEffectType()
  if skillEffectType == SkillEffectType.Damage or skillEffectType == SkillEffectType.DamageTargetCanRepeat then
    local skillDamageEffectResult = skillResult
    local castDamage = skillDamageEffectResult:GetTotalDamage()
    local damageInfoArray = skillDamageEffectResult:GetDamageInfoArray()
    if not damageInfoArray or table.count(damageInfoArray) == 0 then
      return
    end
    for _, v in ipairs(damageInfoArray) do
      local targetEntityId = v:GetTargetEntityID()
      if targetEntityId then
        v:SetAttackerEntityID(petEntity:GetID())
        local targetEntity = self._world:GetEntityByID(targetEntityId)
        trapServiceLogic:AddTrapDeadMark(targetEntity)
      end
    end
  elseif skillEffectType == SkillEffectType.SplashDamage then
    local splashResult = skillResult
    local damageResults = splashResult:GetDamageResults()
    for _, damageResult in ipairs(damageResults) do
      local tDamageInfo = damageResult:GetDamageInfoArray()
      for __, damageInfo in ipairs(tDamageInfo) do
        damageInfo:SetAttackerEntityID(petEntity:GetID())
        local targetEntityId = damageInfo:GetTargetEntityID()
        local targetEntity = self._world:GetEntityByID(targetEntityId)
        if targetEntity then
          trapServiceLogic:AddTrapDeadMark(targetEntity)
        end
      end
    end
  elseif skillEffectType == SkillEffectType.HitBack then
    local delayHitbackEffectRes = skillResult
    local petHasAttack = table.iskey(skillHitbackResultDic, petEntityID)
    if petHasAttack == true then
      local hitbackResArray = skillHitbackResultDic[petEntityID]
      hitbackResArray[#hitbackResArray + 1] = delayHitbackEffectRes
    else
      local hitbackResArray = {}
      hitbackResArray[#hitbackResArray + 1] = delayHitbackEffectRes
      skillHitbackResultDic[petEntityID] = hitbackResArray
    end
    local hitbackTargetID = delayHitbackEffectRes:GetTargetID()
    local targetEntity = self._world:GetEntityByID(hitbackTargetID)
    if targetEntity:HasTrap() then
      local trapCmpt = targetEntity:Trap()
      if trapCmpt:GetTrapType() == TrapType.BombByHitBack then
        trapCmpt:SetBombSelected(true)
      end
    end
  elseif skillEffectType == SkillEffectType.AddBlood then
    local skillAddBloodEffectResult = skillResult
    if 1 < chainIndex then
      local addblood = skillAddBloodEffectResult:GetAddValue()
      local rate = petEntity:BuffComponent():GetBuffValue("DoubleChainRate") or 1
      addblood = addblood * rate
      skillAddBloodEffectResult:SetAddValue(addblood)
    end
    self._skillEffectLogicExecutor:EachApplyAddBlood(petEntity, skillAddBloodEffectResult, SkillType.Chain)
  elseif skillEffectType == SkillEffectType.ChangeBuffLayer then
    local buffLogicService = self._world:GetService("BuffLogic")
    local result = skillResult
    local entityID = result:GetEntityID()
    local entity = self._world:GetEntityByID(entityID)
    local buffEffectType = result:GetTargetBuffEffectType()
    local layerCount = result:GetLayer()
    buffLogicService:SetBuffLayer(entity, buffEffectType, layerCount)
    if result:GetIsUnload() and layerCount == 0 then
      local targetBuff = entity:BuffComponent():GetSingleBuffByBuffEffect(buffEffectType)
      if targetBuff then
        targetBuff:Unload(NTBuffUnload:New())
      end
    end
  elseif skillEffectType == SkillEffectType.MoveTrap then
    local result = skillResult
    local entityID = result:GetEntityID()
    local entity = self._world:GetEntityByID(entityID)
    local posOld = result:GetPosOld()
    local posNew = result:GetPosNew()
    entity:SetGridLocation(posNew)
    local sBoard = self._world:GetService("BoardLogic")
    sBoard:UpdateEntityBlockFlag(entity, posOld, posNew)
  elseif skillEffectType == SkillEffectType.EachTrapAddBlood then
    local skillAddBloodEffectResult = skillResult
    self._skillEffectLogicExecutor:EachApplyAddBlood(petEntity, skillAddBloodEffectResult, SkillType.Chain)
  elseif skillEffectType == SkillEffectType.DestroyTrap then
    local skillDestroyTrapEffectResult = {}
    table.insert(skillDestroyTrapEffectResult, skillResult)
    self._skillEffectLogicExecutor:_ApplyDestroyTrap(petEntity, skillEffectCalcParam:GetSkillEffectParam(), skillDestroyTrapEffectResult)
  elseif skillEffectType == SkillEffectType.SummonTrap then
    local t = {}
    table.insert(t, skillResult)
    self._skillEffectLogicExecutor:_ApplySummonTrap(petEntity, skillEffectCalcParam:GetSkillEffectParam(), t)
  elseif skillEffectType == SkillEffectType.LevelTrapUpLevel then
    local t = {}
    table.insert(t, skillResult)
    self._skillEffectLogicExecutor:_ApplyLevelTrapUpLevel(petEntity, skillEffectCalcParam:GetSkillEffectParam(), t)
  elseif skillEffectType == SkillEffectType.DetonateMonsterWeak then
    local t = {}
    table.insert(t, skillResult)
    self._skillEffectLogicExecutor:_ApplyDetonateMonsterWeak(petEntity, skillEffectCalcParam:GetSkillEffectParam(), t)
  else
    self._skillEffectLogicExecutor:ApplySkillEffect(petEntity, skillEffectCalcParam:GetSkillEffectParam(), {skillResult})
    Log.error("_OnApplyChainSkillEffectResult unexcept skill effect: ", skillEffectType)
  end
end

function ChainSkillCalculator:_SetEffectResultScopeResult(skillEffectResultArray, scopeResult)
  if not skillEffectResultArray then
    return
  end
  for _, skillEffectResult in ipairs(skillEffectResultArray) do
    skillEffectResult:SetSkillEffectScopeResult(scopeResult)
  end
end

function ChainSkillCalculator:_CalcSkillDelayHitback(skillCastPos, skillHitbackResultDic)
  local hitbackVictimDic = {}
  for _, v in pairs(skillHitbackResultDic) do
    for _, arrayElement in ipairs(v) do
      local delayHitbackEffectRes = arrayElement
      local victimEntityID = delayHitbackEffectRes:GetTargetID()
      local victimEntity = self._world:GetEntityByID(victimEntityID)
      if victimEntity ~= nil and not victimEntity:HasDeadMark() then
        local hasVictim = table.iskey(hitbackVictimDic, victimEntityID)
        if hasVictim == true then
          local hitbackArray = hitbackVictimDic[victimEntityID]
          hitbackArray[#hitbackArray + 1] = delayHitbackEffectRes
        else
          local hitbackArray = {}
          hitbackArray[#hitbackArray + 1] = delayHitbackEffectRes
          hitbackVictimDic[victimEntityID] = hitbackArray
        end
      end
    end
  end
  for targetID, targetHitBackResult in pairs(hitbackVictimDic) do
    local minDistance = 99
    for _, hitBackResult in ipairs(targetHitBackResult) do
      local targetToCasterDistance = hitBackResult:GetAttackDistance()
      if minDistance > hitBackResult:GetAttackDistance() then
        minDistance = targetToCasterDistance
      end
    end
    local tmpResult = {}
    for _, hitBackResult in ipairs(targetHitBackResult) do
      local targetToCasterDistance = hitBackResult:GetAttackDistance()
      if targetToCasterDistance == minDistance then
        table.insert(tmpResult, hitBackResult)
      end
    end
    hitbackVictimDic[targetID] = tmpResult
  end
  local victimIDArray = table.keys(hitbackVictimDic)
  local hitbackResultDic = {}
  for _, victimEntityID in ipairs(victimIDArray) do
    local hitbackArray = hitbackVictimDic[victimEntityID]
    local hitbackRes = self:_CalcOneActorHitback(victimEntityID, hitbackArray)
    hitbackResultDic[victimEntityID] = hitbackRes
  end
  return hitbackResultDic
end

function ChainSkillCalculator:_CalcOneActorHitback(victimEntityID, hitbackArray)
  local maxDistance = 0
  for _, v in ipairs(hitbackArray) do
    local delayHitbackEffectRes = v
    local hitbackDis = delayHitbackEffectRes:GetHitbackDistance()
    if maxDistance < hitbackDis then
      maxDistance = hitbackDis
    end
  end
  local maxPowerHitbackArray = {}
  for _, v in ipairs(hitbackArray) do
    local delayHitbackEffectRes = v
    local hitbackDis = delayHitbackEffectRes:GetHitbackDistance()
    if hitbackDis == maxDistance then
      maxPowerHitbackArray[#maxPowerHitbackArray + 1] = delayHitbackEffectRes
    end
  end
  local hitbackCalcRes
  local effectCalcService = self._world:GetService("SkillEffectCalc")
  local delayHitbackResult = maxPowerHitbackArray[1]
  local casterEntityID = delayHitbackResult:GetCasterEntityID()
  local attacker = self._world:GetEntityByID(casterEntityID)
  local attackerBodyArea = attacker:BodyArea()
  local victimEntityID = delayHitbackResult:GetTargetID()
  local dirType = delayHitbackResult:GetHitbackDirType()
  local pullType = HitBackType.PushAway
  local hitbackDis = delayHitbackResult:GetHitbackDistance()
  local skillCastPos = delayHitbackResult:GetCasterPos()
  local orderArray = {}
  if 1 < #maxPowerHitbackArray then
    for targetID, hitBackResult in ipairs(maxPowerHitbackArray) do
      local upRes = self:_FindHitbackByDir(hitBackResult:GetCasterPos(), HitBackDirectionType.Up, {hitBackResult})
      if upRes ~= nil then
        orderArray[#orderArray + 1] = upRes
      end
      local rightRes = self:_FindHitbackByDir(hitBackResult:GetCasterPos(), HitBackDirectionType.Right, {hitBackResult})
      if rightRes ~= nil then
        orderArray[#orderArray + 1] = rightRes
      end
      local downRes = self:_FindHitbackByDir(hitBackResult:GetCasterPos(), HitBackDirectionType.Down, {hitBackResult})
      if downRes ~= nil then
        orderArray[#orderArray + 1] = downRes
      end
      local leftRes = self:_FindHitbackByDir(hitBackResult:GetCasterPos(), HitBackDirectionType.Left, {hitBackResult})
      if leftRes ~= nil then
        orderArray[#orderArray + 1] = leftRes
      end
    end
    local orderArraySize = #orderArray
    if 1 < orderArraySize then
      local firstDirType = orderArray[1]:GetHitbackDirType()
      local secondDirType = orderArray[2]:GetHitbackDirType()
      dirType = HitBackDirectionTypeHelper.OverlapHitbackDir(firstDirType, secondDirType)
      local bodyArea = orderArray[1]:GetTargetBodyArea():GetArea()
      if 1 < #bodyArea then
        local dirEight = HitBackDirectionTypeHelper.ConvertDirTypeToVectorEight(dirType)
        local targetLocationCenter = orderArray[1]:GetTargetLocationCenter()
        local hitBackPos = Vector2(math.ceil(targetLocationCenter.x - dirEight.x / 2), math.ceil(targetLocationCenter.y - dirEight.y / 2))
        skillCastPos = hitBackPos - dirEight
      end
    elseif orderArraySize == 1 then
      dirType = orderArray[1]:GetHitbackDirType()
      skillCastPos = orderArray[1]:GetCasterPos()
    elseif orderArraySize == 0 then
      dirType = maxPowerHitbackArray[1]:GetHitbackDirType()
      skillCastPos = maxPowerHitbackArray[1]:GetCasterPos()
    end
  end
  local calcType = HitBackCalcType.Delay
  hitbackCalcRes = effectCalcService:CalcHitbackEffectResult(skillCastPos, Vector2.zero, attackerBodyArea, victimEntityID, dirType, pullType, hitbackDis, calcType, false, false, attacker)
  return hitbackCalcRes
end

function ChainSkillCalculator:_FindHitbackByDir(skillCastPos, dirTypeParam, maxPowerHitbackArray)
  for _, v in ipairs(maxPowerHitbackArray) do
    local hitbackRes = v
    local curDir = hitbackRes:GetHitbackDirType()
    local victimPos = hitbackRes:GetGridPos()
    local victimDir = Vector2.Normalize(victimPos - skillCastPos)
    local victimDirType
    if curDir == dirTypeParam then
      return hitbackRes
    elseif curDir == HitBackDirectionType.EightDir then
      if victimDir.x == 0 then
        if 0 < victimDir.y then
          victimDirType = HitBackDirectionType.Up
        elseif 0 > victimDir.y then
          victimDirType = HitBackDirectionType.Down
        end
      elseif victimDir.y == 0 then
        if victimDir.x > 0 then
          victimDirType = HitBackDirectionType.Right
        elseif victimDir.x < 0 then
          victimDirType = HitBackDirectionType.Left
        end
      end
      if victimDirType ~= nil and victimDirType == dirTypeParam then
        hitbackRes:SetHitbackDirType(victimDirType)
        return hitbackRes
      end
    elseif curDir == HitBackDirectionType.LeftRight then
      if skillCastPos.x > victimPos.x then
        victimDirType = HitBackDirectionType.Left
      else
        victimDirType = HitBackDirectionType.Right
      end
      if victimDirType ~= nil and victimDirType == dirTypeParam then
        hitbackRes:SetHitbackDirType(victimDirType)
        return hitbackRes
      end
    elseif curDir == HitBackDirectionType.UpDown then
      if skillCastPos.y > victimPos.y then
        victimDirType = HitBackDirectionType.Down
      else
        victimDirType = HitBackDirectionType.Up
      end
      if victimDirType ~= nil and victimDirType == dirTypeParam then
        hitbackRes:SetHitbackDirType(victimDirType)
        return hitbackRes
      end
    end
  end
  return nil
end

function ChainSkillCalculator:_RemoveDeadTargetFromChainAttackData(removeStartIndex, chainAttackDataList)
  for index = removeStartIndex, #chainAttackDataList do
    local chainAttackData = chainAttackDataList[index]
    local deadTargetPosList = {}
    local scopeResult = chainAttackData:GetScopeResult()
    local targetDic = scopeResult:GetGridPosTargetIDDic()
    if targetDic ~= nil then
      for i = 1, targetDic:Size() do
        local pos, targetEntityID = targetDic:GetPairAt(i)
        local defenderEntity = self._world:GetEntityByID(targetEntityID)
        if defenderEntity ~= nil and defenderEntity:HasAttributes() then
          local curHp = defenderEntity:Attributes():GetCurrentHP()
          if curHp ~= nil then
            if curHp <= 0 then
              table.insert(deadTargetPosList, pos)
            end
          elseif defenderEntity:HasTrap() then
            local trapCmpt = defenderEntity:Trap()
            if trapCmpt:GetTrapType() == TrapType.BombByHitBack then
              local hasSelected = trapCmpt:IsBombSelected()
              if hasSelected then
                table.insert(deadTargetPosList, pos)
              end
            end
          end
        else
          table.insert(deadTargetPosList, pos)
        end
      end
    end
    for _, v in ipairs(deadTargetPosList) do
      scopeResult:RemoveTargetIDByPos(v)
    end
  end
end

function ChainSkillCalculator:_RefreshPetChainSkillFlag(petEntity)
  local petAttackDataCmpt = petEntity:SkillPetAttackData()
  petAttackDataCmpt:SetCastChainSkill(false)
  local multiStageChainAttackDataList = petAttackDataCmpt:GetMultiStageChainAttackDataList()
  local recordChianAtkTimes = 0
  for _, chainAttackData in ipairs(multiStageChainAttackDataList) do
    for _, attdata in pairs(chainAttackData) do
      local scopeResult = attdata:GetScopeResult()
      local targetDic = scopeResult:GetGridPosTargetIDDic()
      if targetDic ~= nil then
        local targetCount = targetDic:Size()
        if 0 < targetCount then
          recordChianAtkTimes = recordChianAtkTimes + 1
          petAttackDataCmpt:SetCastChainSkill(true)
        end
      end
    end
  end
  local recordShadowChianAtkTimes = 0
  local shadowChainAttackData = petAttackDataCmpt:GetChainShadowData()
  if shadowChainAttackData then
    for _, attdata in ipairs(shadowChainAttackData) do
      local scopeResult = attdata:GetScopeResult()
      local targetDic = scopeResult:GetGridPosTargetIDDic()
      if targetDic ~= nil then
        local targetCount = targetDic:Size()
        if 0 < targetCount then
          recordShadowChianAtkTimes = recordShadowChianAtkTimes + 1
          petAttackDataCmpt:SetCastChainSkill(true)
        end
      end
    end
  end
  local agentShadowChianAtkTimes = 0
  local agentChainAttackData = petAttackDataCmpt:GetChainAgentData()
  if agentChainAttackData then
    for _, attdata in ipairs(agentChainAttackData) do
      local scopeResult = attdata:GetScopeResult()
      local targetDic = scopeResult:GetGridPosTargetIDDic()
      if targetDic ~= nil then
        local targetCount = targetDic:Size()
        if 0 < targetCount then
          agentShadowChianAtkTimes = agentShadowChianAtkTimes + 1
          petAttackDataCmpt:SetCastChainSkill(true)
        end
      end
    end
  end
  local replaceChainAtkTimes = 0
  local replaceChainAttackData = petAttackDataCmpt:GetChainReplaceData()
  if replaceChainAttackData then
    for _, attdata in ipairs(replaceChainAttackData) do
      local scopeResult = attdata:GetScopeResult()
      local targetDic = scopeResult:GetGridPosTargetIDDic()
      if targetDic ~= nil then
        local targetCount = targetDic:Size()
        if 0 < targetCount then
          replaceChainAtkTimes = replaceChainAtkTimes + 1
          petAttackDataCmpt:SetCastChainSkill(true)
        end
      end
    end
  end
  local l_bCastChainSkill = petAttackDataCmpt:GetCastChainSkill()
  if l_bCastChainSkill then
    local l_battlestat = self._world:BattleStat()
    if petEntity:HasPet() then
      local teamEntity = petEntity:Pet():GetOwnerTeamEntity()
      local minTimes = 1
      local recordTimes = math.max(minTimes, recordChianAtkTimes, recordShadowChianAtkTimes, agentShadowChianAtkTimes, replaceChainAtkTimes)
      l_battlestat:AddChainSkillCount(teamEntity, recordTimes)
    end
  end
  return l_bCastChainSkill
end

function ChainSkillCalculator:_HandleChainAttackDead(casterEntityID, chainTimeIndex, chainStageIndex, chainSkillID)
  local sMonsterShowLogic = self._world:GetService("MonsterShowLogic")
  local monsterGroup = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
  for _, e in ipairs(monsterGroup:GetEntities()) do
    local result = sMonsterShowLogic:AddMonsterDeadMark(e)
    local deadMarkCmpt = e:DeadMark()
    if result and deadMarkCmpt and not deadMarkCmpt:GetDeadCasterID() and not e:HasShowDeath() then
      deadMarkCmpt:SetDeadCasterID(casterEntityID)
      deadMarkCmpt:SetChainAttackIndex(chainTimeIndex)
      deadMarkCmpt:SetChainAttackStageIndex(chainStageIndex)
      if not result then
        local casterEntity = self._world:GetEntityByID(casterEntityID)
        if EDITOR then
          Log.exception("MonsterHas DeadMark CasterID:", casterEntity:PetPstID():GetTemplateID(), ",SkillID:", chainSkillID, ",MonsterID:", e:MonsterID():GetMonsterID(), ",LevelID:", self._world.BW_WorldInfo.level_id)
        else
          Log.fatal("MonsterHas DeadMark CasterID:", casterEntity:PetPstID():GetTemplateID(), ",SkillID:", chainSkillID, ",MonsterID:", e:MonsterID():GetMonsterID(), ",LevelID:", self._world.BW_WorldInfo.level_id)
        end
      end
    end
  end
  local trapServiceLogic = self._world:GetService("TrapLogic")
  local trapGroup = self._world:GetGroup(self._world.BW_WEMatchers.TrapID)
  for _, e in ipairs(trapGroup:GetEntities()) do
    trapServiceLogic:AddTrapDeadMark(e)
    local deadMarkCmpt = e:DeadMark()
    if deadMarkCmpt and not deadMarkCmpt:GetDeadCasterID() then
      deadMarkCmpt:SetDeadCasterID(casterEntityID)
      deadMarkCmpt:SetChainAttackIndex(chainTimeIndex)
      deadMarkCmpt:SetChainAttackStageIndex(chainStageIndex)
    end
  end
  sMonsterShowLogic:DoAllMonsterDeadLogic()
end

function ChainSkillCalculator:_CalcAndApplyChainSkillHitback(casterEntity, skillCastPos, skillHitbackResultDic, chainTimeIndex, index)
  local hitbackResultDic = self:_CalcSkillDelayHitback(skillCastPos, skillHitbackResultDic)
  local petAttackDataCmpt = casterEntity:SkillPetAttackData()
  local chainAttackData = petAttackDataCmpt:GetMultiStageChainAttackDataList()
  local shadowChainAttackData = petAttackDataCmpt:GetChainShadowData()
  local attdata
  if chainAttackData[chainTimeIndex] and chainAttackData[chainTimeIndex][index] then
    attdata = chainAttackData[chainTimeIndex][index]
  end
  attdata = attdata or shadowChainAttackData[chainTimeIndex]
  if not attdata then
    return
  end
  local trapServiceLogic = self._world:GetService("TrapLogic")
  local triggerService = self._world:GetService("Trigger")
  for victimEntityID, v in pairs(hitbackResultDic) do
    local hitbackResult = v
    local hitbackStartPos = hitbackResult:GetStartPos()
    local hitbackTargetPos = hitbackResult:GetGridPos()
    local victimEntity = self._world:GetEntityByID(victimEntityID)
    victimEntity:SetGridLocation(hitbackTargetPos)
    if victimEntity:HasPetPstID() or victimEntity:HasTeam() or victimEntity:HasMonsterID() then
      local posDir = hitbackResult:GetHitDir()
      if posDir then
        hitbackTargetPos = hitbackTargetPos + posDir
      end
    end
    local trapEntity = trapServiceLogic:TriggerBomb(hitbackTargetPos, victimEntity)
    if trapEntity then
      local trapCmpt = trapEntity:Trap()
      trapEntity:Attributes():Modify("HP", 0)
      trapServiceLogic:AddTrapDeadMark(trapEntity)
      triggerService:Notify(NTTrapAction:New(nil, hitbackStartPos))
    end
    attdata:AddEffectResult(v)
  end
end

function ChainSkillCalculator:_CalcAndApplyChainSkillEffect_DamageOnTargetCount(chainAttackData, skillHitbackResultDic, petEntityID, chainSkillID, attackPos, skillEffectParam, scopeResult)
  local targetIDs = scopeResult:GetTargetIDs()
  local skillEffectCalcParam = SkillEffectCalcParam:New(petEntityID, targetIDs, skillEffectParam, chainSkillID, scopeResult:GetAttackRange(), attackPos)
  local skillResult = self._calcDamageOnTargetCountCalc:DoSkillEffectCalculator(skillEffectCalcParam)
  for _, result in ipairs(skillResult) do
    result:SetSkillEffectScopeResult(scopeResult)
    self:_OnApplyChainSkillEffectResult(skillEffectCalcParam, result, chainAttackData, skillHitbackResultDic)
  end
end

function ChainSkillCalculator:_CalcAndApplyChainSkillEffect_DynamicCenterDamage(chainAttackData, skillHitbackResultDic, petEntityID, chainSkillID, attackPos, skillEffectParam, scopeResult)
  local targetIDs = scopeResult:GetTargetIDs()
  local skillEffectCalcParam = SkillEffectCalcParam:New(petEntityID, targetIDs, skillEffectParam, chainSkillID, scopeResult:GetAttackRange(), attackPos)
  skillEffectCalcParam.centerPos = scopeResult:GetCenterPos()
  local skillResult = self._dynamicCenterDamageCalc:DoSkillEffectCalculator(skillEffectCalcParam)
  for _, result in ipairs(skillResult) do
    result:SetSkillEffectScopeResult(scopeResult)
    self:_OnApplyChainSkillEffectResult(skillEffectCalcParam, result, chainAttackData, skillHitbackResultDic)
  end
end

function ChainSkillCalculator:CalcChainSkillScope(casterEntity, chainSkillID, castPos)
  local svcCfgDeco = self._world:GetService("ConfigDecoration")
  local skillEffectArray = svcCfgDeco:GetLatestEffectParamArray(casterEntity:GetID(), chainSkillID)
  local effectType191, effectType203
  for _, effect in ipairs(skillEffectArray) do
    if effect:GetEffectType() == SkillEffectType.DynamicCenterDamage then
      effectType191 = effect
    end
    if effect:GetEffectType() == SkillEffectType.DynamicScopeChainDamage then
      effectType203 = effect
    end
  end
  local scopeResult
  local targetList = {}
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(chainSkillID, casterEntity)
  local utilData = self._world:GetService("UtilData")
  skillConfigData = utilData:ProcessChianSkillConfig(skillConfigData, casterEntity)
  if effectType191 then
    local calc191 = SkillEffectCalc_DynamicCenterDamage:New(self._world)
    targetList, scopeResult = calc191:SelectCenter(casterEntity, effectType191, castPos)
  elseif effectType203 then
    local calc203 = SkillEffectCalc_DynamicScopeChainDamage:New(self._world)
    scopeResult = calc203:CalcChainReplaceScope(casterEntity, effectType203)
  else
    local utilScopeSvc = self._world:GetService("UtilScopeCalc")
    scopeResult = utilScopeSvc:CalcSkillScope(skillConfigData, castPos, casterEntity)
  end
  return scopeResult
end

function ChainSkillCalculator:_CalcTrapReplaceChainSkill(chainTimeIndex, index, casterEntity, castPos, chainSkillID, skillHitbackResultDic)
  local buffCmpt = casterEntity:BuffComponent()
  local petBuffCmpt = casterEntity:BuffComponent()
  local replaceChainEntityID = petBuffCmpt:GetBuffValue("ReplaceEntityID")
  local replaceChainEntity = self._world:GetEntityByID(replaceChainEntityID)
  if not replaceChainEntity then
    return
  end
  if replaceChainEntity:HasDeadMark() then
    return
  end
  local petAttackDataCmpt = casterEntity:SkillPetAttackData()
  local chainSkillID = petAttackDataCmpt:GetChainSkillID()
  if chainSkillID <= 0 then
    return
  end
  Log.fatal("Calc ChainSkill Repalce :", chainSkillID)
  local configSvc = self._world:GetService("Config")
  local skillConfigData = configSvc:GetSkillConfigData(chainSkillID, casterEntity)
  local castPos = replaceChainEntity:GridLocation().Position
  local scopeResult = self:CalcChainSkillScope(casterEntity, chainSkillID, castPos)
  local targetList = self:_CalcTargetListInScopeResult(casterEntity, scopeResult)
  petAttackDataCmpt:AddChainReplaceData(chainTimeIndex)
  local chainAttackData = petAttackDataCmpt:GetChainReplaceData(chainTimeIndex)
  chainAttackData:SetScopeResult(scopeResult)
  chainAttackData:SetSkillID(chainSkillID)
  local scopeFilterParam = skillConfigData:GetScopeFilterParam()
  self:_CalcChainSkillInScopeResult(casterEntity, castPos, chainAttackData, targetList, {}, scopeFilterParam, chainTimeIndex, index)
end
