_class("UITeamsLeader", UICustomWidget)
UITeamsLeader = UITeamsLeader

function UITeamsLeader:OnShow()
  self._slot = self:GetGameObject("slot")
  self._slot:SetActive(false)
  self._slotOpen = false
  self._btnLeaderGO = self:GetGameObject("btnTeamLeader")
end

function UITeamsLeader:Flush(leader, isGuide)
  if isGuide then
    self._leader = isGuide
    self._btnLeaderGO:SetActive(isGuide)
  else
    local petModule = self:GetModule(PetModule)
    self._leader = petModule:GetPet(leader)
    self._btnLeaderGO:SetActive(self._leader ~= nil)
  end
end

function UITeamsLeader:BtnTeamLeaderOnClick(go)
  if self._leader then
    self._slotOpen = not self._slotOpen
    self._slot:SetActive(self._slotOpen)
  else
    self._slot:SetActive(false)
  end
end
