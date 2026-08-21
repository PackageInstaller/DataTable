_class("BuffLogicLoseHPLimit", BuffLogicBase)
BuffLogicLoseHPLimit = BuffLogicLoseHPLimit

function BuffLogicLoseHPLimit:Constructor(buffInstance, logicParam)
  self._percent = logicParam.percent
  self._fixValue = logicParam.fixValue
end

function BuffLogicLoseHPLimit:DoLogic()
  local e = self._buffInstance:Entity()
  e:BuffComponent():SetBuffValue("MaxLoseHPPercent", {
    percent = self._percent,
    fixValue = self._fixValue
  })
end

_class("BuffLogicAttackIgnoreLoseHPLimit", BuffLogicBase)
BuffLogicAttackIgnoreLoseHPLimit = BuffLogicAttackIgnoreLoseHPLimit

function BuffLogicAttackIgnoreLoseHPLimit:Constructor(buffInstance, logicParam)
  self._isSet = tonumber(logicParam.isSet)
end

function BuffLogicAttackIgnoreLoseHPLimit:DoLogic()
  local e = self._buffInstance:Entity()
  local buffVal = 0
  if self._isSet and self._isSet == 1 then
    buffVal = 1
  end
  e:BuffComponent():SetBuffValue("AttackIgnoreMaxLoseHPPercent", buffVal)
end
