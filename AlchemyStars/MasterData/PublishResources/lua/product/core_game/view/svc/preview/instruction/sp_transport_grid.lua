require("sp_base_inst")
_class("SkillPreviewTransportGridInstruction", SkillPreviewBaseInstruction)
SkillPreviewTransportGridInstruction = SkillPreviewTransportGridInstruction

function SkillPreviewTransportGridInstruction:Constructor(params)
  self._movePickUpMonster = false
  if params.MovePickUpMonster and params.MovePickUpMonster == "true" then
    self._movePickUpMonster = true
  end
end

function SkillPreviewTransportGridInstruction:DoInstruction(TT, casterEntity, previewContext)
  self._world = previewContext:GetWorld()
  local previewActiveSkillService = self._world:GetService("PreviewActiveSkill")
  local previewPickUpComponent = casterEntity:PreviewPickUpComponent()
  local pickUpPosList = previewPickUpComponent:GetAllValidPickUpGridPos()
  if not pickUpPosList or #pickUpPosList ~= 2 then
    return
  end
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local range = utilScopeSvc:CalcRangeByPickUpPosList(pickUpPosList)
  previewActiveSkillService:DoConvert(range, "Normal", "Dark")
  local previewEffectCalcService = self._world:GetService("PreviewCalcEffect")
  local effectList = previewContext:GetEffect(SkillEffectType.TransportByRange)
  local effectParam = previewEffectCalcService:CreateSkillEffectParam(SkillEffectType.TransportByRange, effectList)
  local result = previewEffectCalcService:CalcTransportByRange(casterEntity, previewContext, effectParam, pickUpPosList)
  previewActiveSkillService:PlayTransportPreview(TT, casterEntity, result)
end
