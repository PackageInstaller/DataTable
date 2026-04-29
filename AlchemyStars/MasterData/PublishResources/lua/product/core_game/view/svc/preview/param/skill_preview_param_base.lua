_class("SkillPreviewParamBase", Object)
SkillPreviewParamBase = SkillPreviewParamBase

function SkillPreviewParamBase:Constructor(t)
  self._previewType = t.PreviewType
  self._param = t.Param
end

function SkillPreviewParamBase:GetPreviewType()
  return self._previewType
end

function SkillPreviewParamBase:GetPreviewParam()
  return self._param
end

function SkillPreviewParamBase:ParseParam()
end
