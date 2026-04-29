require("sp_base_inst")
_class("SkillPreviewPlayDeletePreviewEffectInstruction", SkillPreviewBaseInstruction)
SkillPreviewPlayDeletePreviewEffectInstruction = SkillPreviewPlayDeletePreviewEffectInstruction

function SkillPreviewPlayDeletePreviewEffectInstruction:Constructor(params)
end

function SkillPreviewPlayDeletePreviewEffectInstruction:DoInstruction(TT, casterEntity, previewContext)
  local previewStrageEffectRecordComponent = casterEntity:PreviewStageEffectRecord()
  if previewStrageEffectRecordComponent then
    local entityIDs = previewStrageEffectRecordComponent:GetPreviewStageEffectEntityIDList()
    local world = casterEntity:GetOwnerWorld()
    for _, id in ipairs(entityIDs) do
      local e = world:GetEntityByID(id)
      if e then
        world:DestroyEntity(e)
      end
    end
    previewStrageEffectRecordComponent:ClearPreviewStageEffectEntityIDList()
  end
end
