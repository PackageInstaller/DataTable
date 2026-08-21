require("notify_type")
require("notify_attack")
_class("NTChessBeHit", NotifyAttackBase)
NTChessBeHit = NotifyAttackBase

function NTChessBeHit:GetNotifyType()
  return NotifyType.ChessBeHit
end

function NTChessBeHit:NeedCheckGameTurn()
  return false
end

function NTChessBeHit:GetNotifyEntity()
  return self._defender
end

_class("NTChessDead", INotifyBase)
NTChessDead = NTChessDead

function NTChessDead:Constructor(chessEntity)
  self._ownerEntity = chessEntity
end

function NTChessDead:GetNotifyType()
  return NotifyType.ChessDead
end

function NTChessDead:GetNotifyEntity()
  return self._ownerEntity
end

_class("NTChessHPChange", INotifyBase)
NTChessHPChange = NTChessHPChange

function NTChessHPChange:Constructor(entity, hp, maxhp, notifyIndex)
  self._ownerEntity = entity
  self.hp = hp
  self.maxhp = maxhp
  self.notifyIndex = notifyIndex
end

function NTChessHPChange:GetNotifyIndex()
  return self.notifyIndex
end

function NTChessHPChange:GetNotifyType()
  return NotifyType.ChessHPChange
end

function NTChessHPChange:GetNotifyEntity()
  return self._ownerEntity
end

function NTChessHPChange:GetMaxHP()
  return self.maxhp
end

function NTChessHPChange:GetHP()
  return self.hp
end

function NTChessHPChange:GetHPPercent()
  return self.hp / self.maxhp * 100
end

function NTChessHPChange:SetChangeHP(changeHP)
  self._changeHP = changeHP
end

function NTChessHPChange:GetChangeHP()
  return self._changeHP
end

function NTChessHPChange:SetDamageSrcEntityID(srcID)
  self._damageSrcEntityID = srcID
end

function NTChessHPChange:GetDamageSrcEntityID()
  return self._damageSrcEntityID
end

function NTChessHPChange:SetDamageType(damageType)
  self._damageType = damageType
end

function NTChessHPChange:GetDamageType()
  return self._damageType
end

function NTChessHPChange:SetAttackPos(attackPos)
  self._attackPos = attackPos
end

function NTChessHPChange:GetAttackPos()
  return self._attackPos
end

function NTChessHPChange:SetAttackEntityID(attackEntityID)
  self._attackEntityID = attackEntityID
end

function NTChessHPChange:GetAttackEntityID()
  return self._attackEntityID
end

function NTChessHPChange:SetDamageInfo(damageInfo)
  self._damageInfo = damageInfo
end

function NTChessHPChange:GetDamageInfo()
  return self._damageInfo
end
