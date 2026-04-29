require("sp_base_inst")
_class("SkillPreviewRevertConvertAnimInstruction", SkillPreviewBaseInstruction)
SkillPreviewRevertConvertAnimInstruction = SkillPreviewRevertConvertAnimInstruction

function SkillPreviewRevertConvertAnimInstruction:Constructor(params)
end

function SkillPreviewRevertConvertAnimInstruction:DoInstruction(TT, casterEntity, previewContext)
  local world = previewContext:GetWorld()
  local previewActiveSkillService = world:GetService("PreviewActiveSkill")
  previewActiveSkillService:_RevertAllConvertElement()
end
