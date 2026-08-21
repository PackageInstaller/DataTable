require("sp_base_inst")
_class("SkillPreviewRevertPieceAnimInstruction", SkillPreviewBaseInstruction)
SkillPreviewRevertPieceAnimInstruction = SkillPreviewRevertPieceAnimInstruction

function SkillPreviewRevertPieceAnimInstruction:Constructor(params)
end

function SkillPreviewRevertPieceAnimInstruction:DoInstruction(TT, casterEntity, previewContext)
  local world = previewContext:GetWorld()
  local previewActiveSkillService = world:GetService("PreviewActiveSkill")
  previewActiveSkillService:_RevertBright()
end
