_class("BuffLogicSetPreviewChainDamageScope", BuffLogicBase)
BuffLogicSetPreviewChainDamageScope = BuffLogicSetPreviewChainDamageScope

function BuffLogicSetPreviewChainDamageScope:Constructor(buffInstance, logicParam)
  self._skillID = logicParam.skillID
end

function BuffLogicSetPreviewChainDamageScope:DoLogic(notify)
  local result = BuffResultSetPreviewChainDamageScope:New(self._entity:GetID(), self._skillID)
  return result
end
