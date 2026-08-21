require("sp_base_inst")
_class("SkillPreviewPlayAbsorbInstruction", SkillPreviewBaseInstruction)
SkillPreviewPlayAbsorbInstruction = SkillPreviewPlayAbsorbInstruction

function SkillPreviewPlayAbsorbInstruction:Constructor(params)
  self._waitTime = params.WaitTimeMs or 500
end

function SkillPreviewPlayAbsorbInstruction:DoInstruction(TT, casterEntity, previewContext)
end
