require("sp_base_inst")
_class("SkillPreviewPlayCasterAnimInstruction", SkillPreviewBaseInstruction)
SkillPreviewPlayCasterAnimInstruction = SkillPreviewPlayCasterAnimInstruction

function SkillPreviewPlayCasterAnimInstruction:Constructor(params)
  self._anim = params.Anim
end

function SkillPreviewPlayCasterAnimInstruction:DoInstruction(TT, casterEntity, previewContext)
  casterEntity:SetAnimatorControllerTriggers({
    self._anim
  })
end
