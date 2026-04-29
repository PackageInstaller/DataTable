require("ui_side_enter_item_campaign")
_class("UISideEnterItem_MessengerGame", UISideEnterItem_Campaign)
UISideEnterItem_MessengerGame = UISideEnterItem_MessengerGame

function UISideEnterItem_MessengerGame:_LoadCampaign(TT)
  local res = AsyncRequestRes:New()
  res:SetSucc(true)
  self.N27MinigameHelper = N27MinigameHelper:New()
  self.N27MinigameHelper:LoadData(TT, res)
  self._campaign = self.N27MinigameHelper:GetCampaign()
end

function UISideEnterItem_MessengerGame:_CalcNew()
  return self.N27MinigameHelper:IsShowMiniGameNew()
end
