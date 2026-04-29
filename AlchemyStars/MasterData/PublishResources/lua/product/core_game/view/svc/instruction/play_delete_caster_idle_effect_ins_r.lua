require("base_ins_r")
_class("PlayDeleteCasterIdleEffectInstruction", BaseInstruction)
PlayDeleteCasterIdleEffectInstruction = PlayDeleteCasterIdleEffectInstruction

function PlayDeleteCasterIdleEffectInstruction:Constructor(paramList)
end

function PlayDeleteCasterIdleEffectInstruction:DoInstruction(TT, casterEntity, phaseContext)
  self._world = casterEntity:GetOwnerWorld()
  if casterEntity:HasSuperEntity() then
    casterEntity = casterEntity:GetSuperEntity()
  end
  if casterEntity:HasEffectHolder() then
    local effectHolderCmpt = casterEntity:EffectHolder()
    local effectDictList = effectHolderCmpt:GetIdleEffect()
    self:DeleteEffect(effectDictList)
  end
end

function PlayDeleteCasterIdleEffectInstruction:DeleteEffect(effectList)
  for _, entityID in pairs(effectList) do
    local entity = self._world:GetEntityByID(entityID)
    if entity then
      self._world:DestroyEntity(entity)
    end
  end
end
