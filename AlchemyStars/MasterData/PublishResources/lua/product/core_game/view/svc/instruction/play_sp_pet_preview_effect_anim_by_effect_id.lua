require("base_ins_r")
_class("PlaySPPetPreviewEffectAnimationByEffectIDInstruction", BaseInstruction)
PlaySPPetPreviewEffectAnimationByEffectIDInstruction = PlaySPPetPreviewEffectAnimationByEffectIDInstruction

function PlaySPPetPreviewEffectAnimationByEffectIDInstruction:Constructor(paramList)
  self._animName = paramList.anim
  self._petID = tonumber(paramList.petID)
  self._effectID = tonumber(paramList.effectID)
  self._skillID = tonumber(paramList.skillID)
end

function PlaySPPetPreviewEffectAnimationByEffectIDInstruction:DoInstruction(TT, casterEntity, phaseContext)
  self._world = casterEntity:GetOwnerWorld()
  local utilDataSvc = self._world:GetService("UtilData")
  local petEntity = utilDataSvc:GePetEntityByTemplateID(self._petID)
  if petEntity then
    local playEntity = petEntity
    local activeSkillPickUpComponent = playEntity:PreviewPickUpComponent()
    local effectIDList = activeSkillPickUpComponent:GetPickUpEffectEntityIDArrayByEffectID(self._effectID)
    for i, id in ipairs(effectIDList) do
      local effectEntity = self._world:GetEntityByID(id)
      local effectGO = effectEntity:View():GetGameObject()
      local anim = effectGO.gameObject:GetComponent("Animation")
      anim:Play(self._animName)
    end
  end
end
