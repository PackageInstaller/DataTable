require("skill_damage_effect_param")
_class("SkillEffectParam_GatherThrowDamage", SkillEffectParamBase)
SkillEffectParam_GatherThrowDamage = SkillEffectParam_GatherThrowDamage

function SkillEffectParam_GatherThrowDamage:Constructor(t)
  self._monsterClassIdDic = {}
  if type(t.monsterClassID) == "number" then
    self._monsterClassIdDic[t.monsterClassID] = true
  elseif type(t.monsterClassID) == "table" then
    for _, id in ipairs(t.monsterClassID) do
      self._monsterClassIdDic[id] = true
    end
  end
  self._transPosList = {}
  if t.transPosList then
    for _, posInfo in ipairs(t.transPosList) do
      local posV = Vector2(posInfo[1], posInfo[2])
      table.insert(self._transPosList, posV)
    end
  end
  self._teleportParam = SkillEffectParam_Teleport:New(t)
  self._basePercent = t.basePercent
  self._addValue = t.addValue
  self._damageScopeType = t.damageScopeType
  self._damageScopeParam = t.damageScopeParam
  self._damageScopeCenterType = t.damageScopeCenterType
  self._damageTargetType = t.damageTargetType
  self._formulaID = t.formulaID
end

function SkillEffectParam_GatherThrowDamage:GetBasePercent()
  return self._basePercent
end

function SkillEffectParam_GatherThrowDamage:GetMonsterClassIdDic()
  return self._monsterClassIdDic
end

function SkillEffectParam_GatherThrowDamage:GetAddValue()
  return self._addValue
end

function SkillEffectParam_GatherThrowDamage:GetDamageScopeType()
  return self._damageScopeType
end

function SkillEffectParam_GatherThrowDamage:GetDamageScopeParam()
  return self._damageScopeParam
end

function SkillEffectParam_GatherThrowDamage:GetDamageScopeCenterType()
  return self._damageScopeCenterType
end

function SkillEffectParam_GatherThrowDamage:GetDamageTargetType()
  return self._damageTargetType
end

function SkillEffectParam_GatherThrowDamage:GetEffectType()
  return SkillEffectType.GatherThrowDamage
end

function SkillEffectParam_GatherThrowDamage:GetThrowDamageFormulaID()
  return self._formulaID
end

function SkillEffectParam_GatherThrowDamage:GetTeleportParam()
  return self._teleportParam
end

function SkillEffectParam_GatherThrowDamage:GetTeleportScope()
  return self._transPosList
end
