require("base_ins_r")
_class("DeleteCasterPreviewEffectAnimationInstruction", BaseInstruction)
DeleteCasterPreviewEffectAnimationInstruction = DeleteCasterPreviewEffectAnimationInstruction

function DeleteCasterPreviewEffectAnimationInstruction:Constructor(paramList)
  self._animName = paramList.anim
end

function DeleteCasterPreviewEffectAnimationInstruction:DoInstruction(TT, casterEntity, phaseContext)
  self._world = casterEntity:GetOwnerWorld()
  local activeSkillPickUpComponent = casterEntity:ActiveSkillPickUpComponent()
  local effectIDList = activeSkillPickUpComponent:GetPickUpEffectEntityIDArray()
  for i, id in ipairs(effectIDList) do
    local effectEntity = self._world:GetEntityByID(id)
    if effectEntity then
      self._world:DestroyEntity(effectEntity)
    end
  end
  activeSkillPickUpComponent:ClearPickUpEffectEntityIDArray()
end
