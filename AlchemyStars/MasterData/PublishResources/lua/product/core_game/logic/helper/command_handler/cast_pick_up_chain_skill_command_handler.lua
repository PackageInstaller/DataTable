require("command_base_handler")
_class("CastPickUpChainSkillCommandHandler", CommandBaseHandler)
CastPickUpChainSkillCommandHandler = CastPickUpChainSkillCommandHandler

function CastPickUpChainSkillCommandHandler:DoHandleCommand(cmd)
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local pickUpGridPos = cmd:GetCmdPickUpResult()
  if pickUpGridPos and not self:IsPosNil(pickUpGridPos) and self:IsGridPosValid(pickUpGridPos) then
    local utilData = self._world:GetService("UtilData")
    if not utilData:IsPosDimensionDoor(pickUpGridPos) then
      local logicPickUpCmpt = teamEntity:LogicPickUp()
      logicPickUpCmpt:SetLogicPickUpGridPos(pickUpGridPos)
      logicPickUpCmpt:SetLogicPickUpGridSafePos(pickUpGridPos)
      self._world:BattleStat():SetCastChainByDimensionDoorState(true)
      self._world:EventDispatcher():Dispatch(GameEventType.PickUpChainSkillTargetFinish, 1)
      return
    end
  end
  local errorMsg = "ChainSkillPickUp Invalid GridPos:"
  if pickUpGridPos then
    errorMsg = errorMsg .. tostring(pickUpGridPos)
  end
  self:_HandleServerSyncFailed(BattleFailedType.ChainPathPickUpGridPosInvalid, errorMsg)
end
