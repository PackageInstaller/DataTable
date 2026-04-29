require("command_base_handler")
WaveResultAwardNextStateType = {
  None = 0,
  WaveSwitch = 1,
  WaitInput = 2
}
_enum("WaveResultAwardNextStateType", WaveResultAwardNextStateType)
_class("ChooseMiniMazeWaveAwardCommandHandler", CommandBaseHandler)
ChooseMiniMazeWaveAwardCommandHandler = ChooseMiniMazeWaveAwardCommandHandler

function ChooseMiniMazeWaveAwardCommandHandler:DoHandleCommand(cmd)
  local relicID = cmd:GetChooseRelicID()
  local partnerID = cmd:GetChoosePartnerID()
  local isOpening = cmd:IsBattleOpening()
  local battleStatCmpt = self._world:BattleStat()
  battleStatCmpt:SetWaveWaitApplyAward(relicID, isOpening, partnerID)
  Log.debug("[MiniMaze] ChooseMiniMazeWaveAwardCommandHandler relicID: ", relicID, " partnerID: ", partnerID, " isOpen ", isOpening)
  self._world:EventDispatcher():Dispatch(GameEventType.WaveResultAwardFinish, 1)
end
