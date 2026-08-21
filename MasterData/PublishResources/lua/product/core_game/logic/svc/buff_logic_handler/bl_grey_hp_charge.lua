require("buff_logic_base")
_class("BuffLogicEnableGreyHPCharge", BuffLogicBase)
BuffLogicEnableGreyHPCharge = BuffLogicEnableGreyHPCharge

function BuffLogicEnableGreyHPCharge:DoLogic(_)
  local e = self:GetEntity()
  if e:HasSuperEntity() then
    e = e:GetSuperEntity()
  end
  local cBuff = e:BuffComponent()
  cBuff:SetGreyHPEnable(true)
end

_class("BuffLogicDisableGreyHPCharge", BuffLogicBase)
BuffLogicDisableGreyHPCharge = BuffLogicDisableGreyHPCharge

function BuffLogicDisableGreyHPCharge:DoLogic(_)
  local e = self:GetEntity()
  if e:HasSuperEntity() then
    e = e:GetSuperEntity()
  end
  local cBuff = e:BuffComponent()
  cBuff:SetGreyHPEnable(false)
  cBuff:ClearGreyHPValue()
  self._buffInstance.__ChargeGreyHPRunCount = nil
  return {}
end

_class("BuffLogicSuspendGreyHPCharge", BuffLogicBase)
BuffLogicSuspendGreyHPCharge = BuffLogicSuspendGreyHPCharge

function BuffLogicSuspendGreyHPCharge:DoLogic(_)
  local e = self:GetEntity()
  if e:HasSuperEntity() then
    e = e:GetSuperEntity()
  end
  local cBuff = e:BuffComponent()
  cBuff:SetGreyHPEnable(false)
end

_class("BuffLogicChargeGreyHP", BuffLogicBase)
BuffLogicChargeGreyHP = BuffLogicChargeGreyHP

function BuffLogicChargeGreyHP:Constructor(_, logicParam)
  self._chargePercent = logicParam.percent
  assert(type(self._chargePercent) == "number")
end

local buffLogicChargeGreyHPTag = "BuffLogicChargeGreyHP: "

function BuffLogicChargeGreyHP:DoLogic(notify)
  local damageVal = 0
  if notify:GetNotifyType() == NotifyType.MonsterHPCChange then
    damageVal = notify:GetChangeHP() * -1
  end
  if damageVal <= 0 then
    Log.debug(buffLogicChargeGreyHPTag, "notify has no damageVal: ", tostring(notify:GetNotifyType()))
    damageVal = 0
  end
  local val = damageVal * self._chargePercent
  local e = self:GetEntity()
  if e:HasSuperEntity() then
    e = e:GetSuperEntity()
  end
  local currentVal = self._buffLogicService:ChangeGreyHP(e, val)
  local result = BuffResultChargeGreyHP:New(e:GetID(), currentVal, notify:GetNotifyType(), notify:GetNotifyIndex(), val, notify:GetChangeHP())
  return result
end
