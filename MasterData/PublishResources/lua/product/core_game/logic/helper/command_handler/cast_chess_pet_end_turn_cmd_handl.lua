require("command_base_handler")
_class("CastChessPetEndTurnCommandHandler", CommandBaseHandler)
CastChessPetEndTurnCommandHandler = CastChessPetEndTurnCommandHandler

function CastChessPetEndTurnCommandHandler:DoHandleCommand(cmd)
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local turnType = cmd:GetCmdTurnType()
  if turnType == ChessTurnEndType.Single then
    local turnEndEntityID = cmd:GetCmdTurnEndEntityID()
    self:_HandleEndSingleChessPetTurn(turnEndEntityID)
  elseif turnType == ChessTurnEndType.All then
    self:_HandleEndAllChessPetTurn()
  end
end

function CastChessPetEndTurnCommandHandler:_HandleEndSingleChessPetTurn(turnEndEntityID)
  local casterPetEntity = self._world:GetEntityByID(turnEndEntityID)
  if not casterPetEntity then
    Log.fatal("Can not find chess entity")
    return
  end
  local chessSvc = self._world:GetService("ChessLogic")
  chessSvc:FinishChessPetTurn(false, turnEndEntityID)
  local isAllChessPetTurnEnd = chessSvc:IsAllChessPetTurnFinish()
  if isAllChessPetTurnEnd then
    if self._world:RunAtServer() then
      self._world:EventDispatcher():Dispatch(GameEventType.WaitInputFinish, 7)
    else
      self._world:EventDispatcher():Dispatch(GameEventType.PreviewChessPetFinish, 2)
    end
  elseif self._world:RunAtClient() then
    self._world:EventDispatcher():Dispatch(GameEventType.PreviewChessPetFinish, 2)
  end
end

function CastChessPetEndTurnCommandHandler:_HandleEndAllChessPetTurn()
  local chessSvc = self._world:GetService("ChessLogic")
  chessSvc:FinishChessPetTurn(true)
  if self._world:RunAtServer() then
    self._world:EventDispatcher():Dispatch(GameEventType.WaitInputFinish, 7)
  else
    local utilDataSvc = self._world:GetService("UtilData")
    if utilDataSvc:GetCurMainStateID() == GameStateID.PreviewChessPet then
      self._world:EventDispatcher():Dispatch(GameEventType.PreviewChessPetFinish, 2)
    elseif utilDataSvc:GetCurMainStateID() == GameStateID.PickUpChessPet then
      self._world:EventDispatcher():Dispatch(GameEventType.PickUpChessPetFinish, 4)
    else
      if utilDataSvc:GetCurMainStateID() == GameStateID.WaitInput then
        self._world:EventDispatcher():Dispatch(GameEventType.WaitInputFinish, 7)
      else
      end
    end
  end
end
