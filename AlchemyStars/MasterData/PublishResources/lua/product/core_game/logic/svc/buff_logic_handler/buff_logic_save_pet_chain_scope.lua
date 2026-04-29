_class("BuffLogicSavePetChainScope", BuffLogicBase)
BuffLogicSavePetChainScope = BuffLogicSavePetChainScope

function BuffLogicSavePetChainScope:Constructor(buffInstance, logicParam)
end

function BuffLogicSavePetChainScope:DoLogic()
  local buffComponent = self._entity:BuffComponent()
  buffComponent:SetBuffValue("SavePetChainScope", 0)
end
