_class("BuffLogicAddAIMobility", BuffLogicBase)
BuffLogicAddAIMobility = BuffLogicAddAIMobility

function BuffLogicAddAIMobility:Constructor(buffInstance, logicParam)
  self._addValue = logicParam.addValue or 0
  self._mulValue = logicParam.mulValue or 1
  self._runCount = 0
end

function BuffLogicAddAIMobility:DoLogic()
  self._runCount = self._runCount + 1
  local e = self._buffInstance:Entity()
  if not e:HasMonsterID() then
    return
  end
  local mulVal = self._mulValue * self._runCount
  if mulVal ~= 1 then
    e:Attributes():Modify("Mobility", mulVal, self._buffInstance:BuffSeq(), MultModifyOperator.MULTIPLY)
  end
  local addVal = self._addValue * self._runCount
  if addVal ~= 0 then
    e:Attributes():Modify("Mobility", addVal, self._buffInstance:BuffSeq(), MultModifyOperator.PLUS)
  end
end

function BuffLogicAddAIMobility:DoOverlap()
  self:DoLogic()
end

_class("BuffLogicRemoveAIMobility", BuffLogicBase)
BuffLogicRemoveAIMobility = BuffLogicRemoveAIMobility

function BuffLogicRemoveAIMobility:Constructor(buffInstance, logicParam)
end

function BuffLogicRemoveAIMobility:DoLogic()
  local e = self._buffInstance:Entity()
  if not e:HasMonsterID() then
    return
  end
  e:Attributes():RemoveModify("Mobility", self._buffInstance:BuffSeq())
end

_class("BuffLogicChangeAIMobility", BuffLogicBase)
BuffLogicChangeAIMobility = BuffLogicChangeAIMobility

function BuffLogicChangeAIMobility:Constructor(buffInstance, logicParam)
  self._value = logicParam.value or 0
end

function BuffLogicChangeAIMobility:DoLogic()
  local e = self._buffInstance:Entity()
  if not e:HasMonsterID() then
    return
  end
  local changeValue = self._value - e:Attributes():GetAIMobility()
  e:Attributes():Modify("Mobility", changeValue, self._buffInstance:BuffSeq(), MultModifyOperator.PLUS)
  local value = e:Attributes():GetAIMobility()
  Log.info("BuffLogicChangeAIMobility ConfigValue:", self._value, "ChangeValue:", changeValue, "FinalValue = ", value)
end

function BuffLogicChangeAIMobility:DoOverlap()
  self:DoLogic()
end
