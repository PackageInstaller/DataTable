_class("BuffLogicNormalSkillImmunity", BuffLogicBase)
BuffLogicNormalSkillImmunity = BuffLogicNormalSkillImmunity

function BuffLogicNormalSkillImmunity:Constructor(buffInstance, logicParam)
end

function BuffLogicNormalSkillImmunity:DoLogic(notify)
  local cpt = self._buffInstance:Entity():Attributes()
  cpt:SetSimpleAttribute("BuffNormalSkillImmunity", 1)
  return true
end

_class("BuffLogicRemoveNormalSkillImmunity", BuffLogicBase)
BuffLogicRemoveNormalSkillImmunity = BuffLogicRemoveNormalSkillImmunity

function BuffLogicRemoveNormalSkillImmunity:Constructor(buffInstance, logicParam)
end

function BuffLogicRemoveNormalSkillImmunity:DoLogic(notify)
  local cpt = self._buffInstance:Entity():Attributes()
  cpt:RemoveSimpleAttribute("BuffNormalSkillImmunity")
  return true
end
