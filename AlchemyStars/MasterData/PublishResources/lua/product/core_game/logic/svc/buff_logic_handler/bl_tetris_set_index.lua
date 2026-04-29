require("buff_logic_base")
_class("BuffLogicTetrisSetIndex", BuffLogicBase)
BuffLogicTetrisSetIndex = BuffLogicTetrisSetIndex

function BuffLogicTetrisSetIndex:Constructor(buffInstance, logicParam)
  self._index = logicParam.index
end

function BuffLogicTetrisSetIndex:DoLogic(notify)
  local featureSvcL = self._world:GetService("FeatureLogic")
  local newTetrisType = featureSvcL:SetTetrisIndex(self._index)
  Log.fatal("BuffLogicTetrisSetIndex index:", self._index, "NewTetrisType:", newTetrisType)
  local result = BuffResultTetrisRandom:New(self._index, newTetrisType)
  return result
end
