require("buff_logic_base")
_class("BuffLogicAbsorbTargetAttack", BuffLogicBase)
BuffLogicAbsorbTargetAttack = BuffLogicAbsorbTargetAttack

function BuffLogicAbsorbTargetAttack:Constructor(buffInstance, logicParam)
  self._absorbAttackPercent = logicParam.absorbAttackPercent
  self._absorbAttackType = logicParam.absorbAttackType
  self._absorbValue = 0
end

function BuffLogicAbsorbTargetAttack:DoLogic(notify)
  local notifyType = notify:GetNotifyType()
  if table.icontains(self._absorbAttackType, notifyType) then
    local attacker = self._buffInstance:Entity()
    local defenderEntity = notify:GetDefenderEntity()
    if not (attacker and defenderEntity and attacker:Attributes()) or not defenderEntity:Attributes() then
      return false
    end
    if not defenderEntity:MonsterID() then
      return false
    end
    local baseAttackValue = attacker:Attributes():GetAttribute("Attack")
    if baseAttackValue <= self._absorbValue then
      return false
    end
    local defenderAttackRealValue = self._buffLogicService:GetEntityAttackValue(defenderEntity)
    local defenderAttackValue = defenderEntity:Attributes():GetAttribute("Attack")
    local absorbValue = math.floor(defenderAttackValue * self._absorbAttackPercent)
    if defenderAttackRealValue == 0 then
      return false
    end
    if defenderAttackRealValue < absorbValue then
      absorbValue = defenderAttackRealValue
    end
    if baseAttackValue < self._absorbValue + absorbValue then
      absorbValue = baseAttackValue - self._absorbValue
    end
    self._absorbValue = self._absorbValue + absorbValue
    local defenderModifier = self._buffLogicService:_GetAttributeModifier(defenderEntity, "AttackConstantFix")
    local alreadyAbsorbValue = defenderModifier:GetModifyValue(self:GetBuffSeq())
    if alreadyAbsorbValue then
      absorbValue = absorbValue + alreadyAbsorbValue * -1
    end
    self._buffLogicService:ChangeBaseAttack(defenderEntity, self:GetBuffSeq(), ModifyBaseAttackType.AttackConstantFix, absorbValue * -1)
    self._buffLogicService:ChangeBaseAttack(attacker, self:GetBuffSeq(), ModifyBaseAttackType.AttackConstantFix, self._absorbValue)
    return true
  end
  return false
end
