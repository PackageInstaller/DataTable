require("base_ins_r")
_class("PlayCasterTurnToTargetNormalInstruction", BaseInstruction)
PlayCasterTurnToTargetNormalInstruction = PlayCasterTurnToTargetNormalInstruction

function PlayCasterTurnToTargetNormalInstruction:Constructor(paramList)
  self._stageIndex = tonumber(paramList.stageIndex) or 1
end

function PlayCasterTurnToTargetNormalInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local targetEntityID = phaseContext:GetCurTargetEntityID()
  local world = casterEntity:GetOwnerWorld()
  local targetEntity = world:GetEntityByID(targetEntityID)
  if not targetEntity then
    return
  end
  local dir = targetEntity:Location().Position - casterEntity:Location().Position
  if math.abs(dir.x) > math.abs(dir.z) then
    dir.z = 0
  else
    dir.x = 0
  end
  local gridDir = Vector2(dir.x, dir.z)
  casterEntity:SetDirection(dir)
end
