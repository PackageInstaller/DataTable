require("command_base_handler")
_class("PopStarPickUpCommandHandler", CommandBaseHandler)
PopStarPickUpCommandHandler = PopStarPickUpCommandHandler

function PopStarPickUpCommandHandler:DoHandleCommand(cmd)
  Log.notice("Handle PopStarPickUpCommand")
  local gridPos = cmd:GetCmdPickUpPos()
  local isValid = self:CheckPickUpPosValid(gridPos)
  if not isValid then
    return
  end
  local popStarSvc = self._world:GetService("PopStarLogic")
  local connectPieces = popStarSvc:CalculatePopStarConnectPieces(gridPos)
  if connectPieces and #connectPieces == 0 then
    return
  end
  popStarSvc:SetPopConnectPieces(connectPieces)
  self._world:EventDispatcher():Dispatch(GameEventType.WaitInputFinish, 1)
end

function PopStarPickUpCommandHandler:CheckPickUpPosValid(gridPos)
  local utilDataSvc = self._world:GetService("UtilData")
  local isValid = utilDataSvc:IsValidPiecePos(gridPos)
  if not isValid then
    Log.fatal("PopStarPickUpCommand Invalid pos error, pick pos: ", Vector2.Pos2Index(gridPos))
    return false
  end
  return true
end
