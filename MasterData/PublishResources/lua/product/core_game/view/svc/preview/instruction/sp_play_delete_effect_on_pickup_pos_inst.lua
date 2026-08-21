require("sp_base_inst")
_class("SkillPreviewPlayDeleteEffectOnPickUpPosInstruction", SkillPreviewBaseInstruction)
SkillPreviewPlayDeleteEffectOnPickUpPosInstruction = SkillPreviewPlayDeleteEffectOnPickUpPosInstruction

function SkillPreviewPlayDeleteEffectOnPickUpPosInstruction:Constructor(params)
  self._effectID = tonumber(params.effectID)
  assert(Cfg.cfg_effect[self._effectID], "预览指令PlayEffectOnPickupPos需要有效的effectID")
  self._ignorePos = tonumber(params.ignorePos) == 1
end

function SkillPreviewPlayDeleteEffectOnPickUpPosInstruction:GetCacheResource()
  return {
    {
      Cfg.cfg_effect[self._effectID].ResPath,
      1
    }
  }
end

function SkillPreviewPlayDeleteEffectOnPickUpPosInstruction:DoInstruction(TT, casterEntity, previewContext)
  local world = casterEntity:GetOwnerWorld()
  local previewPickUpComponent = casterEntity:PreviewPickUpComponent()
  if not previewPickUpComponent then
    return
  end
  local entityIDs = previewPickUpComponent:GetPickUpEffectEntityIDArray()
  for _, entityID in pairs(entityIDs) do
    if entityID then
      local entity = world:GetEntityByID(entityID)
      if entity then
        local entityPos = entity:GetRenderGridPosition()
        if entityPos == previewContext:GetPickUpPos() or self._ignorePos then
          world:DestroyEntity(entity)
        end
      end
    end
  end
end
