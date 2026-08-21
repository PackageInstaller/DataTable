require("sp_base_inst")
_class("SkillPreviewPlayDeletePickUpEffectInstruction", SkillPreviewBaseInstruction)
SkillPreviewPlayDeletePickUpEffectInstruction = SkillPreviewPlayDeletePickUpEffectInstruction

function SkillPreviewPlayDeletePickUpEffectInstruction:Constructor(params)
end

function SkillPreviewPlayDeletePickUpEffectInstruction:DoInstruction(TT, casterEntity, previewContext)
  local previewActiveSkillService = previewContext:GetWorld():GetService("PreviewActiveSkill")
  local world = casterEntity:GetOwnerWorld()
  local previewPickUpComponent = casterEntity:PreviewPickUpComponent()
  if not previewPickUpComponent then
    return
  end
  local entityIDs = previewPickUpComponent:GetPickUpEffectEntityIDArray()
  local world = casterEntity:GetOwnerWorld()
  for _, id in ipairs(entityIDs) do
    local e = world:GetEntityByID(id)
    if e then
      world:DestroyEntity(e)
    end
  end
  previewPickUpComponent:ClearPickUpEffectEntityIDArray()
end
