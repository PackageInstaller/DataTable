_class("BuffLogicHitBackEndDamage", BuffLogicBase)
BuffLogicHitBackEndDamage = BuffLogicHitBackEndDamage

function BuffLogicHitBackEndDamage:Constructor(buffInstance, logicParam)
  self._percent = logicParam.percent
  self._addition = logicParam.addition or 0
end

function BuffLogicHitBackEndDamage:DoLogic(notify)
  local attacker = notify:GetNotifyEntity()
  local defenderId = notify:GetDefenderId()
  if defenderId == nil or defenderId <= 0 then
    return
  end
  local targetEntity = self._world:GetEntityByID(defenderId)
  local curHp = targetEntity:Attributes():GetCurrentHP()
  if curHp == nil then
    return
  end
  local addPercent = self:GetTotalAdditionByHitBackDistance(notify)
  local blsvc = self._world:GetService("BuffLogic")
  local damageInfo = blsvc:DoBuffDamage(self._buffInstance:BuffID(), attacker, targetEntity, {
    percent = self._percent,
    addPercent = addPercent,
    formulaID = 9
  })
  local buffResult = BuffResultHitBackEndDamage:New(defenderId, damageInfo)
  return buffResult
end

function BuffLogicHitBackEndDamage:GetTotalAdditionByHitBackDistance(data)
  local posStart = data:GetPosStart()
  local posEnd = data:GetPosEnd()
  if posStart and posEnd then
    local dis = 0
    local v = posEnd - posStart
    if v.x == 0 then
      dis = v.y
    else
      dis = v.x
    end
    if dis < 0 then
      dis = -dis
    end
    return self._addition * dis
  end
  return 0
end
