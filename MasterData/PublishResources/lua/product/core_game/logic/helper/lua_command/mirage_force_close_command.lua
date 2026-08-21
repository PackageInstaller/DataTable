_class("MirageForceCloseCommand", IEntityCommand)
MirageForceCloseCommand = MirageForceCloseCommand
MirageForceCloseCommand.CommandType = "MirageForceClose"

function MirageForceCloseCommand:Constructor()
end

function MirageForceCloseCommand:GetCommandType()
  return MirageForceCloseCommand.CommandType
end

function MirageForceCloseCommand:GetExecStateID(runAtClient)
  return 0
end

function MirageForceCloseCommand:IsExecExcluded()
  return 1
end

function MirageForceCloseCommand:DependRoundCount()
  return true
end

function MirageForceCloseCommand:ToNetMessage()
  local msg = CEventMirageForceCloseCommand:New()
  msg.EntityID = self.EntityID
  msg.RoundCount = self.RoundCount
  msg.ClientWaitInput = self.ClientWaitInput
  msg.IsAutoFight = self.IsAutoFight
  msg.CmdIndex = self.CmdIndex
  return msg
end

function MirageForceCloseCommand:FromNetMessage(msg)
  self.EntityID = msg.EntityID
  self.RoundCount = msg.RoundCount
  self.ClientWaitInput = msg.ClientWaitInput
  self.IsAutoFight = msg.IsAutoFight
  self.CmdIndex = msg.CmdIndex
end
