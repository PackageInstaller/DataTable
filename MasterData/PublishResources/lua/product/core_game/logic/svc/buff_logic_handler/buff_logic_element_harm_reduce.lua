require("buff_logic_base")
_class("BuffLogicElementHarmReduce", BuffLogicBase)
BuffLogicElementHarmReduce = BuffLogicElementHarmReduce

function BuffLogicElementHarmReduce:Constructor(buffInstance, logicParam)
  self._element = logicParam.element
  self._rate = logicParam.rate
end

function BuffLogicElementHarmReduce:DoLogic(notify)
  if not self._entity:HasMonsterID() then
    return
  end
  local cpt = self._buffInstance:Entity():Attributes()
  if self._rate == 0 then
    cpt:SetSimpleAttribute("BuffElementImmunity", self._element)
    self._buffInstance._elementHarmReduceRate = self._rate
  else
    cpt:SetSimpleAttribute("BuffElementHarmReduce", {
      self._element,
      self._rate
    })
  end
end

_class("BuffLogicRemoveElementHarmReduce", BuffLogicBase)
BuffLogicRemoveElementHarmReduce = BuffLogicRemoveElementHarmReduce

function BuffLogicRemoveElementHarmReduce:Constructor(buffInstance, logicParam)
end

function BuffLogicRemoveElementHarmReduce:DoLogic(notify)
  local cpt = self._buffInstance:Entity():Attributes()
  local rate = self._buffInstance._elementHarmReduceRate or 1
  if rate == 0 then
    cpt:RemoveSimpleAttribute("BuffElementImmunity")
  else
    cpt:RemoveSimpleAttribute("BuffElementHarmReduce")
  end
end
