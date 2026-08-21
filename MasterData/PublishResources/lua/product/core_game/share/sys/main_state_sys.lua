require("unique_reactive_system")
_class("MainStateSystem", UniqueReactiveSystem)
MainStateSystem = MainStateSystem

function MainStateSystem:IsInterested(index, previousComponent, component)
  if component == nil then
    return false
  end
  if not GameFSMComponent:IsInstanceOfType(component) then
    return false
  end
  if component:CurStateID() == self:_GetMainStateID() then
    return true
  end
  return false
end

function MainStateSystem:Filter(world)
  return true
end

function MainStateSystem:ExecuteWorld(world)
  self._world = world
  self._renderBattleService = self._world:GetService("RenderBattle")
  if self._world:RunAtServer() then
    self:MainStateEnter()
  else
    GameGlobal.TaskManager():CoreGameStartTask(self.MainStateEnter, self)
  end
end

function MainStateSystem:MainStateEnter(TT)
  self:_DetailMathLoggerDoLogicTakeSnapshot()
  self:_OnMainStateEnter(TT)
  self:_HandleEntityCommand()
  self:_DoLogicAutoRemoveBuff()
  self:_DoLogicBattleSync()
end

function MainStateSystem:_GetMainStateID()
end

function MainStateSystem:_OnMainStateEnter(TT)
end

function MainStateSystem:_IsBattleEnd()
  local isBattleEnd, isWaveFinished = self:IsBattleEnded()
  self:SetStatBattleWaveResult(isWaveFinished)
  return isBattleEnd
end

function MainStateSystem:SetStatBattleWaveResult(isWaveFinished)
  local cBattleStat = self._world:BattleStat()
  cBattleStat:SetBattleWaveResult(isWaveFinished)
end

function MainStateSystem:_WaitTasksEnd(TT, waitTaskIDList, notCheckTimeOut)
  if waitTaskIDList == nil then
    return
  end
  if not self._world:RunAtServer() then
    while not TaskHelper:GetInstance():IsAllTaskFinished(waitTaskIDList, notCheckTimeOut) do
      YIELD(TT)
    end
  end
end

function MainStateSystem:_WaitTime(TT, msTime)
  if not self._world:RunAtServer() then
    YIELD(TT, msTime)
  end
end

function MainStateSystem:_DoLogicAutoRemoveBuff()
  local buffLogic = self._world:GetService("BuffLogic")
  buffLogic:AutoRemoveUnloadedBuff()
end

function MainStateSystem:_DoLogicBattleSync()
  local syncService = self._world:GetService("SyncLogic")
  syncService:DoBattleSync()
end

function MainStateSystem:_DoLogicSyncPieceType()
  local svc = self._world:GetService("L2R")
  svc:L2RSyncPieceType()
end

function MainStateSystem:_CompareLogicRenderHP(enable)
  local ignoreEntityIds = {}
  if self._world:MatchType() == MatchType.MT_Maze or self._world:MatchType(GetMatchTypeType.SeasonMazeWorldBoss) == MatchType.MT_SeasonMaze then
    local teamEntity = self._world:Player():GetLocalTeamEntity()
    ignoreEntityIds[teamEntity:GetID()] = 1
  end
  local st = self:_GetMainStateID()
  local hpLog = {}
  local attrGroup = self._world:GetGroup(self._world.BW_WEMatchers.Attributes)
  for i, e in ipairs(attrGroup:GetEntities()) do
    if not ignoreEntityIds[e:GetID()] then
      local logicHP = e:Attributes():GetCurrentHP()
      local logicHPMax = e:Attributes():CalcMaxHp()
      if logicHP and e:HP() then
        local renderHP = e:HP():GetRedHP()
        local renderHPMax = e:HP():GetMaxHP()
        if logicHP ~= renderHP or logicHPMax ~= renderHPMax then
          hpLog[e:GetID()] = {logicHP = logicHP, renderHP = renderHP}
          if ForceSyncHP then
            Log.debug("ForceSyncHP entityID=", e:GetID(), " logicHP=", logicHP, " renderHP=", renderHP, " logicHPMax=", logicHPMax, " renderHPMax=", renderHPMax)
            self:_RefreshRenderHP(e, logicHP, logicHPMax)
          end
        end
      end
    end
  end
  if enable and next(hpLog) then
    hpLog[1] = {
      fsm = GetEnumKey("GameStateID", st)
    }
    Log.exception(echo(hpLog))
    self._world:GetService("AutoFight"):EnableAutoMove(false)
  end
end

function MainStateSystem:_RefreshRenderHP(e, hp, hpMax)
  e:ReplaceRedHPAndWhitHP(hp)
  e:ReplaceMaxHP(hpMax)
  local utilDataSvc = self._world:GetService("UtilData")
  local greyVal = utilDataSvc:GetEntityBuffValue(e, "GreyHPValue") or 0
  e:ReplaceGreyHP(greyVal)
  local curShowBossHP = e:BuffView():HasBuffEffect(BuffEffectType.CurShowBossHP)
  if e:HasBoss() or curShowBossHP then
    local maxhp = e:HP():GetMaxHP()
    local redhp = e:HP():GetRedHP()
    local hpPercent = redhp / maxhp
    if 0 < redhp and hpPercent < 0.01 then
      hpPercent = 0.01
    end
    GameGlobal.EventDispatcher():Dispatch(GameEventType.UpdateBossRedHp, e:GetID(), hpPercent, redhp, maxhp)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.UpdateBossWhiteHp, e:GetID(), hpPercent, redhp, maxhp)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.UpdateBossGreyHP, e:GetID(), greyVal, redhp, maxhp)
    local showCurseHp = e:HP():GetShowCurseHp()
    local curseHpValue = e:HP():GetCurseHpValue()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.UpdateBossCurseHP, e:GetID(), showCurseHp, curseHpValue, redhp, maxhp)
  end
  if e:HasTeam() then
    local hpCmpt = e:HP()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.TeamHPChange, {
      isLocalTeam = self._world:Player():IsLocalTeamEntity(e),
      currentHP = hpCmpt:GetRedHP(),
      maxHP = hpCmpt:GetMaxHP(),
      hitpoint = hpCmpt:GetWhiteHP(),
      shield = hpCmpt:GetShieldValue(),
      entityID = e:GetID(),
      showCurseHp = hpCmpt:GetShowCurseHp(),
      curseHpVal = hpCmpt:GetCurseHpValue()
    })
  end
end

function MainStateSystem:_DoLogicTrapDie()
  local trapServiceLogic = self._world:GetService("TrapLogic")
  trapServiceLogic:CalcAllTrapDeadMark()
  local data = DataDeadMarkResult:New()
  local trapGroup = self._world:GetGroup(self._world.BW_WEMatchers.Trap)
  for i, e in ipairs(trapGroup:GetEntities()) do
    if e:HasDeadMark() then
      data:AddDeadEntityID(e:GetID())
    end
  end
  self._world:EventDispatcher():Dispatch(GameEventType.DataLogicResult, 0, data)
end

function MainStateSystem:_DoLogicMonsterDead()
  local drops = {}
  local deadEntityIDList = {}
  self:_DoLogicRecursMonsterDead(drops, deadEntityIDList)
  local data = DataDeadMarkResult:New(deadEntityIDList)
  self._world:EventDispatcher():Dispatch(GameEventType.DataLogicResult, 0, data)
  local deadEntityList = {}
  for _, id in ipairs(deadEntityIDList) do
    deadEntityList[#deadEntityList + 1] = self._world:GetEntityByID(id)
  end
  return deadEntityList
end

function MainStateSystem:_DoLogicRecursMonsterDead(drops, deadEntityIDList)
  local sMonsterShowLogic = self._world:GetService("MonsterShowLogic")
  local monsterGroup = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
  for _, e in ipairs(monsterGroup:GetEntities()) do
    sMonsterShowLogic:AddMonsterDeadMark(e)
  end
  local tmpDrops, tmpDeadEntityIDList = sMonsterShowLogic:DoAllMonsterDeadLogic()
  table.appendArray(drops, tmpDrops)
  table.appendArray(deadEntityIDList, tmpDeadEntityIDList)
  local hasNewDead = self:_DoLogicCheckNewDead()
  if hasNewDead then
    self:_DoLogicRecursMonsterDead(drops, deadEntityIDList)
  end
end

function MainStateSystem:_DoLogicCheckNewDead()
  local sMonsterShowLogic = self._world:GetService("MonsterShowLogic")
  local monsterGroup = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
  for _, e in ipairs(monsterGroup:GetEntities()) do
    local cAttributes = e:Attributes()
    local curHp = cAttributes:GetCurrentHP()
    if curHp <= 0 and not e:HasDeadMark() then
      return true
    end
  end
  return false
end

function MainStateSystem:_DoLogicChessPetDead()
  local chessSvc = self._world:GetService("ChessLogic")
  local monsterGroup = self._world:GetGroup(self._world.BW_WEMatchers.ChessPet)
  local chessPetEntityIDList = {}
  for _, e in ipairs(monsterGroup:GetEntities()) do
    chessPetEntityIDList[#chessPetEntityIDList + 1] = e:GetID()
  end
  chessSvc:DoChessPetListDeadLogic(chessPetEntityIDList)
  local hadDeadEntityIDList = chessSvc:GetHasDeadMarkChessPetList()
  self._world:BattleStat():SetChessDeadPlayerPawnCount(hadDeadEntityIDList)
  local data = DataDeadMarkResult:New(hadDeadEntityIDList)
  self._world:EventDispatcher():Dispatch(GameEventType.DataLogicResult, 0, data)
end

function MainStateSystem:_DoRenderTrapDie(TT)
  if self._world:RunAtClient() then
    local trapServiceRender = self._world:GetService("TrapRender")
    trapServiceRender:PlayAllTrapDead(TT)
  end
end

function MainStateSystem:_DoRenderMonsterDead(TT)
  if self._world:RunAtClient() then
    local sMonsterShowRender = self._world:GetService("MonsterShowRender")
    sMonsterShowRender:DoAllMonsterDeadRender(TT)
  end
end

function MainStateSystem:_DoRenderChessPetDead(TT)
  if self._world:RunAtClient() then
    local chessSvcRender = self._world:GetService("ChessRender")
    chessSvcRender:DoAllChessPetListDeadRender(TT)
  end
end

function MainStateSystem:_DoRenderWaitDeathEnd(TT)
  while self:_CheckShowDeathNotEnd() do
    YIELD(TT)
  end
  if self._world:RunAtClient() then
    local playSkillService = self._world:GetService("PlaySkill")
    local listWaitTask = playSkillService:GetWaitFreeList()
    self:_WaitTasksEnd(TT, listWaitTask)
  end
end

function MainStateSystem:_CheckShowDeathNotEnd()
  local deathGroup = self._world:GetGroup(self._world.BW_WEMatchers.ShowDeath)
  for _, v in ipairs(deathGroup:GetEntities()) do
    local entity = v
    local showDeathCmpt = entity:ShowDeath()
    if not showDeathCmpt:IsShowDeathEnd() then
      return true
    end
  end
  return false
end

function MainStateSystem:_DoLogicClearDeadEntity()
  local sMonsterShowLogic = self._world:GetService("MonsterShowLogic")
  sMonsterShowLogic:ClearMonsterDeadEntity()
  local trapServiceLogic = self._world:GetService("TrapLogic")
  trapServiceLogic:ClearTrapDeadEntity()
end

function MainStateSystem:_DoLogicSpawnInWaveMonsters(monsterWaveInternalTime)
  local monsterCreationSvc = self._world:GetService("MonsterCreationLogic")
  local traps, monsters = monsterCreationSvc:CreateInternalRefreshMonsterLogic(monsterWaveInternalTime)
  return traps, monsters
end

function MainStateSystem:BlinkMainCamera(isShow)
  local sCamera = self._world:GetService("Camera")
  sCamera:BlinkMainCamera(isShow)
end

function MainStateSystem:_DoLogicCalcBonusObjective()
  local bonusService = self._world:GetService("BonusCalc")
  bonusService:CalcBonusObjective()
end

function MainStateSystem:_HandleEntityCommand()
  local cmdHandler = self._world:GetPlayerCommandHandler()
  cmdHandler:ClearHandlerState()
  cmdHandler:HandleCommand()
end

function MainStateSystem:IsBattleEnded()
  local teamEntity = self._world:Player():GetLocalTeamEntity()
  if teamEntity and self:IsPlayerDead(teamEntity) then
    return true, false
  end
  local protectedTrapDead = self:IsProtectedTrapDead()
  if protectedTrapDead then
    return true, false
  end
  local curseTowerAllActive = self:IsCurseTowerAllActive()
  if curseTowerAllActive then
    return true, false
  end
  local chessPetDead = self:IsChessCalculation()
  if chessPetDead then
    return true, false
  end
  local monsterEscapeTooMuch = self:IsMonsterEscapeTooMuch()
  if monsterEscapeTooMuch then
    return true, false
  end
  local cBattleStat = self._world:BattleStat()
  local waveCount = cBattleStat:GetCurWaveIndex()
  local cfgSvc = self._world:GetService("Config")
  local levelConfigData = cfgSvc:GetLevelConfigData()
  local completeConditionType = levelConfigData:GetWaveCompleteConditionType(waveCount)
  local completeConditionParm = levelConfigData:GetWaveCompleteConditionParam(waveCount)
  local completeService = self._world:GetService("CompleteCondition")
  local combinedConditionArguments = levelConfigData:GetWaveCombinedCompleteConditionArguments(waveCount)
  local isComplete = completeService:IsDoneCompleteCondition(completeConditionType, completeConditionParm, combinedConditionArguments)
  return isComplete, isComplete
end

function MainStateSystem:IsPlayerDead(teamEntity)
  local battleSvc = self._world:GetService("Battle")
  return battleSvc:HandlePlayerCalculation(teamEntity)
end

function MainStateSystem:IsProtectedTrapDead()
  local cfgSvc = self._world:GetService("Config")
  local levelCfgData = cfgSvc:GetLevelConfigData()
  local ingore = levelCfgData:GetIgnoreProtectedTrapDead()
  if ingore == 1 then
    return false
  end
  local utilSvc = self._world:GetService("UtilData")
  if utilSvc:GetProtectedTrap() then
    local trapGroup = self._world:GetGroup(self._world.BW_WEMatchers.Trap)
    local protectedTrap
    for _, e in ipairs(trapGroup:GetEntities()) do
      local trapCmpt = e:Trap()
      if trapCmpt:GetTrapType() == TrapType.Protected then
        protectedTrap = e
        local curHP = e:Attributes():GetCurrentHP()
        if curHP <= 0 then
          return true
        end
      end
    end
    if not protectedTrap then
      return true
    end
  end
  return false
end

function MainStateSystem:IsCurseTowerAllActive()
  local curseTowerGroupEntities = self._world:GetGroupEntities(self._world.BW_WEMatchers.CurseTower)
  if curseTowerGroupEntities and 0 < #curseTowerGroupEntities then
    local isAllActive = true
    for _, eTower in ipairs(curseTowerGroupEntities) do
      local isActive = eTower:CurseTower():GetTowerState() == CurseTowerState.Active
      isAllActive = isAllActive and isActive
    end
    if isAllActive then
      return true
    end
  end
  return false
end

function MainStateSystem:IsChessCalculation()
  local battleSvc = self._world:GetService("Battle")
  return battleSvc:HandleChessCalculation()
end

function MainStateSystem:IsMonsterEscapeTooMuch()
  local cmptBattleStat = self._world:BattleStat()
  local waveCount = cmptBattleStat:GetCurWaveIndex()
  local cfgSvc = self._world:GetService("Config")
  local levelConfigData = cfgSvc:GetLevelConfigData()
  local completeConditionType = levelConfigData:GetWaveCompleteConditionType(waveCount)
  local completeConditionParm = levelConfigData:GetWaveCompleteConditionParam(waveCount)
  if completeConditionType == CompleteConditionType.RoundCountLimitAndCheckMonsterEscape then
    local limit = completeConditionParm[1][2]
    local nEscape = cmptBattleStat:GetMonsterEscapeNum()
    local escapeTooMuch = limit <= nEscape
    return escapeTooMuch
  end
  return false
end

function MainStateSystem:_DoLogicPetDead(teamEntity)
  local battleService = self._world:GetService("Battle")
  return battleService:UnloadPetLogic(teamEntity)
end

function MainStateSystem:_DoRenderPetDead(TT, teamEntity, ntTeamOrderChange)
  if self._world:RunAtClient() then
    local renderBattleService = self.world:GetService("RenderBattle")
    renderBattleService:ChangeTeamLeaderRender(TT, teamEntity)
    if ntTeamOrderChange then
      local viewRequest = BattleTeamOrderViewRequest:New(ntTeamOrderChange:GetOldTeamOrder(), ntTeamOrderChange:GetNewTeamOrder(), BattleTeamOrderViewType.FillVacancies_MazePetDead)
      local renderBattleSvc = self._world:GetService("RenderBattle")
      renderBattleSvc:RequestUIChangeTeamOrderView(viewRequest)
      local seqNo = viewRequest:GetRequestSequenceNo()
      while not self._world:RenderBattleStat():IsChangeTeamOrderRequestFinished(seqNo) do
        YIELD(TT)
        if self._world:RenderBattleStat():IsChangeTeamOrderViewDisabled() then
          break
        end
      end
      self._world:GetService("PlayBuff"):PlayBuffView(TT, ntTeamOrderChange)
      local playDamageService = self._world:GetService("PlayDamage")
      playDamageService:OnTeamOrderChangeRefresh()
    end
  end
end

function MainStateSystem:_DoLogicCloseAuroraTime(isReEnterClose)
  if not self._world:BattleStat():IsRoundAuroraTime() then
    return
  end
  if isReEnterClose then
  else
    self._world:BattleStat():SetRoundAuroraTime(false)
    self._world:BattleStat():SetReEnterAuroraTime(false)
  end
  local triggerSvc = self._world:GetService("Trigger")
  triggerSvc:Notify(NTExitAuroraTime:New())
end

function MainStateSystem:_DoRenderCloseAuroraTime(TT)
  if self._world:RunAtServer() then
    return
  end
  local battleRenderCmpt = self._world:BattleRenderConfig()
  self._world:EventDispatcher():Dispatch(GameEventType.ShowHideAuroraTime, false)
  self._world:MainCamera():ToggleAuroraTime(false)
  battleRenderCmpt:SetWaitInputAuroraTime(false)
  battleRenderCmpt:SetReEnterAuroraTimePlayed(false)
  YIELD(TT, BattleConst.AuroraFxExitTimeMs)
  self._world:MainCamera():SetAuroaTimeObjActive(false)
  local playBuffSvc = self._world:GetService("PlayBuff")
  playBuffSvc:PlayBuffView(TT, NTExitAuroraTime:New())
end

function MainStateSystem:_DetailMathLoggerDoLogicTakeSnapshot()
  local detailLogger = self._world:GetDetailMatchLogger()
  if detailLogger then
    local fsmState = self._world:GameFSM():CurStateID()
    local detailNeedTakeSnapFsm = {
      GameStateID.RoundResult,
      GameStateID.RoundEnter
    }
    local onlyFsm = true
    if table.icontains(detailNeedTakeSnapFsm, fsmState) then
      onlyFsm = false
    end
    detailLogger:TakeSnapshot(onlyFsm)
  end
end
