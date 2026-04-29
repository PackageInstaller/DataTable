require("match_message")
_class("TetrisFeatureCommand", IEntityCommand)
TetrisFeatureCommand = TetrisFeatureCommand
TetrisFeatureCommand.CommandType = "TetrisFeatureCommand"

function TetrisFeatureCommand:Constructor(opType, opValue)
  self._opType = opType
  self._opValue = opValue
end

function ScanFeatureCommand:GetExecStateID(runAtClient)
  return GameStateID.WaitInput
end

function TetrisFeatureCommand:GetOPValue()
  return self._opValue
end

function TetrisFeatureCommand:GetOPType()
  return self._opType
end

function TetrisFeatureCommand:GetCommandType()
  return TetrisFeatureCommand.CommandType
end

function TetrisFeatureCommand:ToNetMessage()
  local msg = CEventTetrisFeatureCommand:New()
  msg.opType = self._opType
  msg.opValue = self._opValue
  msg.EntityID = self.EntityID
  return msg
end

function TetrisFeatureCommand:FromNetMessage(msg)
  self._opType = msg.opType
  self._opValue = msg.opValue
  self.EntityID = msg.EntityID
end

local TetrisFeatureCmdOPType = {ReRoll = 1, Lock = 2}
_enum("TetrisFeatureCmdOPType", TetrisFeatureCmdOPType)
