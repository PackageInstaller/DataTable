_class("BuffLogicChangeChainSkillTargetCount", BuffLogicBase)
BuffLogicChangeChainSkillTargetCount = BuffLogicChangeChainSkillTargetCount

function BuffLogicChangeChainSkillTargetCount:Constructor(buffInstance, logicParam)
  self._changeValue = logicParam.changeValue or 0
end

function BuffLogicChangeChainSkillTargetCount:DoLogic(notify)
  local cpt = self._buffInstance:Entity():Attributes()
  cpt:SetSimpleAttribute("BuffChangeChainSkillTargetCount", self._changeValue)
  return true
end

_class("BuffLogicResetChangeChainSkillTargetCount", BuffLogicBase)
BuffLogicResetChangeChainSkillTargetCount = BuffLogicResetChangeChainSkillTargetCount

function BuffLogicResetChangeChainSkillTargetCount:Constructor(buffInstance, logicParam)
end

function BuffLogicResetChangeChainSkillTargetCount:DoLogic(notify)
  local cpt = self._buffInstance:Entity():Attributes()
  cpt:SetSimpleAttribute("BuffChangeChainSkillTargetCount", 0)
  return true
end
