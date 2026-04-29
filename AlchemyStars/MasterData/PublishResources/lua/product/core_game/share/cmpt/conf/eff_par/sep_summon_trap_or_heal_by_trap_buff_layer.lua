_class("SkillEffectParam_SummonTrapOrHealByTrapBuffLayer", SkillEffectParamBase)
SkillEffectParam_SummonTrapOrHealByTrapBuffLayer = SkillEffectParam_SummonTrapOrHealByTrapBuffLayer

function SkillEffectParam_SummonTrapOrHealByTrapBuffLayer:Constructor(t)
  self._trapID = t.trapID
  self._layerBuffEffectType = t.layerBuffEffectType
  self._percentList = t.percentList
  local debugParam = {
    effectType = 185,
    trapID = 16017511,
    layerBuffEffectType = 4001753,
    percentList = {
      0.5,
      1,
      2,
      3
    }
  }
end

function SkillEffectParam_SummonTrapOrHealByTrapBuffLayer:GetEffectType()
  return SkillEffectType.SummonTrapOrHealByTrapBuffLayer
end

function SkillEffectParam_SummonTrapOrHealByTrapBuffLayer:GetTrapID()
  return self._trapID
end

function SkillEffectParam_SummonTrapOrHealByTrapBuffLayer:GetLayerBuffEffectType()
  return self._layerBuffEffectType
end

function SkillEffectParam_SummonTrapOrHealByTrapBuffLayer:GetPercentList()
  return self._percentList
end

function SkillEffectParam_SummonTrapOrHealByTrapBuffLayer:GetDisableDieSkill()
  return false
end
