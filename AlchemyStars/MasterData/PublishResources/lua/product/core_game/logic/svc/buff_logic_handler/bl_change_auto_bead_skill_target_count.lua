_class("BuffLogicChangeAutoBeadSkillTargetCount", BuffLogicBase)
BuffLogicChangeAutoBeadSkillTargetCount = BuffLogicChangeAutoBeadSkillTargetCount

function BuffLogicChangeAutoBeadSkillTargetCount:Constructor(buffInstance, logicParam)
  self._changeValue = logicParam.changeValue or 0
end

function BuffLogicChangeAutoBeadSkillTargetCount:DoLogic(notify)
  local cpt = self._buffInstance:Entity():Attributes()
  cpt:SetSimpleAttribute("BuffChangeAutoBeadSkillTargetCount", self._changeValue)
  return true
end

_class("BuffLogicResetChangeAutoBeadSkillTargetCount", BuffLogicBase)
BuffLogicResetChangeAutoBeadSkillTargetCount = BuffLogicResetChangeAutoBeadSkillTargetCount

function BuffLogicResetChangeAutoBeadSkillTargetCount:Constructor(buffInstance, logicParam)
end

function BuffLogicResetChangeAutoBeadSkillTargetCount:DoLogic(notify)
  local cpt = self._buffInstance:Entity():Attributes()
  cpt:SetSimpleAttribute("BuffChangeAutoBeadSkillTargetCount", 0)
  return true
end
