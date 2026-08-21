require("command_base_handler")
_class("CancelChainSkillCommandHandler", CommandBaseHandler)
CancelChainSkillCommandHandler = CancelChainSkillCommandHandler

function CancelChainSkillCommandHandler:DoHandleCommand(cmd)
  local flag = self._world:BattleStat():GetTriggerDimensionFlag()
  local nextId = 2
  if flag == TriggerDimensionFlag.WaitInput then
    nextId = 3
  elseif flag == TriggerDimensionFlag.RoundResult then
    nextId = 4
  end
  self._world:BattleStat():SetTriggerDimensionFlag(TriggerDimensionFlag.None)
  self._world:BattleStat():SetCastChainByDimensionDoorState(false)
  self._world:EventDispatcher():Dispatch(GameEventType.PickUpChainSkillTargetFinish, nextId)
end
