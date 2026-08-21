_class("BuffLogicAtkImmunity", BuffLogicBase)
BuffLogicAtkImmunity = BuffLogicAtkImmunity

function BuffLogicAtkImmunity:Constructor(buffInstance, logicParam)
end

function BuffLogicAtkImmunity:DoLogic(notify)
  local cpt = self._buffInstance:Entity():Attributes()
  cpt:SetSimpleAttribute("BuffAtkImmunity", 1)
  return true
end

_class("BuffLogicRemoveAtkImmunity", BuffLogicBase)
BuffLogicRemoveAtkImmunity = BuffLogicRemoveAtkImmunity

function BuffLogicRemoveAtkImmunity:Constructor(buffInstance, logicParam)
end

function BuffLogicRemoveAtkImmunity:DoLogic(notify)
  local cpt = self._buffInstance:Entity():Attributes()
  cpt:RemoveSimpleAttribute("BuffAtkImmunity")
  return true
end
