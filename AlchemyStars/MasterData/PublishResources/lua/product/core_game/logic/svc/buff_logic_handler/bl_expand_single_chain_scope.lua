_class("BuffLogicExpandSingleChainScope", BuffLogicBase)
BuffLogicExpandSingleChainScope = BuffLogicExpandSingleChainScope

function BuffLogicExpandSingleChainScope:Constructor(_buffIns, logicParam)
  self._addCount = logicParam.addCount
end

function BuffLogicExpandSingleChainScope:DoLogic()
  self._entity:BuffComponent():SetBuffValue("ExpandSingleChainScope", self._addCount)
end

_class("BuffLogicRevertExpandSingleChainScope", BuffLogicBase)
BuffLogicRevertExpandSingleChainScope = BuffLogicRevertExpandSingleChainScope

function BuffLogicRevertExpandSingleChainScope:Constructor(_buffIns, logicParam)
end

function BuffLogicRevertExpandSingleChainScope:DoLogic()
  self._entity:BuffComponent():SetBuffValue("ExpandSingleChainScope", nil)
end
