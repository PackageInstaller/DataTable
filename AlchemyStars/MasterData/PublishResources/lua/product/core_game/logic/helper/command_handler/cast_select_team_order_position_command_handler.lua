require("command_base_handler")
_class("CastSelectTeamOrderPositionCommandHandler", CommandBaseHandler)
CastSelectTeamOrderPositionCommandHandler = CastSelectTeamOrderPositionCommandHandler

function CastSelectTeamOrderPositionCommandHandler:DoHandleCommand(cmd)
  local teamEntityID = cmd:GetEntityID()
  local casterPstID = cmd:GetCasterPstID()
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local cTeam = teamEntity:Team()
  local eCaster = cTeam:GetPetEntityByPetPstID(casterPstID)
  if not eCaster then
    Log.error("invalid pet pstid? ", tostring(casterPstID))
    return
  end
  cTeam:SetSelectedTeamOrderPosition(cmd:GetTargetPos())
end
