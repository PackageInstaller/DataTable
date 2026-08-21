_class("BuffViewSetMoveWithTeam", BuffViewBase)
BuffViewSetMoveWithTeam = BuffViewSetMoveWithTeam

function BuffViewSetMoveWithTeam:PlayView(TT)
  local entity = self._entity
  local bSet = self._buffResult:IsSet()
  if bSet then
    local teamEntity = self._buffResult:GetTargetTeamEntity()
    entity:AddRenderSyncMoveWithTeam(teamEntity)
  else
    entity:RemoveRenderSyncMoveWithTeam()
  end
end
