_class("CastSelectTeamOrderPositionCommand", IEntityCommand)
CastSelectTeamOrderPositionCommand = CastSelectTeamOrderPositionCommand
CastSelectTeamOrderPositionCommand.CommandType = "CastSelectTeamOrderPosition"

function CastSelectTeamOrderPositionCommand:Constructor()
  self._targetPos = -1
  self._casterPstID = -1
end

function CastSelectTeamOrderPositionCommand:GetCommandType()
  return CastSelectTeamOrderPositionCommand.CommandType
end

function CastSelectTeamOrderPositionCommand:GetExecStateID(runAtClient)
  if runAtClient then
    return GameStateID.PreviewActiveSkill
  else
    return GameStateID.WaitInput
  end
end

function CastSelectTeamOrderPositionCommand:IsExecExcluded()
  return 0
end

function CastSelectTeamOrderPositionCommand:DependRoundCount()
  return true
end

function CastSelectTeamOrderPositionCommand:ToNetMessage()
  local msg = CEventCastSelectTeamOrderPositionCommand:New()
  msg.EntityID = self.EntityID
  msg.RoundCount = self.RoundCount
  msg.ClientWaitInput = self.ClientWaitInput
  msg.IsAutoFight = self.IsAutoFight
  msg.CmdIndex = self.CmdIndex
  msg.targetPos = self._targetPos
  msg.casterPstID = self._casterPstID
  return msg
end

function CastSelectTeamOrderPositionCommand:FromNetMessage(msg)
  self.EntityID = msg.EntityID
  self.RoundCount = msg.RoundCount
  self.ClientWaitInput = msg.ClientWaitInput
  self.IsAutoFight = msg.IsAutoFight
  self.CmdIndex = msg.CmdIndex
  self._targetPos = msg.targetPos
  self._casterPstID = msg.casterPstID
end

function CastSelectTeamOrderPositionCommand:GetCasterPstID()
  return self._casterPstID
end

function CastSelectTeamOrderPositionCommand:GetTargetPos()
  return self._targetPos
end

function CastSelectTeamOrderPositionCommand.GenerateCommand(teamEntityID, casterPetPstID, targetPos)
  local cmd = CastSelectTeamOrderPositionCommand:New()
  cmd._casterPstID = casterPetPstID
  cmd._targetPos = targetPos
  return cmd
end
