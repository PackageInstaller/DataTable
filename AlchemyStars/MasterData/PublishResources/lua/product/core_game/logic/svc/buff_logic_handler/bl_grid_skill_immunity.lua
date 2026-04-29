_class("BuffLogicGridSkillImmunity", BuffLogicBase)
BuffLogicGridSkillImmunity = BuffLogicGridSkillImmunity

function BuffLogicGridSkillImmunity:Constructor(buffInstance, logicParam)
end

function BuffLogicGridSkillImmunity:DoLogic(notify)
  local cpt = self._buffInstance:Entity():Attributes()
  cpt:SetSimpleAttribute("BuffGridSkillImmunity", 1)
  return true
end

_class("BuffLogicRemoveGridSkillImmunity", BuffLogicBase)
BuffLogicRemoveGridSkillImmunity = BuffLogicRemoveGridSkillImmunity

function BuffLogicRemoveGridSkillImmunity:Constructor(buffInstance, logicParam)
end

function BuffLogicRemoveGridSkillImmunity:DoLogic(notify)
  local cpt = self._buffInstance:Entity():Attributes()
  cpt:RemoveSimpleAttribute("BuffGridSkillImmunity")
  return true
end
