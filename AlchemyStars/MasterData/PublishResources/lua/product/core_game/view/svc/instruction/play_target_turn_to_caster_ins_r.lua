require("base_ins_r")
_class("PlayTargetTurnToCasterInstruction", BaseInstruction)
PlayTargetTurnToCasterInstruction = PlayTargetTurnToCasterInstruction

function PlayTargetTurnToCasterInstruction:Constructor(paramList)
end

function PlayTargetTurnToCasterInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local targetEntityID = phaseContext:GetCurTargetEntityID()
  local world = casterEntity:GetOwnerWorld()
  local targetEntity = world:GetEntityByID(targetEntityID)
  local resvc = world:GetService("RenderEntity")
  resvc:TurnToTarget(targetEntity, casterEntity)
end
