require("command_base_handler")
_class("MiragePickUpCommandHandler", CommandBaseHandler)
MiragePickUpCommandHandler = MiragePickUpCommandHandler

function MiragePickUpCommandHandler:DoHandleCommand(cmd)
  Log.notice("Handle MiragePickUpCommand")
  local gridPos = cmd:GetPickUpGridPos()
  local isValid = self:CheckPickUpPosValid(gridPos)
  if not isValid then
    return
  end
  local boardEntity = self._world:GetBoardEntity()
  local mirageCmpt = boardEntity:Mirage()
  mirageCmpt:SetMovePos(gridPos)
  mirageCmpt:SetRoundCount(mirageCmpt:GetRoundCount() + 1)
  if self._world:RunAtClient() then
    local remainStep = mirageCmpt:GetRemainRoundCount()
    self._world:EventDispatcher():Dispatch(GameEventType.RefreshMirageStep, remainStep)
  end
  self._world:EventDispatcher():Dispatch(GameEventType.MirageWaitInputFinish, 1)
end

function MiragePickUpCommandHandler:CheckPickUpPosValid(gridPos)
  local boardEntity = self._world:GetBoardEntity()
  local mirageCmpt = boardEntity:Mirage()
  if not mirageCmpt then
    return false
  end
  if not mirageCmpt:IsMirageOpen() then
    Log.fatal("MiragePickUpCommand Invalid Mirage is close")
    return false
  end
  if mirageCmpt:IsRoundOver() then
    Log.fatal("MiragePickUpCommand Invalid round is over")
    return false
  end
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local teamPos = teamEntity:GetGridPosition()
  local utilData = self._world:GetService("UtilData")
  local validGrids = utilData:GetRoundGrid(teamPos)
  local roundGridPosList = {}
  for _, grid in ipairs(validGrids) do
    local pos = Vector2(grid.x, grid.y)
    table.insert(roundGridPosList, pos)
  end
  if not table.icontains(roundGridPosList, gridPos) then
    Log.fatal("MiragePickUpCommand Invalid pos error, pick pos: ", Vector2.Pos2Index(gridPos), ", team pos: ", Vector2.Pos2Index(teamPos))
    return false
  end
  return true
end
