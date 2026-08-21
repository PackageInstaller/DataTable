require("command_base_handler")
_class("CastChessMoveCommandHandler", CommandBaseHandler)
CastChessMoveCommandHandler = CastChessMoveCommandHandler

function CastChessMoveCommandHandler:DoHandleCommand(cmd)
  Log.notice("Handle CastChessMoveCommand")
  local casterEntityID = cmd:GetCmdCasterEntityID()
  local chessPath = cmd:GetCmdChessPath()
  local chessEntity = self._world:GetEntityByID(casterEntityID)
  if not chessEntity then
    Log.fatal("Can not find chess entity")
    return
  end
  local chessSvc = self._world:GetService("ChessLogic")
  chessSvc:FinishChessPetTurn(false, casterEntityID)
  local boardEntity = self._world:GetBoardEntity()
  local logicChessPathComponent = boardEntity:LogicChessPath()
  logicChessPathComponent:SetLogicChessPath(chessPath)
  logicChessPathComponent:SetLogicChessPetEntityID(chessEntity:GetID())
  if self._world:RunAtServer() then
    self._world:EventDispatcher():Dispatch(GameEventType.WaitInputFinish, 8)
  else
    self._world:EventDispatcher():Dispatch(GameEventType.PickUpChessPetFinish, 1)
  end
end
