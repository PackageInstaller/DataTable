require("base_ins_r")
_class("PlayCasterTurnToTargetGridInstruction", BaseInstruction)
PlayCasterTurnToTargetGridInstruction = PlayCasterTurnToTargetGridInstruction

function PlayCasterTurnToTargetGridInstruction:Constructor(paramList)
  local x = tonumber(paramList.dirOffsetX)
  local y = tonumber(paramList.dirOffsetY)
  if x and y then
    self._dirOffset = Vector2(x, y)
  end
end

function PlayCasterTurnToTargetGridInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local targetEntityID = phaseContext:GetCurTargetEntityID()
  local world = casterEntity:GetOwnerWorld()
  local targetEntity = world:GetEntityByID(targetEntityID)
  local resvc = world:GetService("RenderEntity")
  resvc:TurnToTargetGrid(casterEntity, targetEntity, self._dirOffset)
end
