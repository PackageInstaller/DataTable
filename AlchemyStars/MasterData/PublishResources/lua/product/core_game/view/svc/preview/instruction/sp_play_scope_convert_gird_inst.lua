require("sp_base_inst")
_class("SkillPreviewPlayScopeConvertGridInstruction", SkillPreviewBaseInstruction)
SkillPreviewPlayScopeConvertGridInstruction = SkillPreviewPlayScopeConvertGridInstruction

function SkillPreviewPlayScopeConvertGridInstruction:Constructor(params)
  self.createConvertGrid = tonumber(params.createConvertGrid) == 1
end

function SkillPreviewPlayScopeConvertGridInstruction:DoInstruction(TT, casterEntity, previewContext)
  self._world = previewContext:GetWorld()
  local previewActiveSkillService = self._world:GetService("PreviewActiveSkill")
  local scopeGridList = previewContext:GetScopeResult()
  local previewEffectCalcService = self._world:GetService("PreviewCalcEffect")
  local effectList = previewContext:GetEffect(SkillEffectType.ConvertGridElement)
  local effectParam = previewEffectCalcService:CreateSkillEffectParam(SkillEffectType.ConvertGridElement, effectList)
  local result = previewEffectCalcService:CalcConvertGridElement(casterEntity, scopeGridList, effectParam)
  previewActiveSkillService:DoConvertElement(TT, result:GetTargetGridArray(), result:GetTargetElementType(), casterEntity, result:GetBlockGridArray(), self.createConvertGrid)
end
