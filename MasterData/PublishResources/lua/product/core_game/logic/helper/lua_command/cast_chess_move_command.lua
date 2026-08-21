_class("CastChessMoveCommand", IEntityCommand)
CastChessMoveCommand = CastChessMoveCommand

function CastChessMoveCommand:Constructor()
  self._commandType = "CastChessMove"
  self._casterEntityID = -1
  self._chessPath = {}
end

function CastChessMoveCommand:GetCommandType()
  return self._commandType
end

function CastChessMoveCommand:GetExecStateID(runAtClient)
  if runAtClient then
    return GameStateID.PickUpChessPet
  else
    return GameStateID.WaitInput
  end
end

function CastChessMoveCommand:IsExecExcluded()
  return 1
end

function CastChessMoveCommand:DependRoundCount()
  return true
end

function CastChessMoveCommand:GetCmdCasterEntityID()
  return self._casterEntityID
end

function CastChessMoveCommand:GetCmdChessPath()
  return self._chessPath
end

function CastChessMoveCommand:SetCmdCasterEntityID(casterEntityID)
  self._casterEntityID = casterEntityID
end

function CastChessMoveCommand:SetCmdChessPath(chessPath)
  self._chessPath = chessPath
end

function CastChessMoveCommand:ToNetMessage()
  local msg = CEventCastChessPetMoveCommand:New()
  msg.EntityID = self.EntityID
  msg.RoundCount = self.RoundCount
  msg.ClientWaitInput = self.ClientWaitInput
  msg.IsAutoFight = self.IsAutoFight
  msg.CmdIndex = self.CmdIndex
  msg.casterEntityID = self:GetCmdCasterEntityID()
  for i, pos in ipairs(self._chessPath) do
    msg.chessPath[#msg.chessPath + 1] = Vector2.Pos2Index(pos)
  end
  return msg
end

function CastChessMoveCommand:FromNetMessage(msg)
  self._casterEntityID = msg.casterEntityID
  self.EntityID = msg.EntityID
  self.RoundCount = msg.RoundCount
  self.ClientWaitInput = msg.ClientWaitInput
  self.IsAutoFight = msg.IsAutoFight
  self.CmdIndex = msg.CmdIndex
  for i, v in ipairs(msg.chessPath) do
    self._chessPath[#self._chessPath + 1] = Vector2.Index2Pos(v)
  end
end
