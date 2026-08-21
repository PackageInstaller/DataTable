local BuffChangeAUOEValueType = {
  Value = 1,
  TeamHPPercent = 2,
  TargetCount = 3
}
_enum("BuffChangeAUOEValueType", BuffChangeAUOEValueType)
_class("BuffLogicChangeAUOEValue", BuffLogicBase)
BuffLogicChangeAUOEValue = BuffLogicChangeAUOEValue

function BuffLogicChangeAUOEValue:Constructor(buffInstance, logicParam)
  self._modifyValue = logicParam.modifyValue or 0
  self._modifyType = logicParam.modifyType or BuffChangeAUOEValueType.Value
  self._modifyParam = logicParam.modifyParam
end

function BuffLogicChangeAUOEValue:DoLogic(notify)
  local modifyValue = self:_GetModifyValue(notify)
  local featureSvc = self._world:GetService("FeatureLogic")
  local curAUOE, oldAUOE, realModifyValue = featureSvc:ModifyAUOEValue(modifyValue)
  local result = BuffResultChangeAUOEValue:New(curAUOE, oldAUOE, realModifyValue)
  local notifyType = notify:GetNotifyType()
  if notifyType == NotifyType.NormalEachAttackEnd or notifyType == NotifyType.PlayerBeHit then
    result.attacker = notify:GetAttackerEntity()
    result.defender = notify:GetDefenderEntity()
    result.attackPos = notify:GetAttackPos()
    result.targetPos = notify:GetTargetPos()
  end
  if notifyType == NotifyType.PlayerBeHit then
    result.damageIndex = notify:GetDamageIndex()
  end
  return result
end

function BuffLogicChangeAUOEValue:_GetModifyValue(notify)
  local value = self._modifyValue
  if self._modifyType == BuffChangeAUOEValueType.TeamHPPercent then
    local hpPercentArray = self._modifyParam.hpPercent
    local valueArray = self._modifyParam.energy
    if table.count(hpPercentArray) ~= table.count(valueArray) then
      Log.error("BuffLogicChangeAUOEValue cfg error, list count is not match")
      return value
    end
    local battleSvc = self._world:GetService("Battle")
    local hp, maxHP = battleSvc:GetTeamHP()
    local curPercent = hp / maxHP
    for i = table.count(hpPercentArray), 1, -1 do
      if curPercent >= hpPercentArray[i] then
        value = valueArray[i]
        return value
      end
    end
  elseif self._modifyType == BuffChangeAUOEValueType.TargetCount then
    if notify.GetTargetCount then
      value = self._modifyValue * notify:GetTargetCount()
    elseif notify.GetSkillDamageTargetCount then
      value = self._modifyValue * notify:GetSkillDamageTargetCount()
    end
  end
  return value
end
