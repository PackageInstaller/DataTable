require("mirage_role_turn_system")
_class("ClientMirageRoleTurnSystem_Render", MirageRoleTurnSystem)
ClientMirageRoleTurnSystem_Render = ClientMirageRoleTurnSystem_Render

function ClientMirageRoleTurnSystem_Render:_DoRenderMirageMove(TT)
  local mirageSvcRender = self._world:GetService("MirageRender")
  mirageSvcRender:DoMiragePlayTeamMove(TT)
end
