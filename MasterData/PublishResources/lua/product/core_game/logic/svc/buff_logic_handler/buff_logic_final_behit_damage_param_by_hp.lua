_class("BuffLogicSetFinalBehitDamageParamByHP", BuffLogicBase)
BuffLogicSetFinalBehitDamageParamByHP = BuffLogicSetFinalBehitDamageParamByHP

function BuffLogicSetFinalBehitDamageParamByHP:Constructor(buffInstance, logicParam)
  self._minValue = logicParam.minValue
  self._maxValue = logicParam.maxValue
  self._eachHpPercent = logicParam.eachHpPercent
  self._promotePercent = logicParam.promotePercent
end

function BuffLogicSetFinalBehitDamageParamByHP:DoLogic()
  local entity = self._buffInstance:Entity()
  local component = entity:Attributes()
  local curHP = component:GetCurrentHP()
  local maxHP = component:CalcMaxHp()
  local percentHP = (maxHP - curHP) / maxHP
  local promoteRate = 0
  if self._eachHpPercent and self._promotePercent and self._eachHpPercent ~= 0 then
    promoteRate = percentHP / self._eachHpPercent * self._promotePercent
  end
  promoteRate = lmathext.clamp(promoteRate, self._minValue, self._maxValue)
  if 0 < promoteRate then
    component:Modify("FinalBehitDamageParam", -promoteRate / 100)
  end
end
