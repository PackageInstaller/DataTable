require("main_state_sys")
_class("PopStarRoundEnterSystem", MainStateSystem)
PopStarRoundEnterSystem = PopStarRoundEnterSystem

function PopStarRoundEnterSystem:_GetMainStateID()
  return GameStateID.PopStarRoundEnter
end

function PopStarRoundEnterSystem:_OnMainStateEnter(TT)
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local incRound, curWaveRound = self:_DoLogicIncRoundCount()
  self:_DoLogicTrapBeforePlayer()
  self:_DoRenderTrapBeforePlayer(TT)
  self:_DoRenderShowPetUI(TT, curWaveRound)
  if incRound then
    local formerTeamOrder = self:_DoLogicPlayerTurnBuff(teamEntity)
    self:_DoRenderPlayerTurnBuff(TT, teamEntity, formerTeamOrder)
  end
  self:_DoLogicTrapDie()
  self:_DoRenderTrapDie(TT)
  self:_DoRenderWaitDeathEnd(TT)
  self:_DoLogicClearDeadEntity()
  if incRound then
    local tAllNotifyArray = self:_DoLogicUpdatePetPower(teamEntity, incRound)
    self:_DoRenderUpdatePetPower(TT, tAllNotifyArray)
  end
  self:_DoLogicSaveRoundBeginPlayerPos(teamEntity)
  self:_DoRenderSaveRoundBeginPlayerPos(TT, teamEntity)
  self:_DoLogicFeatureOnRoundEnter(incRound)
  self:_DoRenderFeatureOnRoundEnter(TT)
  self:_DoLogicTakeSnapshot()
  self:_DoLogicSwitchState()
end

function PopStarRoundEnterSystem:_DoLogicIncRoundCount()
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
  local boardServiceLogic = self._world:GetService("BoardLogic")
  local connectRate = boardServiceLogic:GetConnectRate()
  self._world:GetDataLogger():AddDataLog("OnRoundStart", connectRate)
  return true, curWaveRound
end

function PopStarRoundEnterSystem:_DoLogicTrapBeforePlayer()
  local trapServiceLogic = self._world:GetService("TrapLogic")
  trapServiceLogic:TrapActionBeforePlayer()
end

function PopStarRoundEnterSystem:_DoLogicPlayerTurnBuff(teamEntity)
  if teamEntity == nil then
    return
  end
  local formerTeamOrder = teamEntity:Team():CloneTeamOrder()
  local buffLogicService = self._world:GetService("BuffLogic")
  buffLogicService:CalcPlayerBuffTurn(teamEntity)
  return formerTeamOrder
end

function PopStarRoundEnterSystem:_DoLogicUpdatePetPower(teamEntity, incRound)
  local battleStatCmpt = self._world:BattleStat()
  if not battleStatCmpt:IsFirstRound() then
    return self:_UpdateAllPetPower(teamEntity, incRound)
  end
end

function PopStarRoundEnterSystem:_UpdateAllPetPower(teamEntity, incRound)
  local tAllNotifyArray = {}
  local group = self._world:GetGroup(self._world.BW_WEMatchers.Pet)
  for _, petEntity in ipairs(group:GetEntities()) do
    local tNotify = self:_UpdatePetPower(teamEntity, petEntity, incRound)
    table.appendArray(tAllNotifyArray, tNotify)
  end
  return tAllNotifyArray
end

function PopStarRoundEnterSystem:_UpdatePetPower(teamEntity, petEntity, incRound)
  local petPstIDComponent = petEntity:PetPstID()
  local petPstID = petPstIDComponent:GetPstID()
  local attributesComponent = petEntity:Attributes()
  local localSkillID = petEntity:SkillInfo():GetActiveSkillID()
  if not localSkillID then
    local petData = self._world:GetPetData(petPstID)
    localSkillID = petData:GetPetActiveSkill()
  end
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(localSkillID, petEntity)
  local previousReady = attributesComponent:GetAttribute("Ready") == 1
  local ready = 0
  if skillConfigData:GetSkillTriggerType() == SkillTriggerType.LegendEnergy then
    local legendPower = attributesComponent:GetAttribute("LegendPower")
    if legendPower >= skillConfigData:GetSkillTriggerParam() then
      ready = 1
    end
    self._world:GetSyncLogger():Trace({
      key = "Update LegendPet Power",
      entityID = petEntity:GetID(),
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
  else
    local power = attributesComponent:GetAttribute("Power")
    local maxPower = skillConfigData:GetSkillTriggerParam()
    if maxPower == 0 then
      local battleStatComponent = self._world:BattleStat()
      local lastDoActiveSkillRound = battleStatComponent:GetLastDoActiveSkillRound(petPstID)
      local curRound = battleStatComponent:GetLevelTotalRoundCount()
      previousReady = previousReady and curRound - 1 ~= lastDoActiveSkillRound
    end
    local delayChangePowerValue = petEntity:BuffComponent():GetBuffValue("DelayChangePowerValue")
    if delayChangePowerValue and delayChangePowerValue ~= 0 then
      power = power + delayChangePowerValue
      petEntity:BuffComponent():SetBuffValue("DelayChangePowerValue", 0)
    end
    local battleStatComponent = self._world:BattleStat()
    if 0 < power then
      local lastDoActiveSkillRound = battleStatComponent:GetLastDoActiveSkillRound(petPstID)
      local curRound = battleStatComponent:GetLevelTotalRoundCount()
      if lastDoActiveSkillRound then
        if 1 < curRound - lastDoActiveSkillRound then
          power = power - 1
        end
      elseif incRound then
        power = power - 1
      end
    end
    if power <= 0 then
      power = 0
      ready = 1
    end
    self._world:GetSyncLogger():Trace({
      key = "UpdatePetPower",
      entityID = petEntity:GetID(),
      power = power,
      ready = ready
    })
    attributesComponent:Modify("Power", power)
    self._world:EventDispatcher():Dispatch(GameEventType.PetPowerChange, petPstID, power, false)
    local isAddPetPower = petEntity:BuffComponent():GetBuffValue("AddPetPower") or 0
    if isAddPetPower == 1 then
      self._world:EventDispatcher():Dispatch(GameEventType.PetActiveSkillCancelReady, petPstID)
      petEntity:BuffComponent():SetBuffValue("AddPetPower", 0)
    end
  end
  local buffSvc = self._world:GetService("BuffLogic")
  buffSvc:ChangePetActiveSkillReady(petEntity, ready)
  local tNotifyArray = {}
  if ready == 1 then
    teamEntity:ActiveSkill():AddPowerfullRoundCount(petEntity:GetID(), 1)
    if previousReady then
      teamEntity:ActiveSkill():AddPreviousReadyRoundCount(petEntity:GetID(), 1)
      self._world:EventDispatcher():Dispatch(GameEventType.PetActiveSkillGetReady, petPstID, false)
      local notify = NTPetActiveSkillPreviousReady:New(petEntity)
      table.insert(tNotifyArray, notify)
      self._world:GetService("Trigger"):Notify(notify)
    else
      self._world:EventDispatcher():Dispatch(GameEventType.PetActiveSkillGetReady, petPstID, true)
      local guideService = self._world:GetService("Guide")
      if guideService ~= nil then
        guideService:Trigger(GameEventType.ShowGuidePowerReady, petEntity)
      end
      local notify = NTPowerReady:New(petEntity)
      table.insert(tNotifyArray, notify)
      self._world:GetService("Trigger"):Notify(notify)
    end
  end
  return tNotifyArray
end

function PopStarRoundEnterSystem:_DoLogicSaveRoundBeginPlayerPos(teamEntity)
  if teamEntity == nil then
    return
  end
  local playerPos = teamEntity:GetGridPosition()
  self._world:BattleStat():SetRoundBeginPlayerPos(playerPos)
  self._world:GetService("Trigger"):Notify(NTSaveRoundBeginPlayerPosEnd:New(teamEntity))
end

function PopStarRoundEnterSystem:_DoLogicFeatureOnRoundEnter(incRound)
  local featureLogicSvc = self._world:GetService("FeatureLogic")
  if featureLogicSvc and featureLogicSvc:CanEnableFeature() then
    featureLogicSvc:DoFeatureOnRoundEnter(incRound)
  end
end

function PopStarRoundEnterSystem:_DoLogicTakeSnapshot()
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
    Log.debug("PopStarRoundEnterSystem BoardPieceTypes:", echo_one_line(ELogLevel.Debug, pieceLog))
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

function PopStarRoundEnterSystem:_DoLogicSwitchState()
  local isBattleEnd = self:_IsBattleEnd()
  if isBattleEnd then
    self._world:EventDispatcher():Dispatch(GameEventType.PopStarRoundEnterFinish, 2)
    return
  end
  self._world:EventDispatcher():Dispatch(GameEventType.PopStarRoundEnterFinish, 1)
end

function PopStarRoundEnterSystem:_DoRenderTrapBeforePlayer(TT)
end

function PopStarRoundEnterSystem:_DoRenderShowPetUI(TT, curWaveRound)
end

function PopStarRoundEnterSystem:_DoRenderPlayerTurnBuff(TT)
end

function PopStarRoundEnterSystem:_DoRenderUpdatePetPower(TT, tNotifyArray)
end

function PopStarRoundEnterSystem:_DoRenderSaveRoundBeginPlayerPos(TT, teamEntity)
end

function PopStarRoundEnterSystem:_DoRenderFeatureOnRoundEnter(TT)
end
