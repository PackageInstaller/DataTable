require("main_state_sys")
_class("MirageEnterSystem", MainStateSystem)
MirageEnterSystem = MirageEnterSystem

function MirageEnterSystem:_GetMainStateID()
  return GameStateID.MirageEnter
end

function MirageEnterSystem:_OnMainStateEnter(TT)
  Log.info("MirageEnter:Begin")
  local initStepNum = self:_DoLogicMirageEnter()
  self:_DoRenderMirageEnterUI(TT, initStepNum)
  local traps = self:_DoLogicMirageCreateTraps()
  self:_DoRenderMirageShowTraps(TT, traps)
  local warningTraps = self:_DoLogicMirageCastTrapWarningSkill()
  self:_DoRenderMiragePlayTrapWarningSkill(TT, warningTraps)
  Log.info("MirageEnter:End")
  self:_DoLogicSwitchMainFsmState()
end

function MirageEnterSystem:_DoLogicMirageEnter()
  self._world:EventDispatcher():Dispatch(GameEventType.BanAutoFightBtn, true)
  local mirageSvc = self._world:GetService("MirageLogic")
  local mirageCmpt = mirageSvc:GetMirageComponent()
  return mirageCmpt:GetRemainRoundCount()
end

function MirageEnterSystem:_DoLogicMirageCreateTraps()
  local eTraps = {}
  local mirageSvc = self._world:GetService("MirageLogic")
  eTraps = mirageSvc:DoMirageCreateTraps()
  return eTraps
end

function MirageEnterSystem:_DoLogicMirageCastTrapWarningSkill()
  local mirageSvc = self.world:GetService("MirageLogic")
  return mirageSvc:DoMirageCastTrapWarningSkill()
end

function MirageEnterSystem:_DoLogicSwitchMainFsmState()
  self._world:EventDispatcher():Dispatch(GameEventType.MirageEnterFinish, 1)
end

function MirageEnterSystem:_DoRenderMirageEnterUI(TT, initStepNum)
end

function MirageEnterSystem:_DoRenderMirageShowTraps(TT, traps)
end

function MirageEnterSystem:_DoRenderMiragePlayTrapWarningSkill(TT, traps)
end
