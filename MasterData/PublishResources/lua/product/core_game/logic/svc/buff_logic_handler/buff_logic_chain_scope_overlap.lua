_class("BuffLogicChainScopeOverlap", BuffLogicBase)
BuffLogicChainScopeOverlap = BuffLogicChainScopeOverlap

function BuffLogicChainScopeOverlap:Constructor(buffInstance, logicParam)
  self._changeValue = logicParam.changeValue
end

function BuffLogicChainScopeOverlap:DoLogic()
  local e = self._buffInstance:Entity()
  e:BuffComponent():SetBuffValue("ChainScopeOverlapChangeDamage", self._changeValue)
end
