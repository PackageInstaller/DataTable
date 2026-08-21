require("sp_base_inst")
_class("SkillPreviewPlayFirstPickGridAnimInstruction", SkillPreviewBaseInstruction)
SkillPreviewPlayFirstPickGridAnimInstruction = SkillPreviewPlayFirstPickGridAnimInstruction

function SkillPreviewPlayFirstPickGridAnimInstruction:Constructor(params)
  self._anim = params.Anim
end

function SkillPreviewPlayFirstPickGridAnimInstruction:DoInstruction(TT, casterEntity, previewContext)
  local previewPickUpComponent = casterEntity:PreviewPickUpComponent()
  self._world = previewContext:GetWorld()
  local previewActiveSkillService = self._world:GetService("PreviewActiveSkill")
  local pickUpGridPos = previewPickUpComponent:GetFirstValidPickUpGridPos()
  previewActiveSkillService:DoConvert({pickUpGridPos}, self._anim)
end
