_class("BuffLogicSetForceElementRestrained", BuffLogicBase)
BuffLogicSetForceElementRestrained = BuffLogicSetForceElementRestrained

function BuffLogicSetForceElementRestrained:Constructor(buffInstance, logicParam)
end

function BuffLogicSetForceElementRestrained:DoLogic(notify)
  local cpt = self._buffInstance:Entity():Attributes()
  cpt:SetSimpleAttribute("BuffForceElementRestrained", 1)
  return true
end

_class("BuffLogicRemoveForceElementRestrained", BuffLogicBase)
BuffLogicRemoveForceElementRestrained = BuffLogicRemoveForceElementRestrained

function BuffLogicRemoveForceElementRestrained:Constructor(buffInstance, logicParam)
end

function BuffLogicRemoveForceElementRestrained:DoLogic(notify)
  local cpt = self._buffInstance:Entity():Attributes()
  cpt:RemoveSimpleAttribute("BuffForceElementRestrained")
  return true
end
