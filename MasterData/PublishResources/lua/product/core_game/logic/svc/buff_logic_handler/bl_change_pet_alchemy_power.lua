_class("BuffLogicChangePetAlchemyPower", BuffLogicBase)
BuffLogicChangePetAlchemyPower = BuffLogicChangePetAlchemyPower

function BuffLogicChangePetAlchemyPower:Constructor(buffInstance, logicParam)
  self._addValue = logicParam.addValue or 0
  self._maxValue = logicParam.maxValue or 0
  self._addPercent = logicParam.addPercent
  self._checkExtraSkillID = logicParam.checkExtraSkillID
end

function BuffLogicChangePetAlchemyPower:DoLogic(notify)
  local petEntity = self._buffInstance:Entity()
  if not petEntity then
    return
  end
  local newPower = self:_CalcChangePetPower(petEntity)
  local utilCalcSvc = self._world:GetService("UtilCalc")
  local petPowerStateList = utilCalcSvc:ChangeAlchemyPower(petEntity, newPower, true)
  local buffResult = BuffResultChangePetLegendPower:New(petPowerStateList)
  if notify and notify.GetAttackPos and notify.GetTargetPos then
    buffResult.attackPos = notify:GetAttackPos()
    buffResult.targetPos = notify:GetTargetPos()
  end
  return buffResult
end

function BuffLogicChangePetAlchemyPower:_CalcChangePetPower(petEntity)
  local curAttributeCmpt = petEntity:Attributes()
  local curAlchemyPower = curAttributeCmpt:GetAttribute("AlchemyPower")
  local addValue = self:_CalcModifyValue(curAlchemyPower)
  local newPower = curAlchemyPower + addValue
  if newPower < 0 then
    newPower = 0
  end
  if self._maxValue ~= 0 and newPower > self._maxValue then
    newPower = self._maxValue
  end
  if newPower > BattleConst.AlchemyPowerMax then
    newPower = BattleConst.AlchemyPowerMax
  end
  return newPower
end

function BuffLogicChangePetAlchemyPower:_CalcModifyValue(curAlchemyPower)
  local addValue = self._addValue
  if self._addPercent then
    local oriModifyVal = curAlchemyPower * self._addPercent
    local absModifyVal = math.abs(oriModifyVal)
    absModifyVal = math.floor(absModifyVal)
    if oriModifyVal < 0 then
      addValue = -1 * absModifyVal
    else
      addValue = absModifyVal
    end
  end
  return addValue
end
