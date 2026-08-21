require("sp_base_inst")
_class("SkillPreviewDataSetHitBackDirInstruction", SkillPreviewBaseInstruction)
SkillPreviewDataSetHitBackDirInstruction = SkillPreviewDataSetHitBackDirInstruction

function SkillPreviewDataSetHitBackDirInstruction:Constructor(params)
end

function SkillPreviewDataSetHitBackDirInstruction:DoInstruction(TT, casterEntity, previewContext)
  local world = previewContext:GetWorld()
  local previewActiveSkillService = world:GetService("PreviewActiveSkill")
  local previewPickUpComponent = casterEntity:PreviewPickUpComponent()
  local dir = previewPickUpComponent:GetLastPickUpDirection()
  previewContext:SetHitBackDirType(dir)
end
