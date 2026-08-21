_class("BuffLogicDebuffImmunity", BuffLogicBase)
BuffLogicDebuffImmunity = BuffLogicDebuffImmunity

function BuffLogicDebuffImmunity:Constructor(buffInstance, logicParam)
end

function BuffLogicDebuffImmunity:DoLogic(notify)
  local cpt = self._buffInstance:Entity():Attributes()
  cpt:SetSimpleAttribute("DebuffImmunity", 1)
end

_class("BuffLogicRemoveDebuffImmunity", BuffLogicBase)
BuffLogicRemoveDebuffImmunity = BuffLogicRemoveDebuffImmunity

function BuffLogicRemoveDebuffImmunity:Constructor(buffInstance, logicParam)
end

function BuffLogicRemoveDebuffImmunity:DoLogic(notify)
  local cpt = self._buffInstance:Entity():Attributes()
  cpt:RemoveSimpleAttribute("DebuffImmunity")
end
