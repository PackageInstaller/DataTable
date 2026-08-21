_class("BuffViewChangeAUOEValue", BuffViewBase)
BuffViewChangeAUOEValue = BuffViewChangeAUOEValue

function BuffViewChangeAUOEValue:IsNotifyMatch(notify)
  local result = self._buffResult
  if notify:GetNotifyType() == NotifyType.NormalEachAttackEnd then
    return result.attacker == notify:GetAttackerEntity() and result.defender == notify:GetDefenderEntity() and result.attackPos == notify:GetAttackPos() and result.targetPos == notify:GetTargetPos()
  elseif notify:GetNotifyType() == NotifyType.PlayerBeHit then
    local damageIndexMatch = true
    if result.damageIndex and notify:GetDamageIndex() then
      damageIndexMatch = result.damageIndex == notify:GetDamageIndex()
    end
    return result.attackPos == notify:GetAttackPos() and result.targetPos == notify:GetTargetPos() and result.attackerEntity == notify:GetAttackerEntity() and result.defenderEntity == notify:GetDefenderEntity() and damageIndexMatch
  end
  return true
end

function BuffViewChangeAUOEValue:PlayView(TT)
  local result = self._buffResult
  local featureSvc = self._world:GetService("FeatureRender")
  if featureSvc then
    featureSvc:NotifyAUOEValueChange(result:GetCurValue(), result:GetOldValue(), result:GetRealModifyValue())
  end
end
