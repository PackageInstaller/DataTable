_class("BuffLogicVampire", BuffLogicBase)
BuffLogicVampire = BuffLogicVampire
BloodChangeSanType = {
  None = 0,
  Add = 1,
  Reduce = 2
}
_enum("BloodChangeSanType", BloodChangeSanType)

function BuffLogicVampire:Constructor(buffInstance, logicParam)
  self._vampireParam = logicParam.vampire
  self._skillTypes = logicParam.skillTypes
  self._changeSanType = logicParam.changeSanType or BloodChangeSanType.None
  self._popStar = logicParam.popStar
end

function BuffLogicVampire:DoLogic(notify)
  local damage = notify:GetDamageValue()
  if damage == nil then
    Log.fatal("[Vampire] notify 中没有damage参数，无法计算吸血")
    return
  end
  if damage <= 0 then
    Log.notice("[Vampire] 伤害为0，不吸血")
    return
  end
  if notify.GetDefenderEntity then
    local e = notify:GetDefenderEntity()
    if e:HasTrap() then
      return
    end
  end
  local attacker = notify:GetNotifyEntity()
  local targetHPEntity = notify:GetNotifyEntity()
  if targetHPEntity:HasSuperEntity() then
    targetHPEntity = targetHPEntity:GetSuperEntity()
  end
  if targetHPEntity:HasPetPstID() then
    targetHPEntity = targetHPEntity:Pet():GetOwnerTeamEntity()
  end
  local skillID = attacker:SkillContext():GetResultContainer():GetSkillID()
  local cfgService = self._world:GetService("Config")
  local skillType = cfgService:GetSkillConfigData(skillID):GetSkillType()
  local canVampire = false
  if type(self._skillTypes) == "number" and self._skillTypes == 0 then
    canVampire = true
  elseif type(self._skillTypes) == "table" and table.icontains(self._skillTypes, skillType) then
    canVampire = true
  end
  if not canVampire then
    return
  end
  if targetHPEntity:Attributes():GetAttribute("BuffForbidCure") then
    return
  end
  local formulaSvc = self._world:GetService("Formula")
  local skillCtx = attacker:SkillContext()
  local value = formulaSvc:CalcBaseByPercent(damage, self._vampireParam[2])
  local matchType = self._world:MatchType()
  if matchType == MatchType.MT_PopStarPro and self._popStar then
    local popSarProSvc = self._world:GetService("PopStarProLogic")
    if popSarProSvc then
      local modifyType = self._popStar[1] or BuffPopStarProModifyType.None
      local basePercent = self._popStar[2] or 0
      local count = popSarProSvc:GetCountByModifyType(modifyType)
      value = value * basePercent * count
    end
  end
  local rate = attacker:Attributes():GetAttribute("AddBloodRate") or 0
  local rate2 = targetHPEntity:Attributes():GetAttribute("AddBloodRate") or 0
  value = value * (1 + rate + rate2)
  local vampire = skillCtx:TryVampireOnce(self._vampireParam[1], value, self._vampireParam[3], false)
  local calcDamageSvc = self._world:GetService("CalcDamage")
  local damageInfo = DamageInfo:New(vampire, DamageType.Recover)
  calcDamageSvc:AddTargetHP(targetHPEntity:GetID(), damageInfo)
  damageInfo:SetHPShield(targetHPEntity:BuffComponent():GetBuffValue("HPShield"))
  local result = BuffResultVampire:New(damageInfo)
  if self._changeSanType ~= BloodChangeSanType.None and 0 < vampire then
    result:SetAddSan(true)
    local attributesCmpt = targetHPEntity:Attributes()
    local maxHP = attributesCmpt:CalcMaxHp()
    local addHPPercent = vampire / maxHP * 100
    local addSan = math.ceil(addHPPercent)
    local curVal, oldVal, changeVal, debtVal, modifyTimes = self:CalculateSan(addSan)
    result:SetOldSanValue(oldVal)
    result:SetNewSanValue(curVal)
    result:SetModifySanValue(changeVal)
    result:SetDebtValue(debtVal)
    result:SetModifyTimes(modifyTimes)
    local nt = NTSanValueChange:New(curVal, oldVal, debtVal, modifyTimes)
    self._world:GetService("Trigger"):Notify(nt)
  end
  local notifyType = notify:GetNotifyType()
  if notifyType == NotifyType.NormalEachAttackEnd then
    result.attacker = notify:GetAttackerEntity()
    result.defender = notify:GetDefenderEntity()
    result.attackPos = notify:GetAttackPos()
    result.targetPos = notify:GetTargetPos()
  end
  if notify.GetNormalAttackIndex then
    result.normalAttackIndex = notify:GetNormalAttackIndex()
  end
  return result
end

function BuffLogicVampire:CalculateSan(addSan)
  local svc = self._world:GetService("FeatureLogic")
  if self._changeSanType == BloodChangeSanType.Add then
    return svc:IncreaseSanValue(addSan)
  elseif self._changeSanType == BloodChangeSanType.Reduce then
    return svc:DecreaseSanValue(addSan)
  end
end
