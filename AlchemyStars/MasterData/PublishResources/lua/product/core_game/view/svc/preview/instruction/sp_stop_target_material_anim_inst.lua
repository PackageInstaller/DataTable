require("sp_base_inst")
_class("SkillPreviewStopTargetMaterialAnimInstruction", SkillPreviewBaseInstruction)
SkillPreviewStopTargetMaterialAnimInstruction = SkillPreviewStopTargetMaterialAnimInstruction

function SkillPreviewStopTargetMaterialAnimInstruction:Constructor(params)
end

function SkillPreviewStopTargetMaterialAnimInstruction:DoInstruction(TT, casterEntity, previewContext)
  local world = previewContext:GetWorld()
  local targetIDList = previewContext:GetTargetEntityIDList()
  targetIDList = table.unique(targetIDList)
  for _, id in pairs(targetIDList) do
    local entity = world:GetEntityByID(id)
    if entity then
      if entity:HasTeam() then
        entity = entity:GetTeamLeaderPetEntity()
      end
      local comp = entity:MaterialAnimationComponent()
      if comp then
        comp:StopLayer(MaterialAnimLayer.SkillPreview)
      end
    end
  end
end
