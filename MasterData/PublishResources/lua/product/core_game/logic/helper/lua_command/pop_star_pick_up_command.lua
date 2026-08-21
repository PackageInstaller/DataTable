_class("PopStarPickUpCommand", IEntityCommand)
PopStarPickUpCommand = PopStarPickUpCommand
PopStarPickUpCommand.CommandType = "PopStarPickUp"

function PopStarPickUpCommand:Constructor()
  self._gridPos = Vector2.zero
  self._connectPieces = {}
end

function PopStarPickUpCommand:GetCommandType()
  return PopStarPickUpCommand.CommandType
end

function PopStarPickUpCommand:GetExecStateID(runAtClient)
  return GameStateID.WaitInput
end

function PopStarPickUpCommand:DependRoundCount()
  return true
end

function PopStarPickUpCommand:GetCmdPickUpPos()
  return self._gridPos
end

function PopStarPickUpCommand:SetCmdPickUpPos(gridPos)
  self._gridPos = gridPos
end

function PopStarPickUpCommand:GetCmdConnectPieces()
  return self._connectPieces
end

function PopStarPickUpCommand:SetCmdConnectPieces(pieces)
  self._connectPieces = pieces
end

function PopStarPickUpCommand:ToNetMessage()
  local msg = CEventPopStarPickUpCommand:New()
  msg.EntityID = self.EntityID
  msg.RoundCount = self.RoundCount
  msg.ClientWaitInput = self.ClientWaitInput
  msg.IsAutoFight = self.IsAutoFight
  msg.CmdIndex = self.CmdIndex
  msg.gridPos = Vector2.Pos2Index(self._gridPos)
  for _, pos in ipairs(self._connectPieces) do
    msg.connectPieces[#msg.connectPieces + 1] = Vector2.Pos2Index(pos)
  end
  return msg
end

function PopStarPickUpCommand:FromNetMessage(msg)
  self.EntityID = msg.EntityID
  self.RoundCount = msg.RoundCount
  self.ClientWaitInput = msg.ClientWaitInput
  self.IsAutoFight = msg.IsAutoFight
  self.CmdIndex = msg.CmdIndex
  self._gridPos = Vector2.Index2Pos(msg.gridPos)
  for _, v in ipairs(msg.connectPieces) do
    self._connectPieces[#self._connectPieces + 1] = Vector2.Index2Pos(v)
  end
end
