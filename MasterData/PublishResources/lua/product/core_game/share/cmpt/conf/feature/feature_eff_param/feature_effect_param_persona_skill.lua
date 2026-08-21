_class("FeatureEffectParamPersonaSkill", FeatureEffectParamBase)
FeatureEffectParamPersonaSkill = FeatureEffectParamPersonaSkill

function FeatureEffectParamPersonaSkill:Constructor(t)
  if not t then
    return
  end
  self:_RefreshData(t)
end

function FeatureEffectParamPersonaSkill:_RefreshData(t)
  if not t then
    return
  end
  if t.SkillID then
    self._skillID = t.SkillID
  end
end

function FeatureEffectParamPersonaSkill:GetFeatureType()
  return FeatureType.PersonaSkill
end

function FeatureEffectParamPersonaSkill:CopyFrom(param)
  if param then
    for k, v in pairs(param) do
      self[k] = v
    end
  end
end

function FeatureEffectParamPersonaSkill:CloneSelf()
  local param = FeatureEffectParamPersonaSkill:New()
  param:CopyFrom(self)
  return param
end

function FeatureEffectParamPersonaSkill:ReplaceByCustomCfg(t)
  self:_RefreshData(t)
end

function FeatureEffectParamPersonaSkill:GetPersonaSkillID()
  return self._skillID
end
