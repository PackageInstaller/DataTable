require("command_base_handler")
_class("CastChessPetAttackCommandHandler", CommandBaseHandler)
CastChessPetAttackCommandHandler = CastChessPetAttackCommandHandler

function CastChessPetAttackCommandHandler:DoHandleCommand(cmd)
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local casterEntityID = cmd:GetCmdCasterEntityID()
  local targetEntityIDList = cmd:GetCmdTargetEntityIDList()
  local chessPath = cmd:GetCmdChessPath()
  local pickUpPos = cmd:GetCmdPickUpResult()
  local casterPetEntity = self._world:GetEntityByID(casterEntityID)
  if not casterPetEntity then
    Log.fatal("Can not find chess entity")
    return
  end
  local chessSvc = self._world:GetService("ChessLogic")
  chessSvc:FinishChessPetTurn(false, casterEntityID)
  local boardEntity = self._world:GetBoardEntity()
  local logicChessPathComponent = boardEntity:LogicChessPath()
  logicChessPathComponent:SetLogicChessPath(chessPath)
  logicChessPathComponent:SetLogicChessPetEntityID(casterPetEntity:GetID())
  logicChessPathComponent:SetLogicPickUpPos(pickUpPos)
  if self._world:RunAtServer() then
    self._world:EventDispatcher():Dispatch(GameEventType.WaitInputFinish, 9)
  else
    self._world:EventDispatcher():Dispatch(GameEventType.PickUpChessPetFinish, 3)
  end
end
