require("sp_base_inst")
_class("SkillPreviewRevertTransportGridInstruction", SkillPreviewBaseInstruction)
SkillPreviewRevertTransportGridInstruction = SkillPreviewRevertTransportGridInstruction

function SkillPreviewRevertTransportGridInstruction:Constructor(params)
end

function SkillPreviewRevertTransportGridInstruction:DoInstruction(TT, casterEntity, previewContext)
  local world = previewContext:GetWorld()
  local previewActiveSkillService = world:GetService("PreviewActiveSkill")
  previewActiveSkillService:RevertAllTransportGrid()
end
