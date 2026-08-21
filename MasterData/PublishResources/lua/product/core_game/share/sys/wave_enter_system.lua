require("main_state_sys")
_class("WaveEnterSystem", MainStateSystem)
WaveEnterSystem = WaveEnterSystem

function WaveEnterSystem:_GetMainStateID()
  return GameStateID.WaveEnter
end

function WaveEnterSystem:_OnMainStateEnter(TT)
  self:_DoLogicInitWaveBattleState()
  self:_DoRenderWaveInfo(TT)
  self:_DoLogicCloseAuroraTime()
  self:_DoRenderCloseAuroraTime(TT)
  local battleStatCmpt = self._world:BattleStat()
  local waveNum = battleStatCmpt:GetCurWaveIndex()
  self:_DoLogicNotifyWaveEnter(waveNum)
  self:_DoRenderNotifyWaveEnter(TT, waveNum)
  local spawnTraps = self:_DoLogicCreateWaveTraps()
  local showTrapsTaskID = self:_DoRenderShowWaveTraps(TT, spawnTraps)
  self:_DoRenderPreShowMonster(TT)
  local spawnMonsters, hitbackResult = self:_DoLogicCreateWaveMonsters()
  if hitbackResult then
    self:_DoRenderRefreshMonsterHitBackTeam(TT, hitbackResult)
  end
  self:_DoRenderShowWaveMonsters(TT, spawnMonsters)
  local waitTaskIDList = {}
  if showTrapsTaskID ~= nil then
    table.insert(waitTaskIDList, showTrapsTaskID)
  end
  self:_WaitTasksEnd(TT, waitTaskIDList)
  self:_DoRenderWaveEnterInnerStory(TT)
  self:_DoLogicNotifyWaveStart(waveNum)
  self:_DoRenderNotifyWaveStart(TT, waveNum)
  self:_DoLogicMonsterDead()
  self:_DoRenderMonsterDead(TT)
  self:_DoLogicCalcPreMove()
  self:_DoRenderPlayPreMove(TT)
  self:_DoLogicSwitchFsmState()
end

function WaveEnterSystem:_DoLogicInitWaveBattleState()
  local battleStatCmpt = self._world:BattleStat()
  local waveNum = battleStatCmpt:GetCurWaveIndex()
  Log.notice("EnterWave WaveNum:", waveNum)
  local levelRoundCount = battleStatCmpt:GetLevelLeftRoundCount()
  if battleStatCmpt:AssignWaveResult() then
    local configService = self._world:GetService("Config")
    local levelConfigData = configService:GetLevelConfigData()
    local l_arrAssignWaveParams = levelConfigData:GetLevelCompleteConditionParams()[1]
    local l_round_num = l_arrAssignWaveParams[LevelCompleteAssignWaveParamExp.RoundNum]
    if l_round_num ~= nil then
      battleStatCmpt:InitCurWaveRound(l_round_num)
    else
      battleStatCmpt:InitCurWaveRound(levelRoundCount)
    end
    self._world:EventDispatcher():Dispatch(GameEventType.UpdateRoundCount, battleStatCmpt:GetCurWaveRound())
  else
    battleStatCmpt:InitCurWaveRound(levelRoundCount)
  end
  battleStatCmpt:InitCurWaveAllMonsterDeadTimes()
  self:_DoLogicLoadArchievedBattle()
  local battleSvc = self._world:GetService("Battle")
  local isExit = battleSvc:IsCurWaveExit()
  local exitPos = battleSvc:CurWaveExitPos()
  local data = DataWaveEnterResult:New(waveNum, isExit, exitPos)
  self._world:EventDispatcher():Dispatch(GameEventType.DataLogicResult, 0, data)
end

function WaveEnterSystem:_DoLogicLoadArchievedBattle()
  local battle_archive = self._world:GetService("Maze"):GetBattleArchive()
  if battle_archive then
    local ccsvc = self._world:GetService("CompleteCondition")
    local cfgsvc = self._world:GetService("Config")
    local cond = cfgsvc:GetLevelConfigData():GetLevelCompleteConditionType()
    if battle_archive.completion.cond == cond then
      ccsvc:SetArchivedData(cond, battle_archive.completion.data)
    end
    self._world:BattleStat():SetArchivedDrops(battle_archive.drops)
  end
end

function WaveEnterSystem:_DoLogicCreateWaveTraps()
  local battleStatCmpt = self._world:BattleStat()
  local waveNum = battleStatCmpt:GetCurWaveIndex()
  local eTraps = {}
  if waveNum ~= 1 then
    local entityService = self._world:GetService("LogicEntity")
    eTraps = entityService:CreateWaveTraps(waveNum)
  else
    local trapIDList = self._world:BattleStat():GetFirstWaveTrapIDList()
    for _, id in ipairs(trapIDList) do
      local entity = self._world:GetEntityByID(id)
      table.insert(eTraps, entity)
    end
  end
  return eTraps
end

function WaveEnterSystem:_DoLogicCreateWaveMonsters()
  local battleStatCmpt = self._world:BattleStat()
  local waveNum = battleStatCmpt:GetCurWaveIndex()
  local trapsvc = self._world:GetService("TrapLogic")
  local eMonsters = {}
  local monsterRefreshPosType, hitbackResult
  if waveNum == 1 then
    local monsterIDList = self._world:BattleStat():GetFirstWaveMonsterIDList()
    for _, id in ipairs(monsterIDList) do
      local entity = self._world:GetEntityByID(id)
      table.insert(eMonsters, entity)
    end
    if eMonsters and not self._world:GetService("Maze"):IsArchivedBattle() then
      local monsterCreationSvc = self._world:GetService("MonsterCreationLogic")
      for _, e in ipairs(eMonsters) do
        monsterCreationSvc:CalcAppearSkill(e)
        local tEntities, tResults = trapsvc:TriggerTrapByEntity(e, TrapTriggerOrigin.Move)
        e:AddAppearTriggerTrap(tEntities, tResults)
      end
    end
  else
    local entityService = self._world:GetService("LogicEntity")
    eMonsters, hitbackResult = entityService:CreateWaveMonsters(waveNum)
  end
  return eMonsters, hitbackResult
end

function WaveEnterSystem:_DoLogicSwitchFsmState()
  local battleStatCmpt = self._world:BattleStat()
  if battleStatCmpt:GetCurWaveIndex() == 1 then
    self._world:EventDispatcher():Dispatch(GameEventType.WaveEnterFinish, 2)
  else
    self._world:EventDispatcher():Dispatch(GameEventType.WaveEnterFinish, 1)
  end
end

function WaveEnterSystem:_DoLogicNotifyWaveStart(waveNum)
  local triggerService = self._world:GetService("Trigger")
  triggerService:Notify(NTWaveTurnStart:New(waveNum))
end

function WaveEnterSystem:_DoLogicNotifyWaveEnter(waveNum)
  local triggerService = self._world:GetService("Trigger")
  triggerService:Notify(NTWaveEnter:New(waveNum))
end

function WaveEnterSystem:V2Str2V2(str)
  if string.isnullorempty(str) then
    return Vector2.zero
  end
  local dirStrs = string.split(str, ",")
  local dir = Vector2(tonumber(dirStrs[1]), tonumber(dirStrs[2]))
  return dir
end

function WaveEnterSystem:V2StrArr2V2Arr(strs)
  if string.isnullorempty(strs) then
    return nil
  end
  local dirStrs = string.split(strs, ";")
  local arr = {}
  for i, v in ipairs(dirStrs) do
    local v2 = self:V2Str2V2(v)
    table.insert(arr, v2)
  end
  return arr
end

function WaveEnterSystem:_DoLogicCalcPreMove()
  local aiService = self.world:GetService("AI")
  aiService:RunAiLogic_WaitEnd(AILogicPeriodType.Prev)
end

function WaveEnterSystem:_DoRenderWaveInfo(TT)
end

function WaveEnterSystem:_DoRenderShowWaveTraps(TT, spawnTraps)
end

function WaveEnterSystem:_DoRenderPreShowMonster(TT)
end

function WaveEnterSystem:_DoRenderShowWaveMonsters(TT, spawnMonsters)
end

function WaveEnterSystem:_DoRenderWaveEnterInnerStory(TT)
end

function WaveEnterSystem:_DoRenderNotifyWaveStart(TT, waveNum)
end

function WaveEnterSystem:_DoRenderNotifyWaveEnter(TT, waveNum)
end

function WaveEnterSystem:_DoRenderPlayPreMove(TT)
end

function WaveEnterSystem:_DoRenderRefreshMonsterHitBackTeam(TT, hitbackResult)
end
