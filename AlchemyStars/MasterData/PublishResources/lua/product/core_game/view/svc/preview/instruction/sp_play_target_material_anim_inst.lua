require("sp_base_inst")
_class("SkillPreviewPlayTargetMaterialAnimInstruction", SkillPreviewBaseInstruction)
SkillPreviewPlayTargetMaterialAnimInstruction = SkillPreviewPlayTargetMaterialAnimInstruction

function SkillPreviewPlayTargetMaterialAnimInstruction:Constructor(params)
  self._anim = params.Anim
end

function SkillPreviewPlayTargetMaterialAnimInstruction:DoInstruction(TT, casterEntity, previewContext)
  local world = previewContext:GetWorld()
  local targetIDList = previewContext:GetTargetEntityIDList()
  targetIDList = table.unique(targetIDList)
  for _, id in pairs(targetIDList) do
    local entity = world:GetEntityByID(id)
    if entity and entity:HasTeam() then
      entity = entity:GetTeamLeaderPetEntity()
    end
    if entity and entity:HasMaterialAnimationComponent() and not entity:BuffView():HasBuffEffect(BuffEffectType.NotPlayMaterialAnimation) then
      if self._anim == "Flash" then
        entity:NewEnableFlash()
      elseif self._anim == "Transparent" then
        entity:NewEnableTransparent()
      elseif self._anim == "Ghost" then
        entity:NewEnableGhost()
      elseif self._anim == "FlashAlpha" then
        entity:NewEnableFlashAlpha()
      elseif self._anim == "N15Cure" then
        entity:PlayN15CureMaterialAnim()
      end
    end
  end
end
