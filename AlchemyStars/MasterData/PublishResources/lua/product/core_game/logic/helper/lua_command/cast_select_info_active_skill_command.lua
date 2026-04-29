_class("CastSelectInfoActiveSkillCommand", IEntityCommand)
CastSelectInfoActiveSkillCommand = CastSelectInfoActiveSkillCommand
CastSelectInfoActiveSkillCommand.CommandType = "CastSelectInfoActiveSkill"

function CastSelectInfoActiveSkillCommand:Constructor()
  self._commandType = "CastSelectInfoActiveSkill"
  self._activeSkillID = -1
  self._casterPstID = -1
  self._selectInfoList = {}
end

function CastSelectInfoActiveSkillCommand:GetExecStateID(runAtClient)
  if runAtClient then
    return GameStateID.PreviewActiveSkill
  else
    return GameStateID.WaitInput
  end
end

function CastSelectInfoActiveSkillCommand:GetCommandType()
  return CastSelectInfoActiveSkillCommand.CommandType
end

function CastSelectInfoActiveSkillCommand:IsExecExcluded()
  return 1
end

function CastSelectInfoActiveSkillCommand:DependRoundCount()
  return true
end

function CastSelectInfoActiveSkillCommand:GetCmdActiveSkillID()
  return self._activeSkillID
end

function CastSelectInfoActiveSkillCommand:GetCmdCasterPstID()
  return self._casterPstID
end

function CastSelectInfoActiveSkillCommand:SetCmdActiveSkillID(activeSkillID)
  self._activeSkillID = activeSkillID
end

function CastSelectInfoActiveSkillCommand:SetCmdCasterPstID(pstID)
  self._casterPstID = pstID
end

function CastSelectInfoActiveSkillCommand:SetCmdSelectInfo(result)
  if result then
    self._selectInfoList = {}
    for _, v in ipairs(result) do
      table.insert(self._selectInfoList, v)
    end
  end
end

function CastSelectInfoActiveSkillCommand:GetCmdSelectInfo()
  return self._selectInfoList
end

function CastSelectInfoActiveSkillCommand:ToNetMessage()
  local msg = CEventCastSelectInfoActiveSkillCommand:New()
  msg.EntityID = self.EntityID
  msg.RoundCount = self.RoundCount
  msg.ClientWaitInput = self.ClientWaitInput
  msg.IsAutoFight = self.IsAutoFight
  msg.CmdIndex = self.CmdIndex
  msg.ActiveSkillID = self._activeSkillID
  msg.CasterPstID = self._casterPstID
  for i, v in ipairs(self._selectInfoList) do
    msg.SelectInfoList[#msg.SelectInfoList + 1] = v
  end
  return msg
end

function CastSelectInfoActiveSkillCommand:FromNetMessage(msg)
  self.EntityID = msg.EntityID
  self.RoundCount = msg.RoundCount
  self.ClientWaitInput = msg.ClientWaitInput
  self.IsAutoFight = msg.IsAutoFight
  self.CmdIndex = msg.CmdIndex
  self._activeSkillID = msg.ActiveSkillID
  self._casterPstID = msg.CasterPstID
  for i, v in ipairs(msg.SelectInfoList) do
    self._selectInfoList[#self._selectInfoList + 1] = v
  end
end
