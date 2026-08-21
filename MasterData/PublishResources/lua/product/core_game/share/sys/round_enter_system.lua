require("main_state_sys")
_class("RoundEnterSystem", MainStateSystem)
RoundEnterSystem = RoundEnterSystem

function RoundEnterSystem:_GetMainStateID()
  return GameStateID.RoundEnter
end

function RoundEnterSystem:_OnMainStateEnter(TT)
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  Log.debug("RoundEnterSystem GameTurn=", GetEnumKey("GameTurnType", self._world:GetGameTurn()))
  local incRound, curWaveRound = self:_DoLogicIncRoundCount()
  local damageInfo, isWarnRound = self:_DoLogicTryPunishmentRoundEnter()
  self:_DoRenderPunishmentRoundEnter(TT, damageInfo, isWarnRound)
  if self:_ShouldGotoNextStateForPunishmentRound() then
    self:_DoLogicGotoNextStateForPunishmentRound()
    return
  end
  self:_DoLogicFeatureOnRoundEnterEarly(incRound)
  self:_DoRenderFeatureOnRoundEnterEarly(TT)
  self:_DoLogicTrapBeforePlayer()
  self:_DoRenderTrapBeforePlayer(TT)
  self:_DoLogicMonsterDead()
  self:_DoRenderMonsterDead(TT)
  self:_DoRenderShowPetUI(TT, curWaveRound)
  self:_DoRenderShowPetTurnTips(TT)
  local calcBuff = false
  if self._world:MatchType() == MatchType.MT_BlackFist then
    calcBuff = not self._world:BattleStat():IsRoundAuroraTime()
  else
    calcBuff = incRound
  end
  if calcBuff then
    local formerTeamOrder = self:_DoLogicPlayerTurnBuff(teamEntity)
    self:_DoRenderPlayerTurnBuff(TT, teamEntity, formerTeamOrder)
  end
  if self._world:MatchType() == MatchType.MT_Chess then
    self:_DoLogicChessTurnBuff()
    self:_DoRenderChessTurnBuff(TT)
  end
  self:_DoLogicMonsterDead()
  self:_DoRenderMonsterDead(TT)
  self:_DoLogicTrapDie()
  self:_DoRenderTrapDie(TT)
  local ntTeamOrderChange = self:_DoLogicPetDead(teamEntity)
  self:_DoRenderPetDead(TT, teamEntity, ntTeamOrderChange)
  self:_DoRenderWaitDeathEnd(TT)
  self:_DoLogicClearDeadEntity()
  if incRound then
    local tAllNotifyArray = self:_DoLogicUpdatePetPower(teamEntity, incRound)
    self:_DoRenderUpdatePetPower(TT, tAllNotifyArray)
  end
  self:_DoLogicSaveRoundBeginPlayerPos(teamEntity)
  self:_DoRenderSaveRoundBeginPlayerPos(TT, teamEntity)
  if self._world:MatchType() == MatchType.MT_Chess then
    self:_DoLogicResetChessPetFinishState()
    self:_DoRenderResetChessPetFinishState(TT)
  end
  self:_DoLogicFeatureOnRoundEnter(incRound)
  self:_DoRenderFeatureOnRoundEnter(TT)
  self:_DoRenderFeatureShowBanPetSkill(TT)
  if incRound then
    self:_DoLogicRefreshMonsterAntiActiveSkill()
    self:_DoRenderRefreshMonsterAntiActiveSkill(TT)
  end
  self:_DoLogicTakeSnapshot()
  self:_DoLogicGotoNextState()
end

function RoundEnterSystem:_DoLogicGotoNextState()
  local isBattleEnd = self:_IsBattleEnd()
  if isBattleEnd then
    self._world:EventDispatcher():Dispatch(GameEventType.RoundEnterFinish, 2)
    return
  end
  local isChooseRelic = self:_NeedChooseRelicInOpening()
  if isChooseRelic then
    self._world:EventDispatcher():Dispatch(GameEventType.RoundEnterFinish, 3)
    return
  end
  self._world:EventDispatcher():Dispatch(GameEventType.RoundEnterFinish, 1)
end

function RoundEnterSystem:_DoLogicIncRoundCount()
  local battleStatCmpt = self._world:BattleStat()
  local curRound = battleStatCmpt:GetLevelTotalRoundCount()
  local curWaveRound = battleStatCmpt:GetCurWaveRound()
  local followRound = battleStatCmpt:GetGameRoundCount()
  if curRound == followRound then
    return false, curWaveRound
  end
  if self._world:GetGameTurn() ~= GameTurnType.LocalPlayerTurn then
    return false, curWaveRound
  end
  local cnt = battleStatCmpt:IncGameRoundCount()
  battleStatCmpt:ClearCurRoundDoActiveSkillTimes()
  battleStatCmpt:AffixClearAllSkillDamageRecord()
  local boardServiceLogic = self._world:GetService("BoardLogic")
  local connectRate = boardServiceLogic:GetConnectRate()
  self._world:GetDataLogger():AddDataLog("OnRoundStart", connectRate)
  return true, curWaveRound
end

function RoundEnterSystem:_DoLogicPlayerTurnBuff(teamEntiy)
  if teamEntiy == nil then
    return
  end
  local formerTeamOrder = teamEntiy:Team():CloneTeamOrder()
  local buffLogicService = self._world:GetService("BuffLogic")
  buffLogicService:RefreshLockHPLogic()
  buffLogicService:CalcPlayerBuffTurn(teamEntiy)
  return formerTeamOrder
end

function RoundEnterSystem:_DoLogicChessTurnBuff()
  local buffLogicService = self._world:GetService("BuffLogic")
  buffLogicService:CalcChessBuffTurn()
end

function RoundEnterSystem:_DoLogicUpdatePetPower(teamEntiy, incread)
  local battleStatCmpt = self._world:BattleStat()
  if not battleStatCmpt:IsFirstRound() then
    return self:_UpdateAllPetPower(teamEntiy, incread)
  end
end

function RoundEnterSystem:_UpdateAllPetPower(teamEntity, incread)
  local tAllNotifyArray = {}
  local group = self._world:GetGroup(self._world.BW_WEMatchers.Pet)
  for _, e in ipairs(group:GetEntities()) do
    local tNotify = self:_UpdatePetPower(teamEntity, e, incread)
    table.appendArray(tAllNotifyArray, tNotify)
  end
  return tAllNotifyArray
end

function RoundEnterSystem:_UpdatePetPower(teamEntity, e, incread)
  if e:HasPetDeadMark() then
    return
  end
  local petPstIDComponent = e:PetPstID()
  local petPstID = petPstIDComponent:GetPstID()
  local attributesComponent = e:Attributes()
  local localSkillID = e:SkillInfo():GetActiveSkillID()
  if not localSkillID then
    local petData = self._world:GetPetData(petPstID)
    localSkillID = petData:GetPetActiveSkill()
  end
  local extraSkillIDList = e:SkillInfo():GetExtraActiveSkillIDList()
  if not extraSkillIDList or 0 < #extraSkillIDList then
  end
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(localSkillID, e)
  local previousReady = attributesComponent:GetAttribute("Ready") == 1
  local ready = 0
  if skillConfigData:GetSkillTriggerType() == SkillTriggerType.LegendEnergy then
    local legendPower = attributesComponent:GetAttribute("LegendPower")
    if legendPower >= skillConfigData:GetSkillTriggerParam() then
      ready = 1
    end
    self._world:GetSyncLogger():Trace({
      key = "Update LegendPet Power",
      entityID = e:GetID(),
      legendPower = legendPower,
      ready = ready
    })
    if legendPower > BattleConst.LegendPowerMax then
      legendPower = BattleConst.LegendPowerMax
    end
    attributesComponent:Modify("LegendPower", legendPower)
    self._world:EventDispatcher():Dispatch(GameEventType.PetLegendPowerChange, petPstID, legendPower, false)
  elseif skillConfigData:GetSkillTriggerType() == SkillTriggerType.BuffLayer then
    ready = attributesComponent:GetAttribute("Ready")
  elseif skillConfigData:GetSkillTriggerType() == SkillTriggerType.AlchemyEnergy then
    local alchemyPower = attributesComponent:GetAttribute("AlchemyPower")
    if alchemyPower >= skillConfigData:GetSkillTriggerParam() then
      ready = 1
    end
    if alchemyPower > BattleConst.AlchemyPowerMax then
      alchemyPower = BattleConst.AlchemyPowerMax
    end
    attributesComponent:Modify("AlchemyPower", alchemyPower)
    self._world:EventDispatcher():Dispatch(GameEventType.PetAlchemyPowerChange, petPstID, alchemyPower, false)
  elseif skillConfigData:GetSkillTriggerType() == SkillTriggerType.ColorPalette then
    if not e:HasColorPalette() then
      e:AddColorPalette()
    end
    local component = e:ColorPalette()
    if component:IsSatisfy() then
      ready = 1
    end
  else
    local power = attributesComponent:GetAttribute("Power")
    local maxPower = skillConfigData:GetSkillTriggerParam()
    if maxPower == 0 then
      local battleStatComponent = self._world:BattleStat()
      local lastDoActiveSkillRound = battleStatComponent:GetLastDoActiveSkillRound(petPstID)
      local curRound = battleStatComponent:GetLevelTotalRoundCount()
      previousReady = previousReady and curRound - 1 ~= lastDoActiveSkillRound
    end
    local delayChangePowerValue = e:BuffComponent():GetBuffValue("DelayChangePowerValue")
    if delayChangePowerValue and delayChangePowerValue ~= 0 then
      power = power + delayChangePowerValue
      e:BuffComponent():SetBuffValue("DelayChangePowerValue", 0)
    end
    local battleStatComponent = self._world:BattleStat()
    if 0 < power then
      local lastDoActiveSkillRound = battleStatComponent:GetLastDoActiveSkillRound(petPstID)
      local curRound = battleStatComponent:GetLevelTotalRoundCount()
      if lastDoActiveSkillRound then
        if 1 < curRound - lastDoActiveSkillRound then
          power = power - 1
        end
      elseif incread then
        power = power - 1
      end
    end
    if power <= 0 then
      power = 0
      ready = 1
    end
    self._world:GetSyncLogger():Trace({
      key = "UpdatePetPower",
      entityID = e:GetID(),
      power = power,
      ready = ready
    })
    attributesComponent:Modify("Power", power)
    self._world:EventDispatcher():Dispatch(GameEventType.PetPowerChange, petPstID, power, false)
    local isAddPetPower = e:BuffComponent():GetBuffValue("AddPetPower") or 0
    if isAddPetPower == 1 then
      self._world:EventDispatcher():Dispatch(GameEventType.PetActiveSkillCancelReady, petPstID)
      e:BuffComponent():SetBuffValue("AddPetPower", 0)
    end
  end
  local blsvc = self._world:GetService("BuffLogic")
  blsvc:ChangePetActiveSkillReady(e, ready)
  local tNotifyArray = {}
  if ready == 1 then
    teamEntity:ActiveSkill():AddPowerfullRoundCount(e:GetID(), 1)
    if previousReady then
      teamEntity:ActiveSkill():AddPreviousReadyRoundCount(e:GetID(), 1)
      self._world:EventDispatcher():Dispatch(GameEventType.PetActiveSkillGetReady, petPstID, false)
      local notify = NTPetActiveSkillPreviousReady:New(e)
      table.insert(tNotifyArray, notify)
      self._world:GetService("Trigger"):Notify(notify)
    else
      self._world:EventDispatcher():Dispatch(GameEventType.PetActiveSkillGetReady, petPstID, true)
      local guideService = self._world:GetService("Guide")
      if guideService ~= nil then
        local guideTaskId = guideService:Trigger(GameEventType.ShowGuidePowerReady, e)
      end
      local notify = NTPowerReady:New(e)
      table.insert(tNotifyArray, notify)
      self._world:GetService("Trigger"):Notify(notify)
    end
  end
  self:_UpdatePetExtraSkillPower(teamEntity, e, incread, tNotifyArray)
  return tNotifyArray
end

function RoundEnterSystem:_UpdatePetExtraSkillPower(teamEntity, e, incread, tNotifyArray)
  if e:HasPetDeadMark() then
    return
  end
  local blsvc = self._world:GetService("BuffLogic")
  local utilData = self._world:GetService("UtilData")
  local configService = self._world:GetService("Config")
  local petPstIDComponent = e:PetPstID()
  local petPstID = petPstIDComponent:GetPstID()
  local attributesComponent = e:Attributes()
  local extraSkillIDList = e:SkillInfo():GetExtraActiveSkillIDList()
  local skillInfoCmpt = e:SkillInfo()
  if extraSkillIDList and 0 < #extraSkillIDList then
    for index, localSkillID in ipairs(extraSkillIDList) do
      local ignoreUpdate = skillInfoCmpt:IsExtraSkillIgnoreCdUpdate(index)
      if not ignoreUpdate then
        local skillConfigData = configService:GetSkillConfigData(localSkillID, e)
        local readyAttr = utilData:GetPetSkillReadyAttr(e, localSkillID)
        local previousReady = readyAttr == 1
        local ready = 0
        if skillConfigData:GetSkillTriggerType() == SkillTriggerType.LegendEnergy then
          local legendPower = attributesComponent:GetAttribute("LegendPower")
          local minCost = blsvc:CalcMinCostByExtraParam(e, localSkillID)
          if legendPower >= minCost then
            ready = 1
          end
          if legendPower > BattleConst.LegendPowerMax then
            legendPower = BattleConst.LegendPowerMax
          end
          attributesComponent:Modify("LegendPower", legendPower)
          self._world:EventDispatcher():Dispatch(GameEventType.PetLegendPowerChange, petPstID, legendPower, false)
        elseif skillConfigData:GetSkillTriggerType() == SkillTriggerType.BuffLayer then
          ready = attributesComponent:GetAttribute("Ready")
        elseif skillConfigData:GetSkillTriggerType() == SkillTriggerType.ColorPalette then
          if not e:HasColorPalette() then
            e:AddColorPalette()
          end
          local component = e:ColorPalette()
          if component:IsSatisfy() then
            ready = 1
          end
        else
          local power = utilData:GetPetPowerAttr(e, localSkillID)
          local maxPower = utilData:GetPetMaxPowerAttr(e, localSkillID)
          if maxPower == 0 then
            local battleStatComponent = self._world:BattleStat()
            local lastDoActiveSkillRound = battleStatComponent:GetLastDoActiveSkillRound(petPstID, index)
            local curRound = battleStatComponent:GetLevelTotalRoundCount()
            previousReady = previousReady and curRound - 1 ~= lastDoActiveSkillRound
          end
          local battleStatComponent = self._world:BattleStat()
          if 0 < power then
            local lastDoActiveSkillRound = battleStatComponent:GetLastDoActiveSkillRound(petPstID, index)
            local curRound = battleStatComponent:GetLevelTotalRoundCount()
            if lastDoActiveSkillRound then
              if 1 < curRound - lastDoActiveSkillRound then
                power = power - 1
              end
            elseif incread then
              power = power - 1
            end
          end
          if power <= 0 then
            power = 0
            ready = 1
          end
          self._world:GetSyncLogger():Trace({
            key = "UpdatePetPower",
            entityID = e:GetID(),
            power = power,
            ready = ready
          })
          utilData:SetPetPowerAttr(e, power, localSkillID)
          self._world:EventDispatcher():Dispatch(GameEventType.PetExtraPowerChange, petPstID, localSkillID, power, false)
        end
        local blsvc = self._world:GetService("BuffLogic")
        blsvc:ChangePetActiveSkillReady(e, ready, localSkillID)
        if ready == 1 then
          if previousReady then
            self._world:EventDispatcher():Dispatch(GameEventType.PetExtraActiveSkillGetReady, petPstID, localSkillID, false)
          else
            self._world:EventDispatcher():Dispatch(GameEventType.PetExtraActiveSkillGetReady, petPstID, localSkillID, true)
          end
        end
      end
    end
  end
end

function RoundEnterSystem:_DoLogicTakeSnapshot()
  local logger = self._world:GetMatchLogger()
  logger:TakeSnapshot()
  if not _G.ENABLE_SYNC_LOG then
    return
  end
  local boardEntity = self._world:GetBoardEntity()
  local blockFlags = boardEntity:Board():GetBlockFlagArray()
  local pieceTypes = boardEntity:Board().Pieces
  local blockLog = {}
  for x, row in pairs(blockFlags) do
    for y, v in pairs(row) do
      local block = v:GetBlock()
      if 0 < block then
        blockLog[x * 100 + y] = block
      end
    end
  end
  self._world:GetSyncLogger():Trace({key = "BlockFlags", blockFlags = blockLog})
  local pieceLog = {}
  for x, row in pairs(pieceTypes) do
    for y, v in pairs(row) do
      pieceLog[x * 100 + y] = v
    end
  end
  self._world:GetSyncLogger():Trace({key = "PieceTypes", pieceTypes = pieceLog})
  if self._world and self._world:IsDevelopEnv() then
    Log.debug("RoundEnterSystem BoardPieceTypes:", echo_one_line(ELogLevel.Debug, pieceLog))
  end
  local hpLog = {}
  local attrGroup = self._world:GetGroup(self._world.BW_WEMatchers.Attributes)
  for i, e in ipairs(attrGroup:GetEntities()) do
    local val = e:Attributes():GetCurrentHP()
    if val then
      hpLog[e:GetID()] = val
    end
  end
  self._world:GetSyncLogger():Trace({key = "EntityHP", entityHP = hpLog})
  local posLog = {}
  local posGroup = self._world:GetGroup(self._world.BW_WEMatchers.GridLocation)
  for i, e in ipairs(posGroup:GetEntities()) do
    local pos = e:GridLocation():GetGridPos()
    if e:GetID() < 100000000 and not e:Piece() then
      posLog[e:GetID()] = math.floor(pos.x * 100 + pos.y)
    end
  end
  self._world:GetSyncLogger():Trace({key = "EntityPos", entityPos = posLog})
end

function RoundEnterSystem:_DoLogicTrapBeforePlayer()
  local trapServiceLogic = self._world:GetService("TrapLogic")
  trapServiceLogic:TrapActionBeforePlayer()
end

function RoundEnterSystem:_DoLogicSaveRoundBeginPlayerPos(teamEntity)
  if teamEntity == nil then
    return
  end
  local playerPos = teamEntity:GetGridPosition()
  self._world:BattleStat():SetRoundBeginPlayerPos(playerPos)
  self._world:GetService("Trigger"):Notify(NTSaveRoundBeginPlayerPosEnd:New(teamEntity))
end

function RoundEnterSystem:_DoLogicResetChessPetFinishState()
  local group = self._world:GetGroup(self._world.BW_WEMatchers.ChessPet)
  for i, v in ipairs(group:GetEntities()) do
    local chessPetCmpt = v:ChessPet()
    local buffCmpt = v:BuffComponent()
    local isSkipTurn = buffCmpt:HasFlag(BuffFlags.SkipTurn)
    if not isSkipTurn then
      chessPetCmpt:SetChessPetFinishTurn(false)
    end
  end
end

function RoundEnterSystem:_DoLogicFeatureOnRoundEnter(incRound)
  local featureLogicSvc = self._world:GetService("FeatureLogic")
  if featureLogicSvc and featureLogicSvc:CanEnableFeature() then
    featureLogicSvc:DoFeatureOnRoundEnter(incRound)
  end
end

function RoundEnterSystem:_DoLogicFeatureOnRoundEnterEarly(incRound)
  local featureLogicSvc = self._world:GetService("FeatureLogic")
  if featureLogicSvc and featureLogicSvc:CanEnableFeature() then
    featureLogicSvc:DoFeatureOnRoundEnterEarly(incRound)
  end
end

function RoundEnterSystem:_DoLogicTryPunishmentRoundEnter()
  local configService = self._world:GetService("Config")
  local levelConfigData = configService:GetLevelConfigData()
  if levelConfigData:GetOutOfRoundType() == 0 then
    return
  end
  local battleStatCmpt = self._world:BattleStat()
  local punishmentRoundCount = battleStatCmpt:GetCurWavePunishmentRoundCount()
  if punishmentRoundCount == 0 then
    return
  end
  if battleStatCmpt:IsPunishmentRoundExecuted(punishmentRoundCount) then
    return
  end
  if punishmentRoundCount == 1 then
    battleStatCmpt:MarkPunishmentRoundExecuted(punishmentRoundCount)
    return nil, true
  end
  local realPunishmentRoundCount = punishmentRoundCount - 1
  local punishPercent = 0
  for round, percent in pairs(BattleConst.PunishmentRoundHPPercent) do
    if round <= realPunishmentRoundCount then
      punishPercent = percent
    end
  end
  if punishPercent <= 0 then
    return
  end
  local eTeam = self._world:Player():GetLocalTeamEntity()
  local maxHP = eTeam:Attributes():CalcMaxHp()
  local val = maxHP * punishPercent
  local lsvcCalcDamage = self._world:GetService("CalcDamage")
  local damageInfo = lsvcCalcDamage:DoCalcDamage(eTeam, eTeam, {
    formulaID = 130,
    hp = val,
    skillID = 0
  }, true)
  battleStatCmpt:MarkPunishmentRoundExecuted(punishmentRoundCount)
  return damageInfo
end

function RoundEnterSystem:_DoLogicRefreshMonsterAntiActiveSkill()
  local configService = self._world:GetService("Config")
  local monsterConfigData = configService:GetMonsterConfigData()
  local monsterGroup = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
  for _, e in ipairs(monsterGroup:GetEntities()) do
    local monsterID = e:MonsterID():GetMonsterID()
    local attributeCmpt = e:Attributes()
    local originalMax = attributeCmpt:GetAttribute("OriginalMaxAntiSkillCountPerRound")
    if originalMax ~= 0 then
      local originalCount = attributeCmpt:GetAttribute("OriginalWaitActiveSkillCount")
      attributeCmpt:Modify("WaitActiveSkillCount", originalCount)
      attributeCmpt:Modify("MaxAntiSkillCountPerRound", originalMax)
    end
  end
end

function RoundEnterSystem:_ShouldGotoNextStateForPunishmentRound()
  local configService = self._world:GetService("Config")
  local levelConfigData = configService:GetLevelConfigData()
  if levelConfigData:GetOutOfRoundType() == 0 then
    return false
  end
  local teamEntity = self._world:Player():GetLocalTeamEntity()
  if teamEntity and self:IsPlayerDead(teamEntity) then
    return true
  end
end

function RoundEnterSystem:_DoLogicGotoNextStateForPunishmentRound()
  self._world:EventDispatcher():Dispatch(GameEventType.RoundEnterFinish, 2)
end

function RoundEnterSystem:_NeedChooseRelicInOpening()
  if self._world:MatchType() ~= MatchType.MT_MiniMaze then
    return false
  end
  local talentSvc = self._world:GetService("Talent")
  return talentSvc:NeedChooseOpeningRelic()
end

function RoundEnterSystem:_DoRenderShowPetUI(TT, curWaveRound)
end

function RoundEnterSystem:_DoRenderShowPetTurnTips(TT)
end

function RoundEnterSystem:_DoRenderPlayerTurnBuff(TT)
end

function RoundEnterSystem:_DoRenderChessTurnBuff(TT)
end

function RoundEnterSystem:_DoRenderUpdatePetPower(TT, tNotifyArray)
end

function RoundEnterSystem:_DoRenderTrapBeforePlayer(TT)
end

function RoundEnterSystem:_DoRenderResetChessPetFinishState(TT)
end

function RoundEnterSystem:_DoRenderFeatureOnRoundEnter(TT)
end

function RoundEnterSystem:_DoRenderFeatureOnRoundEnterEarly(TT)
end

function RoundEnterSystem:_DoRenderFeatureShowBanPetSkill(TT)
end

function RoundEnterSystem:_DoRenderSaveRoundBeginPlayerPos(TT, teamEntity)
end

function RoundEnterSystem:_DoRenderPunishmentRoundEnter()
end

function RoundEnterSystem:_DoRenderRefreshMonsterAntiActiveSkill(TT)
end
