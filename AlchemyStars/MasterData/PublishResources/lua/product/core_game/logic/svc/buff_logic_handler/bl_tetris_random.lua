require("buff_logic_base")
_class("BuffLogicTetrisRandom", BuffLogicBase)
BuffLogicTetrisRandom = BuffLogicTetrisRandom

function BuffLogicTetrisRandom:Constructor(buffInstance, logicParam)
  self._needPower = logicParam.needPower
end

function BuffLogicTetrisRandom:DoLogic(notify)
  local featureSvcL = self._world:GetService("FeatureLogic")
  local canRandom = true
  if self._needPower then
    canRandom = featureSvcL:SubTetrisPower()
  end
  if canRandom then
    local newTetrisIndex, newTetrisType = featureSvcL:RandomTetrisIndex(false, false)
    local result = BuffResultTetrisRandom:New(newTetrisIndex, newTetrisType)
    return result
  end
end
