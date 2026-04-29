require("buff_logic_base")
_class("BuffLogicGuardDamageFromTeamMember", BuffLogicBase)
BuffLogicGuardDamageFromTeamMember = BuffLogicGuardDamageFromTeamMember

function BuffLogicGuardDamageFromTeamMember:Constructor(buffInstance, logicParam)
end

function BuffLogicGuardDamageFromTeamMember:DoLogic(notify)
  if not self._entity:HasMonsterID() then
    return
  end
  local cpt = self._buffInstance:Entity():Attributes()
  cpt:SetSimpleAttribute("BuffGuardDamageFromTeamMember", 1)
end

_class("BuffLogicRemoveGuardDamageFromTeamMember", BuffLogicBase)
BuffLogicRemoveGuardDamageFromTeamMember = BuffLogicRemoveGuardDamageFromTeamMember

function BuffLogicRemoveGuardDamageFromTeamMember:Constructor(buffInstance, logicParam)
end

function BuffLogicRemoveGuardDamageFromTeamMember:DoLogic(notify)
  local cpt = self._buffInstance:Entity():Attributes()
  cpt:RemoveSimpleAttribute("BuffGuardDamageFromTeamMember")
end
