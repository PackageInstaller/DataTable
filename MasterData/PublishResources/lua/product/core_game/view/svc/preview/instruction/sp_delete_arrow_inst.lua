require("sp_base_inst")
_class("SkillPreviewDeleteArrowInstruction", SkillPreviewBaseInstruction)
SkillPreviewDeleteArrowInstruction = SkillPreviewDeleteArrowInstruction

function SkillPreviewDeleteArrowInstruction:Constructor(params)
  self._number = params.Number
end

function SkillPreviewDeleteArrowInstruction:DoInstruction(TT, casterEntity, previewContext)
  local world = previewContext:GetWorld()
  local previewActiveSkillService = world:GetService("PreviewActiveSkill")
  previewActiveSkillService:DestroyPickUpArrow()
end
