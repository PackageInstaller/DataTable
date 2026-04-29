_class("ChangeTeamLeaderCommand", IEntityCommand)
ChangeTeamLeaderCommand = ChangeTeamLeaderCommand

function ChangeTeamLeaderCommand:Constructor()
  self._commandType = "ChangeTeamLeader"
  self._newLeaderPstID = nil
  self._oldLeaderPstID = nil
end

function ChangeTeamLeaderCommand:GetCommandType()
  return self._commandType
end

function ChangeTeamLeaderCommand:GetExecStateID()
  return GameStateID.WaitInput
end

function ChangeTeamLeaderCommand:IsExecExcluded()
  return 0
end

function ChangeTeamLeaderCommand:DependRoundCount()
  return true
end

function ChangeTeamLeaderCommand:GetNewLeaderPstID()
  return self._newLeaderPstID
end

function ChangeTeamLeaderCommand:GetOldLeaderPstID()
  return self._oldLeaderPstID
end

function ChangeTeamLeaderCommand:SetNewTeamLeaderPstID(petPstID)
  self._newLeaderPstID = petPstID
end

function ChangeTeamLeaderCommand:SetOldTeamLeaderPstID(petPstID)
  self._oldLeaderPstID = petPstID
end

function ChangeTeamLeaderCommand:ToNetMessage()
  local msg = CEventChangeTeamLeaderCommand:New()
  msg.EntityID = self.EntityID
  msg.RoundCount = self.RoundCount
  msg.ClientWaitInput = self.ClientWaitInput
  msg.IsAutoFight = self.IsAutoFight
  msg.CmdIndex = self.CmdIndex
  msg.OldLeaderPstID = self._oldLeaderPstID
  msg.NewLeaderPstID = self._newLeaderPstID
  return msg
end

function ChangeTeamLeaderCommand:FromNetMessage(msg)
  self.EntityID = msg.EntityID
  self.RoundCount = msg.RoundCount
  self.ClientWaitInput = msg.ClientWaitInput
  self.IsAutoFight = msg.IsAutoFight
  self.CmdIndex = msg.CmdIndex
  self._oldLeaderPstID = msg.OldLeaderPstID
  self._newLeaderPstID = msg.NewLeaderPstID
end
