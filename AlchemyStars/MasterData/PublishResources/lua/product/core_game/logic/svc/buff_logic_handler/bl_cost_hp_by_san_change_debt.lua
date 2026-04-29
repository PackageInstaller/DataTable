_class("BuffLogicCostHPBySanChangeDebt", BuffLogicBase)
BuffLogicCostHPBySanChangeDebt = BuffLogicCostHPBySanChangeDebt

function BuffLogicCostHPBySanChangeDebt:Constructor(buffInstance, logicParam)
  self._damagePercent = logicParam.damagePercent
end

function BuffLogicCostHPBySanChangeDebt:DoLogic(notify)
  if not NTSanValueChange:IsInstanceOfType(notify) then
    return
  end
  if self._entity:HasDeadMark() or self._entity:HasPetDeadMark() then
    return
  end
  local e = self._buffInstance:Entity()
  local attrCmpt = e:Attributes()
  local maxHp = attrCmpt:CalcMaxHp()
  if maxHp <= 0 then
    return
  end
  local debtVal = notify:GetDebtValue()
  if debtVal <= 0 then
    return
  end
  local costPercent = self._damagePercent * debtVal
  local casterEntity = self:GetCasterEntity()
  if casterEntity:EntityType() == nil then
    casterEntity = e
  end
  local blsvc = self._world:GetService("BuffLogic")
  local damageInfo = blsvc:DoBuffDamage(self._buffInstance:BuffID(), casterEntity, e, {percent = costPercent, formulaID = 10})
  return BuffResultCostHPBySanChangeDebt:New(damageInfo, notify)
end
