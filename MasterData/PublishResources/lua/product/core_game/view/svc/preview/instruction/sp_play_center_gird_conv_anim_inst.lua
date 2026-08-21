require("sp_base_inst")
_class("SkillPreviewPlayScopeCenterGridConvertAnimInstruction", SkillPreviewBaseInstruction)
SkillPreviewPlayScopeCenterGridConvertAnimInstruction = SkillPreviewPlayScopeCenterGridConvertAnimInstruction

function SkillPreviewPlayScopeCenterGridConvertAnimInstruction:Constructor(params)
end

function SkillPreviewPlayScopeCenterGridConvertAnimInstruction:DoInstruction(TT, casterEntity, previewContext)
  self._world = previewContext:GetWorld()
  local scopeCenterPosList = previewContext:GetScopeCenterPosList()
  local previewActiveSkillService = self._world:GetService("PreviewActiveSkill")
  local previewEffectCalcService = self._world:GetService("PreviewCalcEffect")
  local effectList = previewContext:GetEffect(SkillEffectType.ConvertGridElement)
  local effectParam = previewEffectCalcService:CreateSkillEffectParam(SkillEffectType.ConvertGridElement, effectList)
  local result = previewEffectCalcService:CalcConvertGridElement(casterEntity, scopeCenterPosList, effectParam)
  previewActiveSkillService:DoConvertElement(TT, result:GetTargetGridArray(), result:GetTargetElementType(), casterEntity, result:GetBlockGridArray())
end
