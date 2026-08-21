require("match_message")
_class("ScanFeatureCommand", IEntityCommand)
ScanFeatureCommand = ScanFeatureCommand
ScanFeatureCommand.CommandType = "ScanFeatureCommand"

function ScanFeatureCommand:Constructor(teamEntityID, skillType, trapID)
  self.EntityID = teamEntityID
  self._activeSkillType = skillType
  self._trapID = trapID
end

function ScanFeatureCommand:GetActiveSkillType()
  return self._activeSkillType
end

function ScanFeatureCommand:GetScanTrapID()
  return self._trapID
end

function ScanFeatureCommand:GetExecStateID(runAtClient)
  return GameStateID.WaitInput
end

function ScanFeatureCommand:GetCommandType()
  return ScanFeatureCommand.CommandType
end

function ScanFeatureCommand:ToNetMessage()
  local msg = CEventScanFeatureCommand:New()
  msg.EntityID = self.EntityID
  msg.ActiveSkillType = self._activeSkillType
  msg.TrapID = self._trapID
  return msg
end

function ScanFeatureCommand:FromNetMessage(msg)
  self.EntityID = msg.EntityID
  self._activeSkillType = msg.ActiveSkillType
  self._trapID = msg.TrapID
end
