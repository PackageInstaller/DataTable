_class("BuffLogicSetReplaceChain", BuffLogicBase)
BuffLogicSetReplaceChain = BuffLogicSetReplaceChain

function BuffLogicSetReplaceChain:Constructor(buffInstance, logicParam)
end

function BuffLogicSetReplaceChain:DoLogic()
  local e = self._buffInstance:Entity()
  local buffComponent = e:BuffComponent()
  local replaceEntityID = buffComponent:GetBuffValue("EffectReplaceEntityID")
  buffComponent:SetBuffValue("ReplaceEntityID", replaceEntityID)
  local result = BuffResultSetReplaceChain:New(replaceEntityID)
  return result
end

_class("BuffLogicResetReplaceChain", BuffLogicBase)
BuffLogicResetReplaceChain = BuffLogicResetReplaceChain

function BuffLogicResetReplaceChain:Constructor(buffInstance, logicParam)
end

function BuffLogicResetReplaceChain:DoLogic()
  local e = self._buffInstance:Entity()
  local buffComponent = e:BuffComponent()
  local entityService = self._world:GetService("LogicEntity")
  buffComponent:SetBuffValue("ReplaceEntityID", nil)
  return true
end
