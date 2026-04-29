require("entity_commands")
_class("SyncClientUnscaledCountDownCommand", IEntityCommand)
SyncClientUnscaledCountDownCommand = SyncClientUnscaledCountDownCommand
SyncClientUnscaledCountDownCommand.CommandType = "SyncClientUnscaledCountDown"

function SyncClientUnscaledCountDownCommand:Constructor()
  self._flagID = 0
  self._state = 0
end

function SyncClientUnscaledCountDownCommand:GetCommandType()
  return SyncClientUnscaledCountDownCommand.CommandType
end

function SyncClientUnscaledCountDownCommand:GetExecStateID()
  return {
    GameStateID.WaitInput,
    GameStateID.WaitInputChain,
    GameStateID.PickUpChainSkillTarget,
    GameStateID.WaveResultAward,
    GameStateID.MirageWaitInput
  }
end

function SyncClientUnscaledCountDownCommand:IsExecExcluded()
  return 0
end

function SyncClientUnscaledCountDownCommand:DependRoundCount()
  return false
end

function SyncClientUnscaledCountDownCommand:GetCmdFlagID()
  return self._flagID
end

function SyncClientUnscaledCountDownCommand:SetCmdFlagID(flagID)
  self._flagID = flagID
end

function SyncClientUnscaledCountDownCommand:GetCmdState()
  return self._state
end

function SyncClientUnscaledCountDownCommand:SetCmdState(state)
  self._state = state
end

function SyncClientUnscaledCountDownCommand:ToNetMessage()
  local msg = CEventSyncClientUnscaledCountDownCommand:New()
  msg.EntityID = self.EntityID
  msg.RoundCount = self.RoundCount
  msg.ClientWaitInput = self.ClientWaitInput
  msg.CmdIndex = self.CmdIndex
  msg.IsAutoFight = self.IsAutoFight
  msg.flagID = self._flagID
  msg.state = self._state
  return msg
end

function SyncClientUnscaledCountDownCommand:FromNetMessage(msg)
  self.EntityID = msg.EntityID
  self.RoundCount = msg.RoundCount
  self.ClientWaitInput = msg.ClientWaitInput
  self.CmdIndex = msg.CmdIndex
  self.IsAutoFight = msg.IsAutoFight
  self._flagID = msg.flagID
  self._state = msg.state
end
