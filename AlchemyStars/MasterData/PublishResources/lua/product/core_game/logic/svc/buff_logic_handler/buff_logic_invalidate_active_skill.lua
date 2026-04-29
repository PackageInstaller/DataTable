_class("BuffLogicInvalidateActiveSkill", BuffLogicBase)
BuffLogicInvalidateActiveSkill = BuffLogicInvalidateActiveSkill

function BuffLogicInvalidateActiveSkill:Constructor(buffInstance, logicParam)
  self._excludeTriggerTypeTb = logicParam.excludeTriggerTypeTb
end

function BuffLogicInvalidateActiveSkill:DoLogic(notify)
  local e = self._buffInstance:Entity()
  e:BuffComponent():SetBuffValue("InvalidateActiveSkill", 1)
  e:BuffComponent():SetBuffValue("InvalidateActiveSkillExcludeTriggerType", self._excludeTriggerTypeTb)
end

_class("BuffLogicResetInvalidateActiveSkill", BuffLogicBase)
BuffLogicResetInvalidateActiveSkill = BuffLogicResetInvalidateActiveSkill

function BuffLogicResetInvalidateActiveSkill:Constructor(buffInstance, logicParam)
end

function BuffLogicResetInvalidateActiveSkill:DoLogic(notify)
  local e = self._buffInstance:Entity()
  e:BuffComponent():SetBuffValue("InvalidateActiveSkill", nil)
  e:BuffComponent():SetBuffValue("InvalidateActiveSkillExcludeTriggerType", nil)
end
