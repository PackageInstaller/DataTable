require("sp_base_inst")
_class("SkillPreviewPlayEffectAnimByEffectIDInstruction", SkillPreviewBaseInstruction)
SkillPreviewPlayEffectAnimByEffectIDInstruction = SkillPreviewPlayEffectAnimByEffectIDInstruction

function SkillPreviewPlayEffectAnimByEffectIDInstruction:Constructor(params)
  self._effectID = tonumber(params.effectID)
  self._anim = params.anim
end

function SkillPreviewPlayEffectAnimByEffectIDInstruction:DoInstruction(TT, casterEntity, previewContext)
  local previewActiveSkillService = previewContext:GetWorld():GetService("PreviewActiveSkill")
  local world = casterEntity:GetOwnerWorld()
  local previewPickUpComponent = casterEntity:PreviewPickUpComponent()
  if not previewPickUpComponent then
    return
  end
  local entityIDs = previewPickUpComponent:GetPickUpEffectEntityIDArrayByEffectID(self._effectID)
  local world = casterEntity:GetOwnerWorld()
  for _, id in ipairs(entityIDs) do
    local e = world:GetEntityByID(id)
    if e then
      self:_PlayAnimation(e)
    end
  end
end

function SkillPreviewPlayEffectAnimByEffectIDInstruction:_PlayAnimation(entity)
  if not entity:HasView() then
    return
  end
  local go = entity:View():GetGameObject()
  local anim = go:GetComponentInChildren(typeof(UnityEngine.Animation))
  if anim == nil then
    Log.fatal("Cant play legacy animation, animation not found in ", go.name)
    return
  end
  anim:Play(self._anim)
end
