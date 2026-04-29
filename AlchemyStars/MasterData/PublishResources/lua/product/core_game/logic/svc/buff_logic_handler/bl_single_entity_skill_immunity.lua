_class("BuffLogicSingleEntitySkillImmunity", BuffLogicBase)
BuffLogicSingleEntitySkillImmunity = BuffLogicSingleEntitySkillImmunity

function BuffLogicSingleEntitySkillImmunity:Constructor(buffInstance, logicParam)
end

function BuffLogicSingleEntitySkillImmunity:DoLogic(notify)
  local cpt = self._buffInstance:Entity():Attributes()
  cpt:SetSimpleAttribute("BuffSingleEntitySkillImmunity", 1)
  return true
end

_class("BuffLogicRemoveSingleEntitySkillImmunity", BuffLogicBase)
BuffLogicRemoveSingleEntitySkillImmunity = BuffLogicRemoveSingleEntitySkillImmunity

function BuffLogicRemoveSingleEntitySkillImmunity:Constructor(buffInstance, logicParam)
end

function BuffLogicRemoveSingleEntitySkillImmunity:DoLogic(notify)
  local cpt = self._buffInstance:Entity():Attributes()
  cpt:RemoveSimpleAttribute("BuffSingleEntitySkillImmunity")
  return true
end
