_class("BuffLogicAddNormalSkillEvade", BuffLogicBase)
BuffLogicAddNormalSkillEvade = BuffLogicAddNormalSkillEvade

function BuffLogicAddNormalSkillEvade:Constructor(buffInstance, logicParam)
  self._evade = logicParam.evade
end

function BuffLogicAddNormalSkillEvade:DoLogic()
  local e = self._buffInstance:Entity()
  e:BuffComponent():AddBuffValue("NormalSkillEvade", self._evade)
end

_class("BuffLogicRemoveNormalSkillEvade", BuffLogicBase)
BuffLogicRemoveNormalSkillEvade = BuffLogicRemoveNormalSkillEvade

function BuffLogicRemoveNormalSkillEvade:Constructor(buffInstance, logicParam)
end

function BuffLogicRemoveNormalSkillEvade:DoLogic()
  local e = self._buffInstance:Entity()
  e:BuffComponent():SetBuffValue("NormalSkillEvade", 0)
end
