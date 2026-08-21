_class("BuffLogicSetPetForceChain", BuffLogicBase)
BuffLogicSetPetForceChain = BuffLogicSetPetForceChain

function BuffLogicSetPetForceChain:Constructor(buffInstance, logicParam)
  self._value = logicParam.value or 0
end

function BuffLogicSetPetForceChain:DoLogic()
  local e = self._buffInstance:Entity()
  e:BuffComponent():SetBuffValue("PetForceChain", self._value)
end
