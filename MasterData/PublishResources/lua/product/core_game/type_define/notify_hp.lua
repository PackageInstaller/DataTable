_class("NTHPCChange", INotifyBase)
NTHPCChange = NTHPCChange

function NTHPCChange:GetNotifyType()
  Log.exception("notify object not have notify type!")
end

function NTHPCChange:IsHPIncrease()
  return self._changeHP > 0
end

_class("NTMonsterHPCChange", NTHPCChange)
NTMonsterHPCChange = NTMonsterHPCChange

function NTMonsterHPCChange:Constructor(entity, hp, maxhp, notifyIndex)
  self._ownerEntity = entity
  self.hp = hp
  self.maxhp = maxhp
  self.notifyIndex = notifyIndex
end

function NTMonsterHPCChange:GetNotifyIndex()
  return self.notifyIndex
end

function NTMonsterHPCChange:GetNotifyType()
  return NotifyType.MonsterHPCChange
end

function NTMonsterHPCChange:GetNotifyEntity()
  return self._ownerEntity
end

function NTMonsterHPCChange:GetMaxHP()
  return self.maxhp
end

function NTMonsterHPCChange:GetHP()
  return self.hp
end

function NTMonsterHPCChange:GetHPPercent()
  return self.hp / self.maxhp * 100
end

function NTMonsterHPCChange:SetChangeHP(changeHP)
  self._changeHP = changeHP
end

function NTMonsterHPCChange:GetChangeHP()
  return self._changeHP
end

function NTMonsterHPCChange:SetDamageSrcEntityID(srcID)
  self._damageSrcEntityID = srcID
end

function NTMonsterHPCChange:GetDamageSrcEntityID()
  return self._damageSrcEntityID
end

function NTMonsterHPCChange:SetDamageType(damageType)
  self._damageType = damageType
end

function NTMonsterHPCChange:GetDamageType()
  return self._damageType
end

function NTMonsterHPCChange:SetAttackPos(attackPos)
  self._attackPos = attackPos
end

function NTMonsterHPCChange:GetAttackPos()
  return self._attackPos
end

function NTMonsterHPCChange:SetAttackEntityID(attackEntityID)
  self._attackEntityID = attackEntityID
end

function NTMonsterHPCChange:GetAttackEntityID()
  return self._attackEntityID
end

function NTMonsterHPCChange:SetDamageInfo(damageInfo)
  self._damageInfo = damageInfo
end

function NTMonsterHPCChange:GetDamageInfo()
  return self._damageInfo
end

function NTMonsterHPCChange:SetCumulativeTriggerNum(num, key)
  if not self._cumulativeTriggerNum then
    self._cumulativeTriggerNum = {}
  end
  self._cumulativeTriggerNum[key] = num
end

function NTMonsterHPCChange:GetCumulativeTriggerNum(key)
  if not self._cumulativeTriggerNum then
    self._cumulativeTriggerNum = {}
  end
  return self._cumulativeTriggerNum[key]
end

_class("NTTrapHpChange", NTHPCChange)
NTTrapHpChange = NTTrapHpChange

function NTTrapHpChange:Constructor(entity, hp, maxhp)
  self._ownerEntity = entity
  self.hp = hp
  self.maxhp = maxhp
end

function NTTrapHpChange:GetNotifyType()
  return NotifyType.TrapHpChange
end

function NTTrapHpChange:GetNotifyEntity()
  return self._ownerEntity
end

function NTTrapHpChange:GetHP()
  return self.hp
end

function NTTrapHpChange:GetMaxHP()
  return self.maxhp
end

function NTTrapHpChange:GetHPPercent()
  return self.hp / self.maxhp * 100
end

function NTTrapHpChange:SetChangeHP(changeHP)
  self._changeHP = changeHP
end

function NTTrapHpChange:GetChangeHP()
  return self._changeHP
end

function NTTrapHpChange:SetDamageSrcEntityID(srcID)
  self._damageSrcEntityID = srcID
end

function NTTrapHpChange:GetDamageSrcEntityID()
  return self._damageSrcEntityID
end

function NTTrapHpChange:SetDamageType(damageType)
  self._damageType = damageType
end

function NTTrapHpChange:GetDamageType()
  return self._damageType
end

function NTTrapHpChange:SetDamageInfo(damageInfo)
  self._damageInfo = damageInfo
end

function NTTrapHpChange:GetDamageInfo()
  return self._damageInfo
end

function NTTrapHpChange:SetAttackPos(attackPos)
  self._attackPos = attackPos
end

function NTTrapHpChange:GetAttackPos()
  return self._attackPos
end

_class("NTPlayerHPChange", NTHPCChange)
NTPlayerHPChange = NTPlayerHPChange

function NTPlayerHPChange:Constructor(entity, hp, maxhp, hpSpilled, changeHp, damageSrcEntity)
  self._ownerEntity = entity
  self.hp = hp
  self.maxhp = maxhp
  self.hpSpilled = hpSpilled
  self.changeHp = changeHp
  self._changeHP = changeHp
  self._damageSrcEntity = damageSrcEntity
end

function NTPlayerHPChange:GetNotifyType()
  return NotifyType.PlayerHPChange
end

function NTPlayerHPChange:GetNotifyEntity()
  return self._ownerEntity
end

function NTPlayerHPChange:GetDamageSrcEntity()
  return self._damageSrcEntity
end

function NTPlayerHPChange:GetDamageSrcEntityID()
  return self._damageSrcEntity
end

function NTPlayerHPChange:GetHPSpilled()
  return self.hpSpilled
end

function NTPlayerHPChange:GetChangeHP()
  return self.changeHp
end

function NTPlayerHPChange:GetMaxHP()
  return self.maxhp
end

function NTPlayerHPChange:GetHP()
  return self.hp
end

function NTPlayerHPChange:GetHPPercent()
  return self.hp / self.maxhp * 100
end

function NTPlayerHPChange:NeedCheckGameTurn()
  return false
end

function NTPlayerHPChange:SetDamageType(damageType)
  self._damageType = damageType
end

function NTPlayerHPChange:GetDamageType()
  return self._damageType
end

function NTPlayerHPChange:SetAttackPos(attackPos)
  self._attackPos = attackPos
end

function NTPlayerHPChange:GetAttackPos()
  return self._attackPos
end

function NTPlayerHPChange:SetDamageInfo(damageInfo)
  self._damageInfo = damageInfo
end

function NTPlayerHPChange:GetDamageInfo()
  return self._damageInfo
end
