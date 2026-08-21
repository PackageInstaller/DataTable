require("feature_effect_param_base")
_class("FeatureEffectParamBanPetSkill", FeatureEffectParamBase)
FeatureEffectParamBanPetSkill = FeatureEffectParamBanPetSkill

function FeatureEffectParamBanPetSkill:Constructor(t)
  if not t then
    return
  end
  self:_RefreshData(t)
end

function FeatureEffectParamBanPetSkill:_RefreshData(t)
  if not t then
    return
  end
  if t.BanNormalSkillID then
    self._banNormalSkillID = t.BanNormalSkillID
  end
  if t.BanChainSkillID then
    self._banChainSkillID = t.BanChainSkillID
  end
  if t.BanActiveSkillID then
    self._banActiveSkillID = t.BanActiveSkillID
  end
  if t.SkillCD then
    self._skillCD = t.SkillCD
  end
end

function FeatureEffectParamBanPetSkill:GetFeatureType()
  return FeatureType.BanPetSkill
end

function FeatureEffectParamBanPetSkill:GetBanNormalSkillID()
  return self._banNormalSkillID
end

function FeatureEffectParamBanPetSkill:GetBanChainSkillID()
  return self._banChainSkillID
end

function FeatureEffectParamBanPetSkill:GetBanActiveSkillID()
  return self._banActiveSkillID
end

function FeatureEffectParamBanPetSkill:GetSkillCD()
  return self._skillCD
end
