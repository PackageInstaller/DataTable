_class("BuffLogicSetOverloadState", BuffLogicBase)
BuffLogicSetOverloadState = BuffLogicSetOverloadState

function BuffLogicSetOverloadState:Constructor(buffInstance, logicParam)
end

function BuffLogicSetOverloadState:DoLogic(notify)
  local cpt = self._buffInstance:Entity():Attributes()
  cpt:SetSimpleAttribute("BuffOverloadState", 1)
  return true
end

_class("BuffLogicResetOverloadState", BuffLogicBase)
BuffLogicResetOverloadState = BuffLogicResetOverloadState

function BuffLogicResetOverloadState:Constructor(buffInstance, logicParam)
end

function BuffLogicResetOverloadState:DoLogic(notify)
  local cpt = self._buffInstance:Entity():Attributes()
  cpt:SetSimpleAttribute("BuffOverloadState", 0)
  return true
end
