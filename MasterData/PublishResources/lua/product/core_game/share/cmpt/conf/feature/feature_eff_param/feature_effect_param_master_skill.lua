_class("FeatureEffectParamMasterSkill", FeatureEffectParamBase)
FeatureEffectParamMasterSkill = FeatureEffectParamMasterSkill

function FeatureEffectParamMasterSkill:Constructor(t)
  if not t then
    return
  end
  self:_RefreshData(t)
end

function FeatureEffectParamMasterSkill:_RefreshData(t)
  if not t then
    return
  end
  if t.SkillID then
    self._skillID = t.SkillID
  end
  if t.UiType then
    self._uiType = t.UiType
  end
  if t.ImageNormalFront then
    self._imageNormalFront = t.ImageNormalFront
  end
  if t.ImageWarningFront then
    self._imageWarningFront = t.ImageWarningFront
  end
  if t.ImageNormalBg then
    self._imageNormalBg = t.ImageNormalBg
  end
  if t.ImageWarningBg then
    self._imageWarningBg = t.ImageWarningBg
  end
  if t.HideUIIcon then
    self._hideUIIcon = t.HideUIIcon
  end
end

function FeatureEffectParamMasterSkill:GetMasterSkillID()
  return self._skillID
end

function FeatureEffectParamMasterSkill:GetUiType()
  return self._uiType or FeatureMasterSkillUiType.Default
end

function FeatureEffectParamMasterSkill:GetImageNormalFront()
  return self._imageNormalFront
end

function FeatureEffectParamMasterSkill:GetImageWarningFront()
  return self._imageWarningFront
end

function FeatureEffectParamMasterSkill:GetImageNormalBg()
  return self._imageNormalBg
end

function FeatureEffectParamMasterSkill:GetImageWarningBg()
  return self._imageWarningBg
end

function FeatureEffectParamMasterSkill:GetHideUIIcon()
  return self._hideUIIcon
end
