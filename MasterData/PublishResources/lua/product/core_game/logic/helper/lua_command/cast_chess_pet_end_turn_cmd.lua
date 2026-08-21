_class("CastChessPetEndTurnCommand", IEntityCommand)
CastChessPetEndTurnCommand = CastChessPetEndTurnCommand

function CastChessPetEndTurnCommand:Constructor()
  self._commandType = "CastChessPetEndTurn"
  self._turnType = ChessTurnEndType.Single
  self._turnEndEntityID = -1
end

function CastChessPetEndTurnCommand:GetCommandType()
  return self._commandType
end

function CastChessPetEndTurnCommand:GetExecStateID(runAtClient)
  return 0
end

function CastChessPetEndTurnCommand:IsExecExcluded()
  return 1
end

function CastChessPetEndTurnCommand:DependRoundCount()
  return true
end

function CastChessPetEndTurnCommand:GetCmdTurnType()
  return self._turnType
end

function CastChessPetEndTurnCommand:GetCmdTurnEndEntityID()
  return self._turnEndEntityID
end

function CastChessPetEndTurnCommand:SetCmdTurnType(type)
  self._turnType = type
end

function CastChessPetEndTurnCommand:SetTurnEndEntityID(entityID)
  self._turnEndEntityID = entityID
end

function CastChessPetEndTurnCommand:ToNetMessage()
  local msg = CEventCastChessPetEndTurnCommand:New()
  msg.EntityID = self.EntityID
  msg.RoundCount = self.RoundCount
  msg.ClientWaitInput = self.ClientWaitInput
  msg.IsAutoFight = self.IsAutoFight
  msg.CmdIndex = self.CmdIndex
  msg.turnType = self:GetCmdTurnType()
  msg.turnEndEntityID = self:GetCmdTurnEndEntityID()
  return msg
end

function CastChessPetEndTurnCommand:FromNetMessage(msg)
  self.EntityID = msg.EntityID
  self.RoundCount = msg.RoundCount
  self.ClientWaitInput = msg.ClientWaitInput
  self.IsAutoFight = msg.IsAutoFight
  self.CmdIndex = msg.CmdIndex
  self._turnEndEntityID = msg.turnEndEntityID
  self._turnType = msg.turnType
end
