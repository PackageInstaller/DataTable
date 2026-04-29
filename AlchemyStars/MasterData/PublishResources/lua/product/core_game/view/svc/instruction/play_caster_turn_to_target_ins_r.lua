require("base_ins_r")
_class("PlayCasterTurnToTargetInstruction", BaseInstruction)
PlayCasterTurnToTargetInstruction = PlayCasterTurnToTargetInstruction

function PlayCasterTurnToTargetInstruction:Constructor(paramList)
  self._force = tonumber(paramList.force)
end

function PlayCasterTurnToTargetInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local targetEntityID = phaseContext:GetCurTargetEntityID()
  local world = casterEntity:GetOwnerWorld()
  local targetEntity = world:GetEntityByID(targetEntityID)
  local resvc = world:GetService("RenderEntity")
  resvc:TurnToTarget(casterEntity, targetEntity, self._force)
end
