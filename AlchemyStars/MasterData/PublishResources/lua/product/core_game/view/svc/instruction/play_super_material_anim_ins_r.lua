require("base_ins_r")
_class("PlaySuperMaterialAnimInstruction", BaseInstruction)
PlaySuperMaterialAnimInstruction = PlaySuperMaterialAnimInstruction

function PlaySuperMaterialAnimInstruction:Constructor(paramList)
  self._animName = paramList.animName
end

function PlaySuperMaterialAnimInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local e = casterEntity
  if e:HasSuperEntity() and casterEntity:EntityType():IsSkillHolder() then
    local cSuperEntity = casterEntity:SuperEntityComponent()
    e = cSuperEntity:GetSuperEntity()
  end
  if not e:HasMaterialAnimationComponent() then
    Log.error(self._className, "entity has no MaterialAnimationComponent. ")
  end
  e:PlayMaterialAnim(self._animName)
end
