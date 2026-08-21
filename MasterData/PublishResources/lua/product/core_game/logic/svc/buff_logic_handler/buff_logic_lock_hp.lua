local LockHPType = {Normal = 1, MonsterTurnUnLock = 2}
_enum("LockHPType", LockHPType)
_class("BuffLogicLockHP", BuffLogicBase)
BuffLogicLockHP = BuffLogicLockHP

function BuffLogicLockHP:Constructor(buffInstance, logicParam)
  self._lockHPList = logicParam.lockHPList
  self._isLockHPAlways = false
  self._lockHPType = logicParam.lockHPType or LockHPType.Normal
  if logicParam.isLockHPAlways then
    self._isLockHPAlways = true
  end
end

function BuffLogicLockHP:DoLogic()
  local e = self._buffInstance:Entity()
  if self._isLockHPAlways then
    e:BuffComponent():SetBuffValue("LockHPAlways", true)
  else
    e:BuffComponent():SetBuffValue("LockHPByRound", true)
  end
  e:BuffComponent():SetBuffValue("LockHPType", self._lockHPType)
  e:BuffComponent():SetBuffValue("LockHPList", self._lockHPList)
  self._world:EventDispatcher():Dispatch(GameEventType.DataBuffValue, e:GetID(), "LockHPList", self._lockHPList)
end

_class("BuffLogicUnlockHP", BuffLogicBase)
BuffLogicUnlockHP = BuffLogicUnlockHP

function BuffLogicUnlockHP:DoLogic()
  local e = self._buffInstance:Entity()
  local cBuff = e:BuffComponent()
  cBuff:SetBuffValue("IsUnlockHP", true)
  cBuff:SetBuffValue("LockHPAlways", false)
  cBuff:SetBuffValue("LockHPByRound", false)
  cBuff:SetBuffValue("LockHPList", nil)
  cBuff:ResetHPLockState()
  cBuff._lockHpPercent = {}
  self._world:EventDispatcher():Dispatch(GameEventType.DataBuffValue, e:GetID(), "LockHPList", {})
end
