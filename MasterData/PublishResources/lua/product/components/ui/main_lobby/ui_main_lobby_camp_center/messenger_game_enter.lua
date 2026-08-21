require("main_lobby_center_camp_data")
_class("MessengerGameEnter", MainLobbyCenterCampData)
MessengerGameEnter = MessengerGameEnter

function MessengerGameEnter:LoadData(TT)
  local res = AsyncRequestRes:New()
  res:SetSucc(true)
  self.N27MinigameHelper = N27MinigameHelper:New()
  self.N27MinigameHelper:LoadData(TT, res)
  self._campaign = self.N27MinigameHelper:GetCampaign()
end

function MessengerGameEnter:CheckNew()
  return self.N27MinigameHelper:IsShowMiniGameNew() and 1 or 0
end
