_class("BuffViewAddBuffRandom", BuffViewAddBuff)
BuffViewAddBuffRandom = BuffViewAddBuffRandom

function BuffViewAddBuffRandom:IsNotifyMatch(notify)
  if notify.GetRandHalfDamageIndex and self._buffResult.GetRandHalfDamageIndex then
    local halfRandDamageIndex = notify:GetRandHalfDamageIndex()
    if halfRandDamageIndex then
      local buffHalfRandDamageIndex = self._buffResult:GetRandHalfDamageIndex()
      if buffHalfRandDamageIndex and buffHalfRandDamageIndex ~= halfRandDamageIndex then
        return false
      end
    end
  end
  local attackPos = self._buffResult:GetAttackPos()
  local targetPos = self._buffResult:GetTargetPos()
  if notify.GetAttackPos and attackPos and notify.GetTargetPos and targetPos then
    if attackPos == notify:GetAttackPos() and targetPos == notify:GetTargetPos() then
      return true
    else
      return false
    end
  end
  if notify:GetNotifyType() == NotifyType.NotifyLayerChange then
    local n = notify
    if self._buffResult.__oldFinalLayer ~= n.__oldFinalLayer then
      return false
    end
    if n:GetNotifyEntity() and self._buffResult:GetNotifyLayerChange_Entity() ~= n:GetNotifyEntity() then
      return false
    end
    return true
  end
  if notify and notify:GetNotifyType() == NotifyType.EntityMoveEnd then
    return self._buffResult:GetWalkPos() == notify:GetPosNew()
  end
  return true
end
