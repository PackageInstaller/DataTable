require("command_base_handler")
_class("SyncClientUnscaledCountDownCommandHandler", CommandBaseHandler)
SyncClientUnscaledCountDownCommandHandler = SyncClientUnscaledCountDownCommandHandler

function SyncClientUnscaledCountDownCommandHandler:DoHandleCommand(cmd)
  Log.notice("Handle SyncClientUnscaledCountDownCommand")
  local flagID = cmd:GetCmdFlagID()
  local state = cmd:GetCmdState()
  local checkValid = false
  local group = self._world:GetGroup(self._world.BW_WEMatchers.UnscaledCountDownLogic)
  for i, e in ipairs(group:GetEntities()) do
    local cmpt = e:UnscaledCountDownLogic()
    Log.debug("SyncClientUnscaledCountDownCommand cmpt flagID:", cmpt:GetFlagID(), " isActive:", cmpt:GetIsActive())
    if flagID == cmpt:GetFlagID() then
      if cmpt:GetIsActive() then
        cmpt:SetIsWaitTrigger(true)
        checkValid = true
      end
      break
    end
  end
  if not checkValid then
    Log.fatal("SyncClientUnscaledCountDownCommand invalid")
    return
  end
  local gameFsmCmpt = self._world:GameFSM()
  local gameFsmStateID = gameFsmCmpt:CurStateID()
  if gameFsmStateID == GameStateID.WaitInput then
    local isWaitMove = false
    local teamEntity = self._world:Player():GetCurrentTeamEntity()
    local logicChainPathCmpt = teamEntity:LogicChainPath()
    local chainPathData = logicChainPathCmpt:GetLogicChainPath()
    if chainPathData and 0 < #chainPathData then
      isWaitMove = true
    end
    if not isWaitMove then
      self._world:EventDispatcher():Dispatch(GameEventType.WaitInputFinish, 12)
    end
  end
end
