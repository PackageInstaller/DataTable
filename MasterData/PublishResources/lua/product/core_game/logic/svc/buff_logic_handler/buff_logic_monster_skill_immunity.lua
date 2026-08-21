_class("BuffLogicMonsterSkillImmunity", BuffLogicBase)
BuffLogicMonsterSkillImmunity = BuffLogicMonsterSkillImmunity

function BuffLogicMonsterSkillImmunity:Constructor(buffInstance, logicParam)
end

function BuffLogicMonsterSkillImmunity:DoLogic(notify)
  if not self._buffInstance:Entity():HasMonsterID() then
    Log.fatal("只能给怪挂技能免疫buff!")
    return true
  end
  local cpt = self._buffInstance:Entity():Attributes()
  cpt:SetSimpleAttribute("BuffMonsterSkillImmunity", 1)
  return true
end

_class("BuffLogicRemoveMonsterSkillImmunity", BuffLogicBase)
BuffLogicRemoveMonsterSkillImmunity = BuffLogicRemoveMonsterSkillImmunity

function BuffLogicRemoveMonsterSkillImmunity:Constructor(buffInstance, logicParam)
end

function BuffLogicRemoveMonsterSkillImmunity:DoLogic(notify)
  local cpt = self._buffInstance:Entity():Attributes()
  cpt:RemoveSimpleAttribute("BuffMonsterSkillImmunity")
  return true
end
