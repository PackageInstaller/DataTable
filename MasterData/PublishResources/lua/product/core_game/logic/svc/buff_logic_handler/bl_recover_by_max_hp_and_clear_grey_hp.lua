require("buff_logic_base")
_class("BuffLogicRecoverByMaxHPAndClearGreyHP", BuffLogicBase)
BuffLogicRecoverByMaxHPAndClearGreyHP = BuffLogicRecoverByMaxHPAndClearGreyHP

function BuffLogicRecoverByMaxHPAndClearGreyHP:Constructor(_, logicParam)
  self._baseRate = logicParam.baseRate
  self._subRate = logicParam.subRate
  self._limitRate = logicParam.limitRate
end

function BuffLogicRecoverByMaxHPAndClearGreyHP:DoLogic(_)
  local e = self:GetEntity()
  if e:HasSuperEntity() then
    e = e:GetSuperEntity()
  end
  local count = self._buffLogicService:GetRecoverByMaxHPCount(e) or 0
  local curRate = math.max(self._baseRate - self._subRate * count, self._limitRate)
  local damageInfo = self._buffLogicService:GetRecoverByMaxHP(e, curRate)
  local calcDamageSvc = self._world:GetService("CalcDamage")
  calcDamageSvc:AddTargetHP(e:GetID(), damageInfo)
  count = count + 1
  self._buffLogicService:SetRecoverByMaxHPCount(e, count)
  self._buffLogicService:ClearGreyHP(e)
  return BuffResultRecoverByMaxHPAndClearGreyHP:New(e:GetID(), damageInfo)
end
