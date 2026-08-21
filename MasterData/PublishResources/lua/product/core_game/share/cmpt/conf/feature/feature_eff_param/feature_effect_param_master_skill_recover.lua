_class("FeatureEffectParamMasterSkillRecover", FeatureEffectParamBase)
FeatureEffectParamMasterSkillRecover = FeatureEffectParamMasterSkillRecover

function FeatureEffectParamMasterSkillRecover:Constructor(t)
  if not t then
    return
  end
  self:_RefreshData(t)
end

function FeatureEffectParamMasterSkillRecover:_RefreshData(t)
  if not t then
    return
  end
  if t.SkillID then
    self._skillID = t.SkillID
  end
end

function FeatureEffectParamMasterSkillRecover:GetMasterSkillID()
  return self._skillID
end

function FeatureEffectParamMasterSkillRecover:GetUiType()
  return FeatureMasterSkillUiType.Default
end

function FeatureEffectParamMasterSkillRecover:GetImageNormalFront()
  return self._imageNormalFront
end

function FeatureEffectParamMasterSkillRecover:GetImageWarningFront()
  return self._imageWarningFront
end

function FeatureEffectParamMasterSkillRecover:GetImageNormalBg()
  return self._imageNormalBg
end

function FeatureEffectParamMasterSkillRecover:GetImageWarningBg()
  return self._imageWarningBg
end

function FeatureEffectParamMasterSkillRecover:GetHideUIIcon()
  return self._hideUIIcon
end
