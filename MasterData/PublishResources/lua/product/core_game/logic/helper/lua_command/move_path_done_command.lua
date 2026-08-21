_class("MovePathDoneCommand", IEntityCommand)
MovePathDoneCommand = MovePathDoneCommand

function MovePathDoneCommand:Constructor()
  self._commandType = "MovePathDone"
  self._chainPath = {}
  self._elementType = 0
  self._activeSkillID = 0
  self._casterPstID = 0
end

function MovePathDoneCommand:GetCommandType()
  return self._commandType
end

function MovePathDoneCommand:GetExecStateID(runAtClient)
  if runAtClient then
    return {
      GameStateID.PickUpActiveSkillTarget,
      GameStateID.WaitInput
    }
  else
    return GameStateID.WaitInput
  end
end

function MovePathDoneCommand:IsExecExcluded()
  return 1
end

function MovePathDoneCommand:DependRoundCount()
  return true
end

function MovePathDoneCommand:GetChainPath()
  return self._chainPath
end

function MovePathDoneCommand:GetElementType()
  return self._elementType
end

function MovePathDoneCommand:SetChainPath(path)
  self._chainPath = path
end

function MovePathDoneCommand:SetElementType(type)
  self._elementType = type
end

function MovePathDoneCommand:SetActiveSkillID(activeSkillID)
  self._activeSkillID = activeSkillID
end

function MovePathDoneCommand:GetActiveSkillID()
  return self._activeSkillID
end

function MovePathDoneCommand:SetCasterPstID(pstID)
  self._casterPstID = pstID
end

function MovePathDoneCommand:GetCasterPstID()
  return self._casterPstID
end

function MovePathDoneCommand:ToNetMessage()
  local msg = CEventMovePathDoneCommand:New()
  msg.EntityID = self.EntityID
  msg.RoundCount = self.RoundCount
  msg.ClientWaitInput = self.ClientWaitInput
  msg.IsAutoFight = self.IsAutoFight
  msg.CmdIndex = self.CmdIndex
  msg.ActiveSkillID = self._activeSkillID
  msg.CasterPstID = self._casterPstID
  msg.ElementType = self._elementType
  for i, pos in ipairs(self._chainPath) do
    msg.ChainPath[#msg.ChainPath + 1] = Vector2.Pos2Index(pos)
  end
  return msg
end

function MovePathDoneCommand:FromNetMessage(msg)
  self.EntityID = msg.EntityID
  self.RoundCount = msg.RoundCount
  self.ClientWaitInput = msg.ClientWaitInput
  self.IsAutoFight = msg.IsAutoFight
  self.CmdIndex = msg.CmdIndex
  self._elementType = msg.ElementType
  self._activeSkillID = msg.ActiveSkillID
  self._casterPstID = msg.CasterPstID
  Log.info("MovePathDoneCommand CasterPstID: ", msg.CasterPstID, " ActiveSkillID: ", msg.ActiveSkillID)
  for i, v in ipairs(msg.ChainPath) do
    self._chainPath[#self._chainPath + 1] = Vector2.Index2Pos(v)
  end
end
