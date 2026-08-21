_class("BuffLogicExpandMaxChainSkillScope", BuffLogicBase)
BuffLogicExpandMaxChainSkillScope = BuffLogicExpandMaxChainSkillScope

function BuffLogicExpandMaxChainSkillScope:Constructor(_buffIns, logicParam)
  self._scopeType = logicParam.scopeType
  self._scopeParam = logicParam.scopeParam
end

function BuffLogicExpandMaxChainSkillScope:DoLogic()
  self._entity:BuffComponent():SetBuffValue("ExpandMaxChainSkillScope", true)
  self._entity:BuffComponent():SetBuffValue("ExpandMaxChainSkillScopeType", self._scopeType)
  self._entity:BuffComponent():SetBuffValue("ExpandMaxChainSkillScopeParam", self._scopeParam)
end

_class("BuffLogicRevertExpandMaxChainSkillScope", BuffLogicBase)
BuffLogicRevertExpandMaxChainSkillScope = BuffLogicRevertExpandMaxChainSkillScope

function BuffLogicRevertExpandMaxChainSkillScope:Constructor(_buffIns, logicParam)
end

function BuffLogicRevertExpandMaxChainSkillScope:DoLogic()
  self._entity:BuffComponent():SetBuffValue("ExpandMaxChainSkillScope", nil)
end
