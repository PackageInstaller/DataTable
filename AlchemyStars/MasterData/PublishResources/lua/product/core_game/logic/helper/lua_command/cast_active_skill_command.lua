_class("CastActiveSkillCommand", IEntityCommand)
CastActiveSkillCommand = CastActiveSkillCommand

function CastActiveSkillCommand:Constructor()
  self._commandType = "CastActiveSkill"
  self._activeSkillID = -1
  self._casterPstID = -1
  self._casterTrapEntityID = nil
end

function CastActiveSkillCommand:GetCommandType()
  return self._commandType
end

function CastActiveSkillCommand:GetExecStateID(runAtClient)
  if runAtClient then
    return {
      GameStateID.PreviewActiveSkill,
      GameStateID.WaitInput
    }
  else
    return GameStateID.WaitInput
  end
end

function CastActiveSkillCommand:IsExecExcluded()
  return 1
end

function CastActiveSkillCommand:DependRoundCount()
  return true
end

function CastActiveSkillCommand:GetCmdActiveSkillID()
  return self._activeSkillID
end

function CastActiveSkillCommand:GetCmdCasterPstID()
  return self._casterPstID
end

function CastActiveSkillCommand:GetCmdCasterTrapEntityID()
  return self._casterTrapEntityID
end

function CastActiveSkillCommand:SetCmdActiveSkillID(activeSkillID)
  self._activeSkillID = activeSkillID
end

function CastActiveSkillCommand:SetCmdCasterPstID(pstID)
  self._casterPstID = pstID
end

function CastActiveSkillCommand:SetCmdCasterTrapEntityID(trapEntityID)
  self._casterTrapEntityID = trapEntityID
end

function CastActiveSkillCommand:ToNetMessage()
  local msg = CEventCastActiveSkillCommand:New()
  msg.EntityID = self.EntityID
  msg.RoundCount = self.RoundCount
  msg.ClientWaitInput = self.ClientWaitInput
  msg.IsAutoFight = self.IsAutoFight
  msg.CmdIndex = self.CmdIndex
  msg.ActiveSkillID = self._activeSkillID
  msg.CasterPstID = self._casterPstID
  msg.CasterTrapEntityID = self._casterTrapEntityID
  return msg
end

function CastActiveSkillCommand:FromNetMessage(msg)
  self.EntityID = msg.EntityID
  self.RoundCount = msg.RoundCount
  self.ClientWaitInput = msg.ClientWaitInput
  self.IsAutoFight = msg.IsAutoFight
  self.CmdIndex = msg.CmdIndex
  self._activeSkillID = msg.ActiveSkillID
  self._casterPstID = msg.CasterPstID
  self._casterTrapEntityID = msg.CasterTrapEntityID
end
