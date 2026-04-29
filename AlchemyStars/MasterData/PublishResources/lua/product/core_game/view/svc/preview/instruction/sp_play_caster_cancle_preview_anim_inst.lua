require("sp_base_inst")
_class("SkillPreviewPlayCasterCancelPreviewAnimInstruction", SkillPreviewBaseInstruction)
SkillPreviewPlayCasterCancelPreviewAnimInstruction = SkillPreviewPlayCasterCancelPreviewAnimInstruction

function SkillPreviewPlayCasterCancelPreviewAnimInstruction:Constructor(params)
  self._anim = params.Anim or "AtkUltPreviewCancel"
end

function SkillPreviewPlayCasterCancelPreviewAnimInstruction:DoInstruction(TT, casterEntity, previewContext)
  local world = previewContext:GetWorld()
  local previewActiveSkillSvc = world:GetService("PreviewActiveSkill")
  previewActiveSkillSvc:PlayCasterPreviewAnim(casterEntity, false, self._anim)
end
