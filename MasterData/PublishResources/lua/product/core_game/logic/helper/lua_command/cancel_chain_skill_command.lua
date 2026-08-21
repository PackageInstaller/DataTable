require("entity_commands")
_class("CancelChainSkillCommand", IEntityCommand)
CancelChainSkillCommand = CancelChainSkillCommand

function CancelChainSkillCommand:Constructor()
  self._commandType = "CancelChainSkill"
end

function CancelChainSkillCommand:GetCommandType()
  return self._commandType
end

function CancelChainSkillCommand:GetExecStateID()
  return 0
end

function CancelChainSkillCommand:IsExecExcluded()
  return 0
end

function CancelChainSkillCommand:DependRoundCount()
  return true
end

function CancelChainSkillCommand:ToNetMessage()
  local msg = CEventCancelChainSkillCommand:New()
  msg.EntityID = self.EntityID
  msg.RoundCount = self.RoundCount
  msg.ClientWaitInput = self.ClientWaitInput
  msg.CmdIndex = self.CmdIndex
  msg.IsAutoFight = self.IsAutoFight
  return msg
end

function CancelChainSkillCommand:FromNetMessage(msg)
  self.EntityID = msg.EntityID
  self.RoundCount = msg.RoundCount
  self.ClientWaitInput = msg.ClientWaitInput
  self.CmdIndex = msg.CmdIndex
  self.IsAutoFight = msg.IsAutoFight
end
