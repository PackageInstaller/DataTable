_class("BuffLogicSetExtraChain", BuffLogicBase)
BuffLogicSetExtraChain = BuffLogicSetExtraChain

function BuffLogicSetExtraChain:Constructor(buffInstance, logicParam)
end

function BuffLogicSetExtraChain:DoLogic()
  local e = self._buffInstance:Entity()
  local buffComponent = e:BuffComponent()
  buffComponent:SetBuffValue("ExtraChainFlag", 1)
  return true
end

_class("BuffLogicResetExtraChain", BuffLogicBase)
BuffLogicResetExtraChain = BuffLogicResetExtraChain

function BuffLogicResetExtraChain:Constructor(buffInstance, logicParam)
end

function BuffLogicResetExtraChain:DoLogic()
  local e = self._buffInstance:Entity()
  local buffComponent = e:BuffComponent()
  local entityService = self._world:GetService("LogicEntity")
  local shadowEntity = entityService:_CreateTeamMemberShadow(e)
  buffComponent:SetBuffValue("ExtraChainFlag", nil)
  return true
end
