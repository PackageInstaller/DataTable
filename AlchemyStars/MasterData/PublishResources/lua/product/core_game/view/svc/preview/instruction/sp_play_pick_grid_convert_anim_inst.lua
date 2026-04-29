require("sp_base_inst")
_class("SkillPreviewPlayPickGridConvertAnimInstruction", SkillPreviewBaseInstruction)
SkillPreviewPlayPickGridConvertAnimInstruction = SkillPreviewPlayPickGridConvertAnimInstruction

function SkillPreviewPlayPickGridConvertAnimInstruction:Constructor(params)
end

function SkillPreviewPlayPickGridConvertAnimInstruction:DoInstruction(TT, casterEntity, previewContext)
  local previewPickUpComponent = casterEntity:PreviewPickUpComponent()
  self._world = previewContext:GetWorld()
  local previewActiveSkillService = self._world:GetService("PreviewActiveSkill")
  local scopeGridList = previewPickUpComponent:GetAllValidPickUpGridPos()
  local previewEffectCalcService = self._world:GetService("PreviewCalcEffect")
  local effectList = previewContext:GetEffect(SkillEffectType.ConvertGridElement)
  local effectParam = previewEffectCalcService:CreateSkillEffectParam(SkillEffectType.ConvertGridElement, effectList)
  local result = previewEffectCalcService:CalcConvertGridElement(casterEntity, scopeGridList, effectParam)
  previewActiveSkillService:DoConvertElement(TT, result:GetTargetGridArray(), result:GetTargetElementType(), casterEntity, result:GetBlockGridArray())
end
