require("sp_base_inst")
_class("SkillPreviewPlayPickUpGridTogetherInstruction", SkillPreviewBaseInstruction)
SkillPreviewPlayPickUpGridTogetherInstruction = SkillPreviewPlayPickUpGridTogetherInstruction

function SkillPreviewPlayPickUpGridTogetherInstruction:Constructor(params)
end

function SkillPreviewPlayPickUpGridTogetherInstruction:DoInstruction(TT, casterEntity, previewContext)
  self._world = previewContext:GetWorld()
  local previewActiveSkillService = self._world:GetService("PreviewActiveSkill")
  local previewPickUpComponent = casterEntity:PreviewPickUpComponent()
  local pickUpPosList = previewPickUpComponent:GetAllValidPickUpGridPos()
  local scopeGridList = previewContext:GetScopeResult()
  previewActiveSkillService:DoConvert(scopeGridList, "Normal", "Dark")
  local previewEffectCalcService = self._world:GetService("PreviewCalcEffect")
  local effectList = previewContext:GetEffect(SkillEffectType.PickUpGridTogether)
  local effectParam = previewEffectCalcService:CreateSkillEffectParam(SkillEffectType.PickUpGridTogether, effectList)
  local result = previewEffectCalcService:CalcPickUpGridTogether(casterEntity, previewContext, effectParam, pickUpPosList)
  previewActiveSkillService:PlayPickUpGridTogether(TT, result:GetNewGridDataList(), casterEntity, nil)
end
