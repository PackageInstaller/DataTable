require("main_state_sys")
_class("MirageRoleTurnSystem", MainStateSystem)
MirageRoleTurnSystem = MirageRoleTurnSystem

function MirageRoleTurnSystem:_GetMainStateID()
  return GameStateID.MirageRoleTurn
end

function MirageRoleTurnSystem:_OnMainStateEnter(TT)
  Log.info("MirageRoleTurnSystem:Begin")
  self:_DoLogicMirageMove()
  self:_DoRenderMirageMove(TT)
  self:_DoLogicSwitchMainFsmState()
end

function MirageRoleTurnSystem:_DoLogicMirageMove()
  local mirageSvc = self._world:GetService("MirageLogic")
  mirageSvc:DoMirageCalculateTeamMove()
end

function MirageRoleTurnSystem:_DoLogicSwitchMainFsmState()
  local mirageSvc = self.world:GetService("MirageLogic")
  local isForceClose = mirageSvc:IsMirageForceClose()
  if isForceClose then
    self._world:EventDispatcher():Dispatch(GameEventType.MirageRoleTurnFinish, 2)
    return
  end
  self._world:EventDispatcher():Dispatch(GameEventType.MirageRoleTurnFinish, 1)
end

function MirageRoleTurnSystem:_DoRenderMirageMove(TT)
end
