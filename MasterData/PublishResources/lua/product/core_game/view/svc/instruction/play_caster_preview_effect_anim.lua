require("base_ins_r")
_class("PlayCasterPreviewEffectAnimationInstruction", BaseInstruction)
PlayCasterPreviewEffectAnimationInstruction = PlayCasterPreviewEffectAnimationInstruction

function PlayCasterPreviewEffectAnimationInstruction:Constructor(paramList)
  self._animName = paramList.anim
end

function PlayCasterPreviewEffectAnimationInstruction:DoInstruction(TT, casterEntity, phaseContext)
  self._world = casterEntity:GetOwnerWorld()
  local activeSkillPickUpComponent = casterEntity:ActiveSkillPickUpComponent()
  local effectIDList = activeSkillPickUpComponent:GetPickUpEffectEntityIDArray()
  for i, id in ipairs(effectIDList) do
    local effectEntity = self._world:GetEntityByID(id)
    local effectGO = effectEntity:View():GetGameObject()
    local anim = effectGO.gameObject:GetComponent("Animation")
    anim:Play(self._animName)
  end
end
