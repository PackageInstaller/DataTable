require("base_ins_r")
_class("PlayCasterAnimationCleanTriggerInstruction", BaseInstruction)
PlayCasterAnimationCleanTriggerInstruction = PlayCasterAnimationCleanTriggerInstruction

function PlayCasterAnimationCleanTriggerInstruction:Constructor(paramList)
  self._animName = paramList.animName
end

function PlayCasterAnimationCleanTriggerInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local e = casterEntity
  if casterEntity:HasSuperEntity() and casterEntity:EntityType():IsSkillHolder() then
    local cSuperEntity = casterEntity:SuperEntityComponent()
    e = cSuperEntity:GetSuperEntity()
  end
  local csgo = casterEntity:View().ViewWrapper.GameObject
  local csTransformRoot = csgo.transform:Find("Root")
  if not csTransformRoot then
    return
  end
  local csAnimator = csTransformRoot:GetComponent("Animator")
  if csAnimator then
    csAnimator:ResetTrigger(self._animName)
  end
end
