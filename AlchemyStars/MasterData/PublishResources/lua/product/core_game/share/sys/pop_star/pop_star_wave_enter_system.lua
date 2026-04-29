require("main_state_sys")
_class("PopStarWaveEnterSystem", MainStateSystem)
PopStarWaveEnterSystem = PopStarWaveEnterSystem

function PopStarWaveEnterSystem:_GetMainStateID()
  return GameStateID.PopStarWaveEnter
end

function PopStarWaveEnterSystem:_OnMainStateEnter(TT)
  self:_DoLogicInitWaveBattleState()
  self:_DoRenderWaveInfo(TT)
  local spawnTraps = self:_DoLogicCreateWaveTraps()
  local showTrapsTaskID = self:_DoRenderShowWaveTraps(TT, spawnTraps)
  local waitTaskIDList = {}
  if showTrapsTaskID ~= nil then
    table.insert(waitTaskIDList, showTrapsTaskID)
  end
  self:_WaitTasksEnd(TT, waitTaskIDList)
  self:_DoLogicCalcPreMove()
  self:_DoRenderPlayPreMove(TT)
  self:_DoRenderShowUIBattleStart(TT)
  local buffSeqList = self:_DoLogicGameStart()
  self:_DoRenderAutoAddBuff(TT, buffSeqList)
  self:_DoRenderDestroyBattleEnterResource(TT)
  self:_DoLogicSwitchFsmState()
end

function PopStarWaveEnterSystem:_DoLogicInitWaveBattleState()
  local battleStatCmpt = self._world:BattleStat()
  local waveNum = battleStatCmpt:GetCurWaveIndex()
  local levelRoundCount = battleStatCmpt:GetLevelLeftRoundCount()
  battleStatCmpt:InitCurWaveRound(levelRoundCount)
  battleStatCmpt:InitCurWaveAllMonsterDeadTimes()
  local battleSvc = self._world:GetService("Battle")
  local isExit = battleSvc:IsCurWaveExit()
  local exitPos = battleSvc:CurWaveExitPos()
  local data = DataWaveEnterResult:New(waveNum, isExit, exitPos)
  self._world:EventDispatcher():Dispatch(GameEventType.DataLogicResult, 0, data)
end

function PopStarWaveEnterSystem:_DoLogicCreateWaveTraps()
  local eTraps = {}
  local trapIDList = self._world:BattleStat():GetFirstWaveTrapIDList()
  for _, id in ipairs(trapIDList) do
    local entity = self._world:GetEntityByID(id)
    table.insert(eTraps, entity)
  end
  return eTraps
end

function PopStarWaveEnterSystem:_DoLogicCalcPreMove()
  local aiService = self.world:GetService("AI")
  aiService:RunAiLogic_WaitEnd(AILogicPeriodType.Prev)
end

function PopStarWaveEnterSystem:_DoLogicGameStart()
  local gameStartBuffs = {}
  self._world:GetService("Battle"):InitWordBuff(gameStartBuffs)
  self._world:GetService("Battle"):InitTalePetBuff(gameStartBuffs)
  self._world:GetService("Affix"):InitAffixBuff(gameStartBuffs)
  self._world:GetService("Trigger"):Notify(NTGameStart:New())
  return gameStartBuffs
end

function PopStarWaveEnterSystem:_DoLogicSwitchFsmState()
  self._world:EventDispatcher():Dispatch(GameEventType.PopStarWaveEnterFinish, 1)
end

function PopStarWaveEnterSystem:_DoRenderWaveInfo(TT)
end

function PopStarWaveEnterSystem:_DoRenderShowWaveTraps(TT, spawnTraps)
end

function PopStarWaveEnterSystem:_DoRenderPlayPreMove(TT)
end

function PopStarWaveEnterSystem:_DoRenderShowUIBattleStart(TT)
end

function PopStarWaveEnterSystem:_DoRenderAutoAddBuff(TT, buffSeqList)
end

function PopStarWaveEnterSystem:_DoRenderDestroyBattleEnterResource(TT)
end
