require("buff_logic_base")
_class("BuffLogicSetNoDeadDamage", BuffLogicBase)
BuffLogicSetNoDeadDamage = BuffLogicSetNoDeadDamage

function BuffLogicSetNoDeadDamage:Constructor(buffInstance, logicParam)
end

function BuffLogicSetNoDeadDamage:DoLogic()
  local entity = self._buffInstance:Entity()
  local attributeCmpt = entity:Attributes()
  attributeCmpt:SetSimpleAttribute("NoDeadDamage", 1)
end

_class("BuffLogicResetNoDeadDamage", BuffLogicBase)
BuffLogicResetNoDeadDamage = BuffLogicResetNoDeadDamage

function BuffLogicResetNoDeadDamage:Constructor(buffInstance, logicParam)
end

function BuffLogicResetNoDeadDamage:DoLogic()
  local entity = self._buffInstance:Entity()
  local attributeCmpt = entity:Attributes()
  attributeCmpt:SetSimpleAttribute("NoDeadDamage", 0)
end
