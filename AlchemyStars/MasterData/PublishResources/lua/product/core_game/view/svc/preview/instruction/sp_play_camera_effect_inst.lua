require("sp_base_inst")
_class("SkillPreviewPlayCameraEffectInstruction", SkillPreviewBaseInstruction)
SkillPreviewPlayCameraEffectInstruction = SkillPreviewPlayCameraEffectInstruction

function SkillPreviewPlayCameraEffectInstruction:Constructor(params)
  self._effectID = tonumber(params.EffectID)
end

function SkillPreviewPlayCameraEffectInstruction:DoInstruction(TT, casterEntity, phaseContext)
  if self._effectID and self._effectID > 0 then
    local world = casterEntity:GetOwnerWorld()
    local serEffect = world:GetService("Effect")
    local effEntity = serEffect:CreateScreenEffPointEffect(self._effectID)
    if not casterEntity:HasPreviewStageEffectRecord() then
      casterEntity:AddPreviewStageEffectRecord()
    end
    local preEffRecordCmpt = casterEntity:PreviewStageEffectRecord()
    if preEffRecordCmpt then
      preEffRecordCmpt:AddPreviewStageEffectEntityID(effEntity:GetID())
    end
  end
end
