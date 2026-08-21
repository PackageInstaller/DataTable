_class("BuffLogicChangeTrapPower", BuffLogicBase)
BuffLogicChangeTrapPower = BuffLogicChangeTrapPower

function BuffLogicChangeTrapPower:Constructor(buffInstance, logicParam)
  self._addValue = logicParam.addValue or 0
  self._limitZero = logicParam.limitZero or 1
end

function BuffLogicChangeTrapPower:DoLogic()
  local trapEntity = self._buffInstance:Entity()
  if not trapEntity then
    return
  end
  local curAttributeCmpt = trapEntity:Attributes()
  local curPower = curAttributeCmpt:GetAttribute("TrapPower")
  local trapPowerMax = curAttributeCmpt:GetAttribute("TrapPowerMax")
  local newPower = curPower + self._addValue
  if newPower < 0 and self._limitZero == 1 then
    newPower = 0
  end
  if trapPowerMax < newPower then
    newPower = trapPowerMax
  end
  curAttributeCmpt:Modify("TrapPower", newPower)
  local buffResult = BuffResultChangeTrapPower:New(trapEntity:GetID(), newPower)
  return buffResult
end
