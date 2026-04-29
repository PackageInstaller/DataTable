_class("BuffLogicAddHPBySanChange", BuffLogicBase)
BuffLogicAddHPBySanChange = BuffLogicAddHPBySanChange

function BuffLogicAddHPBySanChange:Constructor(buffInstance, logicParam)
  self._reduceRatePerSan = tonumber(logicParam.reduceRatePerSan)
  self._maxAddHPPercent = tonumber(logicParam.maxAddHPPercent) or 0
end

function BuffLogicAddHPBySanChange:DoLogic(notify)
  if not NTSanValueChange:IsInstanceOfType(notify) then
    return
  end
  if self._entity:HasDeadMark() or self._entity:HasPetDeadMark() then
    return
  end
  local teamEntity
  if self._entity:HasTeam() then
    teamEntity = self._entity
  elseif self._entity:HasPetPstID() then
    teamEntity = self._entity:Pet():GetOwnerTeamEntity()
  end
  if teamEntity and teamEntity:Attributes():GetAttribute("BuffForbidCure") then
    return
  end
  local baseAtk = self._entity:Attributes():GetAttack()
  local val = baseAtk * math.abs(notify:GetCurValue() - notify:GetOldValue()) * self._reduceRatePerSan
  local lossSanRate = 0
  if 0 < self._maxAddHPPercent then
    local lsvcFeature = self._world:GetService("FeatureLogic")
    local sanVal = lsvcFeature:GetSanValue()
    local maxSanValue = lsvcFeature:GetSanMaxValue()
    if maxSanValue <= 0 then
      return
    end
    lossSanRate = 1 - sanVal / maxSanValue
    val = val * (1 + self._maxAddHPPercent * lossSanRate)
  end
  local rate = self._entity:Attributes():GetAttribute("AddBloodRate") or 0
  val = val * (1 + rate)
  local eAddHPTarget = self._entity
  if self._entity:HasPet() then
    eAddHPTarget = self._entity:Pet():GetOwnerTeamEntity()
  end
  local calcDamage = self._world:GetService("CalcDamage")
  local damageInfo = DamageInfo:New(val, DamageType.Recover)
  calcDamage:AddTargetHP(eAddHPTarget:GetID(), damageInfo)
  self._world:GetMatchLogger():BeginBuff(self._entity:GetID(), self._buffInstance:BuffID())
  local logger = self._world:GetMatchLogger()
  logger:AddBloodLog(self._entity:GetID(), {
    key = "CalcAddBlood",
    desc = "BUFF加血 攻击者[attacker] 被击者[defender] 加血量[blood] 回血系数[rate]",
    attacker = self._entity:GetID(),
    defender = self._entity:GetID(),
    blood = val,
    rate = lossSanRate
  })
  self._world:GetMatchLogger():EndBuff(self._entity:GetID())
  return BuffResultAddHPBySanChange:New(damageInfo, notify)
end
