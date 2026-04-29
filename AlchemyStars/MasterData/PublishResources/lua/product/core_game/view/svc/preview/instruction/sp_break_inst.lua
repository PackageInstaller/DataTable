require("sp_base_inst")
_class("SkillPreviewBreakInstruction", SkillPreviewBaseInstruction)
SkillPreviewBreakInstruction = SkillPreviewBreakInstruction

function SkillPreviewBreakInstruction:Constructor(params)
end

function SkillPreviewBreakInstruction:DoInstruction(TT, casterEntity, previewContext)
  previewContext:SetBreakState(true)
  local previewActiveSkillService = previewContext:GetWorld():GetService("PreviewActiveSkill")
  previewActiveSkillService:ResetPreview()
end
