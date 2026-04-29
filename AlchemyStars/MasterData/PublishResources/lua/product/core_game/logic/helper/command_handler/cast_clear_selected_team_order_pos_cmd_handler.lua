require("command_base_handler")
_class("CastClearSelectedTeamOrderPositionCommandHandler", CommandBaseHandler)
CastClearSelectedTeamOrderPositionCommandHandler = CastClearSelectedTeamOrderPositionCommandHandler

function CastClearSelectedTeamOrderPositionCommandHandler:DoHandleCommand(cmd)
  local teamEntityID = cmd:GetEntityID()
  local casterPstID = cmd:GetCasterPstID()
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local cTeam = teamEntity:Team()
  local eCaster = cTeam:GetPetEntityByPetPstID(casterPstID)
  if not eCaster then
    Log.error("invalid pet pstid? ", tostring(casterPstID))
    return
  end
  cTeam:ClearSelectedTeamOrderPosition()
end
