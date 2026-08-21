_class("SkillContextComponent", Object)
SkillContextComponent = SkillContextComponent

function SkillContextComponent:Constructor()
  self._vampireDevice = VampireLimitDevice:New()
  self._finalDamageFixMap = {}
  self._hasDamage = {}
  self._effectResultContainer = SkillEffectResultContainer:New()
  self._splashBaseDamage = 0
  self._conductBaseDamage = 0
  self._currentConductRate = 0
  self._damagePctIncreaseBuffEffectType = 0
  self._damagePctIncreaseMul = 0
  self._degressiveDamageParam = 1
  self._damageDampList = {}
  self._sacrificedHP = 0
end

function SkillContextComponent:GetDamagePctIncreaseBuffEffectType()
  return self._damagePctIncreaseBuffEffectType
end

function SkillContextComponent:GetDamagePctIncreaseMul()
  return self._damagePctIncreaseMul
end

function SkillContextComponent:SetDamagePctIncreaseBuffEffectType(val)
  self._damagePctIncreaseBuffEffectType = val
end

function SkillContextComponent:SetDamagePctIncreaseMul(val)
  self._damagePctIncreaseMul = val
end

function SkillContextComponent:GetResultContainer()
  return self._effectResultContainer
end

function SkillContextComponent:AddDamage(targetId, damage)
  if not self._hasDamage[targetId] then
    self._hasDamage[targetId] = {}
  end
  table.insert(self._hasDamage[targetId], damage)
end

function SkillContextComponent:GetDamage(targetId)
  return self._hasDamage[targetId]
end

function SkillContextComponent:HasDamageInfoFor(targetId)
  return self._hasDamage[targetId] and #self._hasDamage[targetId] > 0
end

function SkillContextComponent:IsEntityDamaged(targetId, nonMissOnly)
  if not self:HasDamageInfoFor(targetId) then
    return false
  end
  local result = false
  for _, damageInfo in ipairs(self._hasDamage[targetId]) do
    if nonMissOnly then
      result = result or damageInfo:GetDamageType() ~= DamageType.Miss
    else
      result = result or damageInfo:GetDamageValue() > 0
    end
  end
  return result
end

function SkillContextComponent:TryVampireOnce(cfgBase, value, cfgCeiling, fromSkill)
  local open, paramFromSkill = self._vampireDevice:Status()
  if open then
    if not paramFromSkill and fromSkill then
      self._vampireDevice:SetLimit(cfgBase, cfgCeiling, fromSkill)
      Log.fatal("[Vampire] 吸血参数重置为技能")
    end
  else
    self._vampireDevice:SetLimit(cfgBase, cfgCeiling, fromSkill)
  end
  return self._vampireDevice:ConsumeLimit(value)
end

function SkillContextComponent:AddFinalDamageFix(targetEntityID, mulVal)
  if not self._finalDamageFixMap[targetEntityID] then
    self._finalDamageFixMap[targetEntityID] = {}
  end
  table.insert(self._finalDamageFixMap[targetEntityID], FinalDamageFixData:New(targetEntityID, mulVal))
end

function SkillContextComponent:GetFinalDamageFixMulVal(targetEntityID, sourceKey)
  local mulVal = 0
  if not self._finalDamageFixMap[targetEntityID] then
    return mulVal
  end
  for _, data in ipairs(self._finalDamageFixMap[targetEntityID]) do
    mulVal = mulVal + data:GetMulVal()
  end
  return mulVal
end

function SkillContextComponent:SetCurrentConductRate(rate)
  self._currentConductRate = rate
end

function SkillContextComponent:GetCurrentConductRate()
  return self._currentConductRate
end

function SkillContextComponent:SetConductBaseDamage(damage)
  self._conductBaseDamage = damage
end

function SkillContextComponent:GetConductBaseDamage()
  return self._conductBaseDamage
end

function SkillContextComponent:GetDamagePctIncreaseBuffEffectType()
  return self._damagePctIncreaseBuffEffectType
end

function SkillContextComponent:GetDamagePctIncreaseMul()
  return self._damagePctIncreaseMul
end

function SkillContextComponent:SetDamagePctIncreaseBuffEffectType(val)
  self._damagePctIncreaseBuffEffectType = val
end

function SkillContextComponent:SetDamagePctIncreaseMul(val)
  self._damagePctIncreaseMul = val
end

function SkillContextComponent:GetDegressiveDamageParam()
  return self._degressiveDamageParam
end

function SkillContextComponent:SetDegressiveDamageParam(v)
  self._degressiveDamageParam = v
end

function SkillContextComponent:SetSplashBaseDamage(v)
  self._splashBaseDamage = v
end

function SkillContextComponent:GetSplashBaseDamage()
  return self._splashBaseDamage
end

function SkillContextComponent:GetDamageDampList()
  return self._damageDampList
end

function SkillContextComponent:SetDamageDampList(t)
  self._damageDampList = t
end

function SkillContextComponent:SetSacrificedHP(v)
  self._sacrificedHP = v
end

function SkillContextComponent:GetSacrificedHP()
  return self._sacrificedHP
end

function Entity:AddSkillContext()
  local index = self.WEComponentsEnum.SkillContext
  local component = SkillContextComponent:New()
  return self:AddComponent(index, component)
end

function Entity:SkillContext()
  return self:GetComponent(self.WEComponentsEnum.SkillContext)
end

function Entity:HasSkillContext()
  return self:HasComponent(self.WEComponentsEnum.SkillContext)
end

function Entity:RemoveSkillContext()
  if self:HasSkillContext() then
    self:RemoveComponent(self.WEComponentsEnum.SkillContext)
  end
end

function Entity:ReplaceSkillContext()
  local index = self.WEComponentsEnum.SkillContext
  local component = SkillContextComponent:New()
  self:ReplaceComponent(index, component)
end
