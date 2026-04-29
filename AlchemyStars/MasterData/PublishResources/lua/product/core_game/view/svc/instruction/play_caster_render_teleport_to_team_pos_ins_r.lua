require("base_ins_r")
_class("PlayCasterRenderTeleportToTeamPosInstruction", BaseInstruction)
PlayCasterRenderTeleportToTeamPosInstruction = PlayCasterRenderTeleportToTeamPosInstruction

function PlayCasterRenderTeleportToTeamPosInstruction:Constructor(paramList)
  self._dirType = tonumber(paramList.dirType) or DirectionType.Down
end

function PlayCasterRenderTeleportToTeamPosInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local teamEntity = world:Player():GetCurrentTeamEntity()
  local teamRenderGridPositionV2 = teamEntity:GetRenderGridPosition()
  local dirV2 = self:GetDirByDirType(self._dirType)
  casterEntity:SetLocation(teamRenderGridPositionV2, dirV2)
end

function PlayCasterRenderTeleportToTeamPosInstruction:GetDirByDirType(dirType)
  if dirType == DirectionType.Up then
    return Vector2(0, 1)
  elseif dirType == DirectionType.Down then
    return Vector2(0, -1)
  elseif dirType == DirectionType.Left then
    return Vector2(-1, 0)
  elseif dirType == DirectionType.Right then
    return Vector2(1, 0)
  end
end
