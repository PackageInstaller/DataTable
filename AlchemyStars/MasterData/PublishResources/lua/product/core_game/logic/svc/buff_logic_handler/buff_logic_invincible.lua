_class("BuffLogicSetInvincible", BuffLogicBase)
BuffLogicSetInvincible = BuffLogicSetInvincible

function BuffLogicSetInvincible:Constructor(buffInstance, logicParam)
  self._layerNum = logicParam.layerNum
end

function BuffLogicSetInvincible:DoLogic()
  local e = self._buffInstance:Entity()
  e:BuffComponent():SetFlag(BuffFlags.Invincible)
end

_class("BuffLogicResetInvincible", BuffLogicBase)
BuffLogicResetInvincible = BuffLogicResetInvincible

function BuffLogicResetInvincible:Constructor(buffInstance, logicParam)
  self._layerNum = logicParam.layerNum
end

function BuffLogicResetInvincible:DoLogic()
  local e = self._buffInstance:Entity()
  e:BuffComponent():ResetFlag(BuffFlags.Invincible)
end
