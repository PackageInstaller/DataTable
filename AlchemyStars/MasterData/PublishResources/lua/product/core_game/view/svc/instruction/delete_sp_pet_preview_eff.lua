require("base_ins_r")
_class("DeleteSPPetPreviewEffectAnimationInstruction", BaseInstruction)
DeleteSPPetPreviewEffectAnimationInstruction = DeleteSPPetPreviewEffectAnimationInstruction

function DeleteSPPetPreviewEffectAnimationInstruction:Constructor(paramList)
  self._petID = tonumber(paramList.petID)
  self._skillID = tonumber(paramList.skillID)
end

function DeleteSPPetPreviewEffectAnimationInstruction:DoInstruction(TT, casterEntity, phaseContext)
  self._world = casterEntity:GetOwnerWorld()
  local utilDataSvc = self._world:GetService("UtilData")
  local petEntity = utilDataSvc:GePetEntityByTemplateID(self._petID)
  if petEntity then
    local playEntity = petEntity
    local activeSkillPickUpComponent = playEntity:ActiveSkillPickUpComponent()
    local effectIDList = activeSkillPickUpComponent:GetPickUpEffectEntityIDArray()
    for i, id in ipairs(effectIDList) do
      local effectEntity = self._world:GetEntityByID(id)
      if effectEntity then
        self._world:DestroyEntity(effectEntity)
      end
    end
    activeSkillPickUpComponent:ClearPickUpEffectEntityIDArray()
  end
end
