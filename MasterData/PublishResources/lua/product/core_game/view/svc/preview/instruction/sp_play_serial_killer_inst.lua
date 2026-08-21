require("sp_base_inst")
_class("SkillPreviewPlaySerialKillerInstruction", SkillPreviewBaseInstruction)
SkillPreviewPlaySerialKillerInstruction = SkillPreviewPlaySerialKillerInstruction

function SkillPreviewPlaySerialKillerInstruction:Constructor(params)
  self._otherAnim = params.OtherAnim
  self._noOtherAnim = tonumber(params.NoOtherAnim)
end

function SkillPreviewPlaySerialKillerInstruction:DoInstruction(TT, casterEntity, previewContext)
  self._world = previewContext:GetWorld()
  local previewActiveSkillService = self._world:GetService("PreviewActiveSkill")
  local targetIDList = previewContext:GetTargetEntityIDList()
  local previewEffectCalcService = self._world:GetService("PreviewCalcEffect")
  local scopeGridList = previewContext:GetScopeResult()
  local effectList = previewContext:GetEffect(SkillEffectType.SerialKiller)
  local effectParam = previewEffectCalcService:CreateSkillEffectParam(SkillEffectType.SerialKiller, effectList)
  local result = previewEffectCalcService:CalcSerialKiller(casterEntity:GetID(), targetIDList, effectParam)
  local posList = result:GetAddPiecePosList()
  if self._noOtherAnim == 1 then
    previewActiveSkillService:DoConvert(posList, "Add")
  else
    previewActiveSkillService:DoConvert(posList, "Add", "Dark")
  end
end
