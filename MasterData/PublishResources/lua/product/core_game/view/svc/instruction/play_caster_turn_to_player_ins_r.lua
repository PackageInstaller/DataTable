require("base_ins_r")
_class("PlayCasterTurnToPlayerInstruction", BaseInstruction)
PlayCasterTurnToPlayerInstruction = PlayCasterTurnToPlayerInstruction

function PlayCasterTurnToPlayerInstruction:Constructor(paramList)
  self._force = tonumber(paramList.force) or 0
end

function PlayCasterTurnToPlayerInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local teamEntity = world:Player():GetLocalTeamEntity()
  local teamLeaderEntity = teamEntity:GetTeamLeaderPetEntity()
  local resvc = world:GetService("RenderEntity")
  resvc:TurnToTarget(casterEntity, teamLeaderEntity, self._force)
end
