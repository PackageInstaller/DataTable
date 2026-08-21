_class("MiragePickUpCommand", IEntityCommand)
MiragePickUpCommand = MiragePickUpCommand
MiragePickUpCommand.CommandType = "MiragePickUp"

function MiragePickUpCommand:Constructor()
  self._gridPos = Vector2.zero
end

function MiragePickUpCommand:GetCommandType()
  return MiragePickUpCommand.CommandType
end

function MiragePickUpCommand:GetExecStateID(runAtClient)
  if runAtClient then
    return GameStateID.MirageWaitInput
  else
    return GameStateID.MirageWaitInput
  end
end

function MiragePickUpCommand:IsExecExcluded()
  return 1
end

function MiragePickUpCommand:DependRoundCount()
  return true
end

function MiragePickUpCommand:GetPickUpGridPos()
  return self._gridPos
end

function MiragePickUpCommand:SetPickUpGridPos(gridPos)
  self._gridPos = gridPos
end

function MiragePickUpCommand:ToNetMessage()
  local msg = CEventMiragePickUpCommand:New()
  msg.EntityID = self.EntityID
  msg.RoundCount = self.RoundCount
  msg.ClientWaitInput = self.ClientWaitInput
  msg.IsAutoFight = self.IsAutoFight
  msg.CmdIndex = self.CmdIndex
  msg.gridPos = Vector2.Pos2Index(self._gridPos)
  return msg
end

function MiragePickUpCommand:FromNetMessage(msg)
  self.EntityID = msg.EntityID
  self.RoundCount = msg.RoundCount
  self.ClientWaitInput = msg.ClientWaitInput
  self.IsAutoFight = msg.IsAutoFight
  self.CmdIndex = msg.CmdIndex
  self._gridPos = Vector2.Index2Pos(msg.gridPos)
end
