_class("FeatureEffectParamMasterSkillTeleport", FeatureEffectParamBase)
FeatureEffectParamMasterSkillTeleport = FeatureEffectParamMasterSkillTeleport

function FeatureEffectParamMasterSkillTeleport:Constructor(t)
  if not t then
    return
  end
  self:_RefreshData(t)
end

function FeatureEffectParamMasterSkillTeleport:_RefreshData(t)
  if not t then
    return
  end
  if t.SkillID then
    self._skillID = t.SkillID
  end
end

function FeatureEffectParamMasterSkillTeleport:GetMasterSkillID()
  return self._skillID
end

function FeatureEffectParamMasterSkillTeleport:GetUiType()
  return FeatureMasterSkillUiType.Default
end

function FeatureEffectParamMasterSkillTeleport:GetImageNormalFront()
  return self._imageNormalFront
end

function FeatureEffectParamMasterSkillTeleport:GetImageWarningFront()
  return self._imageWarningFront
end

function FeatureEffectParamMasterSkillTeleport:GetImageNormalBg()
  return self._imageNormalBg
end

function FeatureEffectParamMasterSkillTeleport:GetImageWarningBg()
  return self._imageWarningBg
end

function FeatureEffectParamMasterSkillTeleport:GetHideUIIcon()
  return self._hideUIIcon
end
