require("buff_logic_base")
_class("BuffLogicElementImmunity", BuffLogicBase)
BuffLogicElementImmunity = BuffLogicElementImmunity

function BuffLogicElementImmunity:Constructor(buffInstance, logicParam)
  self._element = logicParam.element
end

function BuffLogicElementImmunity:DoLogic(notify)
  local cpt = self._buffInstance:Entity():Attributes()
  cpt:SetSimpleAttribute("BuffElementImmunity", self._element)
end

_class("BuffLogicRemoveElementImmunity", BuffLogicBase)
BuffLogicRemoveElementImmunity = BuffLogicRemoveElementImmunity

function BuffLogicRemoveElementImmunity:Constructor(buffInstance, logicParam)
end

function BuffLogicRemoveElementImmunity:DoLogic(notify)
  local cpt = self._buffInstance:Entity():Attributes()
  cpt:RemoveSimpleAttribute("BuffElementImmunity")
end
