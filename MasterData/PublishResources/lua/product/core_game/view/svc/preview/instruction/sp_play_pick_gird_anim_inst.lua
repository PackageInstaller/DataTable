require("sp_base_inst")
_class("SkillPreviewPlayPickAnimInstruction", SkillPreviewBaseInstruction)
SkillPreviewPlayPickAnimInstruction = SkillPreviewPlayPickAnimInstruction

function SkillPreviewPlayPickAnimInstruction:Constructor(params)
  self._anim = params.Anim
end

function SkillPreviewPlayPickAnimInstruction:DoInstruction(TT, casterEntity, previewContext)
  self._world = previewContext:GetWorld()
  local previewActiveSkillService = self._world:GetService("PreviewActiveSkill")
  local allPickUpPos = previewContext:GetPickUpPos()
  previewActiveSkillService:DoConvert({allPickUpPos}, self._anim)
end
