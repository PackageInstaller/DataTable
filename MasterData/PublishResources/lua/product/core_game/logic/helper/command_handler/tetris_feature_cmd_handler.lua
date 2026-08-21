require("command_base_handler")
_class("TetrisFeatureCommandHandler", CommandBaseHandler)
TetrisFeatureCommandHandler = TetrisFeatureCommandHandler

function TetrisFeatureCommandHandler:DoHandleCommand(cmd)
  local opType = cmd:GetOPType()
  local opValue = cmd:GetOPValue()
  local featureSvcL = self._world:GetService("FeatureLogic")
  if opType == TetrisFeatureCmdOPType.ReRoll then
    local newTetrisIndex, newTetrisType = featureSvcL:RandomTetrisIndex(true, true)
    local newPower = featureSvcL:GetTetrisPower()
    opValue = {
      newTetrisIndex,
      newTetrisType,
      newPower
    }
  elseif opType == TetrisFeatureCmdOPType.Lock then
    featureSvcL:SetTetrisLock(opValue)
  end
  if self._world:RunAtClient() then
    local featureSvcR = self._world:GetService("FeatureRender")
    featureSvcR:NotifyTetrisOP(opType, opValue)
  end
end
