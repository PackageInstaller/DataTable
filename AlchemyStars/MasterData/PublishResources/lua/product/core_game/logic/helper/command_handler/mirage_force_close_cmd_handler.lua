require("command_base_handler")
_class("MirageForceCloseCommandHandler", CommandBaseHandler)
MirageForceCloseCommandHandler = MirageForceCloseCommandHandler

function MirageForceCloseCommandHandler:DoHandleCommand(cmd)
  Log.notice("Handle MirageForceCloseCommand")
  local mirageSvc = self._world:GetService("MirageLogic")
  mirageSvc:SetMirageForceClose(true)
  local gameFsmCmpt = self._world:GameFSM()
  local gameFsmStateID = gameFsmCmpt:CurStateID()
  if gameFsmStateID == GameStateID.MirageWaitInput then
    self._world:EventDispatcher():Dispatch(GameEventType.MirageWaitInputFinish, 2)
  end
end
