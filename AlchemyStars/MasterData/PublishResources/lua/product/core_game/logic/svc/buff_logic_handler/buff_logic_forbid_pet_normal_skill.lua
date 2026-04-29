_class("BuffLogicForbidPetNormalSkill", BuffLogicBase)
BuffLogicForbidPetNormalSkill = BuffLogicForbidPetNormalSkill

function BuffLogicForbidPetNormalSkill:Constructor(buffInstance, logicParam)
end

function BuffLogicForbidPetNormalSkill:DoLogic(notify)
  local e = self._buffInstance:Entity()
  e:BuffComponent():SetBuffValue("ForbidPetNormalSkill", true)
end

_class("BuffLogicUndoForbidPetNormalSkill", BuffLogicBase)
BuffLogicUndoForbidPetNormalSkill = BuffLogicUndoForbidPetNormalSkill

function BuffLogicUndoForbidPetNormalSkill:Constructor(buffInstance, logicParam)
end

function BuffLogicUndoForbidPetNormalSkill:DoLogic()
  local e = self._buffInstance:Entity()
  e:BuffComponent():SetBuffValue("ForbidPetNormalSkill", nil)
end
