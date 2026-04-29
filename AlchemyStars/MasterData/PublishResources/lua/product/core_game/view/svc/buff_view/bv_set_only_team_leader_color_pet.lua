_class("BuffViewSetOnlyTeamLeaderColorPet", BuffViewBase)
BuffViewSetOnlyTeamLeaderColorPet = BuffViewSetOnlyTeamLeaderColorPet

function BuffViewSetOnlyTeamLeaderColorPet:PlayView(TT)
  local result = self._buffResult
  local val = result:GetVal()
  self._entity:BuffView():SetBuffValue("OnlyTeamLeaderColorPet", val)
end
