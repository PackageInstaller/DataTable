_class("BuffLogicReflexiveDamage", BuffLogicBase)
BuffLogicReflexiveDamage = BuffLogicReflexiveDamage

function BuffLogicReflexiveDamage:Constructor(buffInstance, logicParam)
  self._percent = logicParam.percent
  self._notifyType = logicParam.notifyType
  self._formulaID = logicParam.formulaID or 18
end

function BuffLogicReflexiveDamage:DoLogic(notify)
  local notifyType = notify:GetNotifyType()
  local isMatch = false
  if self._notifyType then
    for _, v in ipairs(self._notifyType) do
      if v == notifyType then
        isMatch = true
        break
      end
    end
  else
    isMatch = true
  end
  if not isMatch then
    return
  end
  local buffCom = self._entity:BuffComponent()
  local layerKey = "ReflexiveDamageLayer"
  local layer = buffCom:GetBuffValue(layerKey)
  if not layer or layer <= 0 then
    return
  end
  local damage = notify:GetDamageValue()
  if damage <= 0 then
    return
  end
  local damageType = notify:GetDamageType()
  if damageType == DamageType.RealReflexive then
    return
  end
  if damageType == DamageType.RealTransmit then
    return
  end
  local attacker = notify:GetAttackerEntity()
  local attackerID = attacker:GetID()
  local attackPos = notify:GetAttackPos()
  if attacker:HasPetPstID() then
    attacker = attacker:Pet():GetOwnerTeamEntity()
  end
  local skillHolderID
  if attacker:HasSuperEntity() then
    skillHolderID = attackerID
    attacker = attacker:GetSuperEntity()
    attackerID = attacker:GetID()
    attackPos = attacker:GridLocation().Position
  end
  if not attacker:HasAttributes() or not attacker:Attributes():GetCurrentHP() then
    return
  end
  local blsvc = self._world:GetService("BuffLogic")
  local damageInfo = blsvc:DoBuffDamage(self._buffInstance:BuffID(), self._entity, attacker, {
    percent = self._percent,
    formulaID = self._formulaID,
    baseDamage = damage
  })
  layer = layer - 1
  buffCom:SetBuffValue(layerKey, layer)
  local buffResult = BuffResultReflexiveDamage:New(attackerID, attackPos, damageInfo, layer)
  if skillHolderID then
    buffResult:SetSkillHolderID(skillHolderID)
  end
  if notify.GetSkillID then
    buffResult:SetSkillID(notify:GetSkillID())
  end
  if notify.GetCurSkillDamageIndex then
    buffResult:SetCurSkillDamageIndex(notify:GetCurSkillDamageIndex())
  end
  return buffResult
end
