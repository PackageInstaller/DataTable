require("main_state_sys")
_class("MirageMonsterTurnSystem", MainStateSystem)
MirageMonsterTurnSystem = MirageMonsterTurnSystem

function MirageMonsterTurnSystem:_GetMainStateID()
  return GameStateID.MirageMonsterTurn
end

function MirageMonsterTurnSystem:_OnMainStateEnter(TT)
  Log.info("MirageMonsterTurnSystem:Begin")
  self:_DoRenderHidePetInfo(TT)
  self:_DoRenderMirageClearWarningArea(TT)
  local traps = self:_DoLogicMirageCastTrapSkill()
  self:_DoRenderMiragePlayTrapSkill(TT, traps)
  local battleResult = self:_IsBattleEnd()
  if battleResult then
    self:_SwitchToRoundResult()
    return
  end
  local warningTraps = self:_DoLogicMirageCastTrapWarningSkill()
  self:_DoRenderMiragePlayTrapWarningSkill(TT, warningTraps)
  Log.info("MirageMonsterTurnSystem:End")
  self:_DoLogicSwitchMainFsmState()
end

function MirageMonsterTurnSystem:_DoLogicSwitchMainFsmState()
  local mirageSvc = self.world:GetService("MirageLogic")
  local isForceClose = mirageSvc:IsMirageForceClose()
  if isForceClose then
    self._world:EventDispatcher():Dispatch(GameEventType.MirageMonsterTurnFinish, 2)
    return
  end
  local IsMirageOpen = mirageSvc:IsMirageOpen()
  if IsMirageOpen then
    self._world:EventDispatcher():Dispatch(GameEventType.MirageMonsterTurnFinish, 1)
  else
    self._world:EventDispatcher():Dispatch(GameEventType.MirageMonsterTurnFinish, 2)
  end
end

function MirageMonsterTurnSystem:_SwitchToRoundResult()
  self._world:EventDispatcher():Dispatch(GameEventType.MirageMonsterTurnFinish, 2)
end

function MirageMonsterTurnSystem:_DoLogicMirageCastTrapSkill()
  local mirageSvc = self.world:GetService("MirageLogic")
  return mirageSvc:DoMirageCastTrapSkill()
end

function MirageMonsterTurnSystem:_DoLogicMirageCastTrapWarningSkill()
  local mirageSvc = self.world:GetService("MirageLogic")
  return mirageSvc:DoMirageCastTrapWarningSkill()
end

function MirageMonsterTurnSystem:_DoRenderHidePetInfo(TT)
end

function MirageMonsterTurnSystem:_DoRenderMirageClearWarningArea(TT)
end

function MirageMonsterTurnSystem:_DoRenderMiragePlayTrapSkill(TT, traps)
end

function MirageMonsterTurnSystem:_DoRenderMiragePlayTrapWarningSkill(TT, traps)
end
