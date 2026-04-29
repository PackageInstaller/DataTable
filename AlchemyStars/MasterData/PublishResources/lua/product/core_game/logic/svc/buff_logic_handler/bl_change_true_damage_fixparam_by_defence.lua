_class("BuffLogicChangeTrueDamageFixParamByDefence", BuffLogicBase)
BuffLogicChangeTrueDamageFixParamByDefence = BuffLogicChangeTrueDamageFixParamByDefence

function BuffLogicChangeTrueDamageFixParamByDefence:Constructor(buffInstance, logicParam)
  self._percent = logicParam.percent or 0
end

function BuffLogicChangeTrueDamageFixParamByDefence:DoLogic(notify)
  local attackerEntity = notify:GetAttackerEntity()
  local attackAttr = attackerEntity:Attributes()
  local attackerDefenderCount = attackAttr:GetDefence()
  local defenderEntity = notify:GetDefenderEntity()
  local defendAttr = defenderEntity:Attributes()
  local defenderDefenderCount = defendAttr:GetDefence()
  local value = attackerDefenderCount / (attackerDefenderCount + defenderDefenderCount)
  value = self._percent * value
  value = value * 10000
  value = math.floor(value)
  value = value / 10000
  self._buffLogicService:ChangeTrueDamageFixParam(self._entity, self:GetBuffSeq(), value)
  return true
end

_class("BuffLogicUndoChangeTrueDamageFixParamByDefence", BuffLogicBase)
BuffLogicUndoChangeTrueDamageFixParamByDefence = BuffLogicUndoChangeTrueDamageFixParamByDefence

function BuffLogicUndoChangeTrueDamageFixParamByDefence:Constructor()
end

function BuffLogicUndoChangeTrueDamageFixParamByDefence:DoLogic()
  self._buffLogicService:RemoveTrueDamageFixParam(self._entity, self:GetBuffSeq())
  return true
end
