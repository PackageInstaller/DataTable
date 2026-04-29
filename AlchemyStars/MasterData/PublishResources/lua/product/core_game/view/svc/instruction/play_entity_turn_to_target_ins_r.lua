require("base_ins_r")
_class("PlayEntityTurnToTargetInstruction", BaseInstruction)
PlayEntityTurnToTargetInstruction = PlayEntityTurnToTargetInstruction

function PlayEntityTurnToTargetInstruction:Constructor(paramList)
  self._force = tonumber(paramList.force)
  self._petTemplateID = tonumber(paramList.petTemplateID) or 0
end

function PlayEntityTurnToTargetInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local targetEntityID = phaseContext:GetCurTargetEntityID()
  local world = casterEntity:GetOwnerWorld()
  local targetEntity = world:GetEntityByID(targetEntityID)
  if not targetEntity then
    return
  end
  if self._petTemplateID and self._petTemplateID > 0 then
    local petGroup = world:GetGroup(world.BW_WEMatchers.PetPstID)
    for _, e in ipairs(petGroup:GetEntities()) do
      local cPetPstID = e:PetPstID()
      local petTemplateID = cPetPstID:GetTemplateID()
      if self._petTemplateID == petTemplateID then
        casterEntity = e
        break
      end
    end
  end
  local resvc = world:GetService("RenderEntity")
  resvc:TurnToTarget(casterEntity, targetEntity, self._force)
end
