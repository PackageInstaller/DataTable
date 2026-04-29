_class("BuffLogicSetForbidChain", BuffLogicBase)
BuffLogicSetForbidChain = BuffLogicSetForbidChain

function BuffLogicSetForbidChain:Constructor(buffInstance, logicParam)
end

function BuffLogicSetForbidChain:DoLogic()
  local e = self._buffInstance:Entity()
  local buffComponent = e:BuffComponent()
  local entityService = self._world:GetService("LogicEntity")
  buffComponent:SetBuffValue("ForbidChainFlag", 1)
  return true
end

_class("BuffLogicResetForbidChain", BuffLogicBase)
BuffLogicResetForbidChain = BuffLogicResetForbidChain

function BuffLogicSetForbidChain:Constructor(buffInstance, logicParam)
end

function BuffLogicResetForbidChain:DoLogic()
  local e = self._buffInstance:Entity()
  local buffComponent = e:BuffComponent()
  local entityService = self._world:GetService("LogicEntity")
  buffComponent:SetBuffValue("ForbidChainFlag", nil)
  return true
end
