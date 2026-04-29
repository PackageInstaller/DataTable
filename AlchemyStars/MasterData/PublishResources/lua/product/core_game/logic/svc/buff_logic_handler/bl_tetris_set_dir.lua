require("buff_logic_base")
_class("BuffLogicTetrisSetDirIndex", BuffLogicBase)
BuffLogicTetrisSetDirIndex = BuffLogicTetrisSetDirIndex

function BuffLogicTetrisSetDirIndex:Constructor(buffInstance, logicParam)
  self._index = logicParam.index
end

function BuffLogicTetrisSetDirIndex:DoLogic(notify)
  local featureSvcL = self._world:GetService("FeatureLogic")
  featureSvcL:SetTetrisDirIndex(self._index)
  Log.fatal("BuffLogicTetrisSetDirIndex index:", self._index)
end
