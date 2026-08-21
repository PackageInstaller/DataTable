_class("BuffViewAccumulateMarkLayer", BuffViewBase)
BuffViewAccumulateMarkLayer = BuffViewAccumulateMarkLayer

function BuffViewAccumulateMarkLayer:PlayView(TT)
  self._viewInstance:SetLayerCount(TT, self._buffResult:GetLayer())
  self._world:EventDispatcher():Dispatch(GameEventType.ChangeBuff)
end

function BuffViewAccumulateMarkLayer:IsNotifyMatch(notify)
  local buffResult = self._buffResult
  if buffResult:GetAttackerID() ~= notify._attacker:GetID() then
    return false
  end
  if buffResult:GetDefenderID() ~= notify._defender:GetID() then
    return false
  end
  if buffResult:GetAttackPos() ~= notify._attackPos then
    return false
  end
  return true
end
