require("main_state_sys")
_class("PopStarWaveResultSystem", MainStateSystem)
PopStarWaveResultSystem = PopStarWaveResultSystem

function PopStarWaveResultSystem:_GetMainStateID()
  return GameStateID.PopStarWaveResult
end

function PopStarWaveResultSystem:_OnMainStateEnter(TT)
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  self:_DoLogicCalc3StarProgress()
  self:_DoLogicCalcBonusObjective()
  local battleStatCmpt = self._world:BattleStat()
  local waveNum = battleStatCmpt:GetCurWaveIndex()
  self:_DoLogicNotifyWaveEnd(waveNum)
  self:_DoRenderNotifyWaveEnd(TT, waveNum)
  self:_DoLogicTrapDie()
  self:_DoRenderTrapDie(TT)
  local victory = self:_DoLogicCheckBattleResult()
  self:_DoLogicHandleTurnBattleResult(victory)
  self:_DoRenderHandleTurnBattleResult(TT, victory)
  self:_WaitTime(TT, 200)
  self:_DoLogicSwitchState()
end

function PopStarWaveResultSystem:_DoLogicCalc3StarProgress()
  local popStarSvc = self._world:GetService("PopStarLogic")
  popStarSvc:Calculate3StarProgress()
end

function PopStarWaveResultSystem:_DoLogicCalcBonusObjective()
  local bonusService = self._world:GetService("BonusCalc")
  bonusService:CalcBonusObjective()
end

function PopStarWaveResultSystem:_DoLogicNotifyWaveEnd(waveNum)
  self._world:GetService("Trigger"):Notify(NTWaveTurnEnd:New(waveNum))
end

function PopStarWaveResultSystem:_DoLogicCheckBattleResult()
  local victory = false
  local battleService = self._world:GetService("Battle")
  local popStarNumNotEnough = battleService:HandlePopStarNumber()
  if popStarNumNotEnough then
    victory = false
  else
    victory = true
  end
  return victory
end

function PopStarWaveResultSystem:_DoLogicHandleTurnBattleResult(victory)
  local battleStatCmpt = self._world:BattleStat()
  battleStatCmpt:SetBattleLevelResult(victory)
end

function PopStarWaveResultSystem:_DoLogicSwitchState()
  self._world:EventDispatcher():Dispatch(GameEventType.PopStarWaveResultFinish, 1)
end

function PopStarWaveResultSystem:_DoRenderNotifyWaveEnd(TT, waveNum)
end

function PopStarWaveResultSystem:_DoRenderHandleTurnBattleResult(TT, victory)
end
