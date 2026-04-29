require("ui_side_enter_item_campaign")
_class("UISideEnterItemMiniGame", UISideEnterItem_Campaign)
UISideEnterItemMiniGame = UISideEnterItemMiniGame

function UISideEnterItemMiniGame:_CalcRed()
  Log.debug("[UISideEnterItemMiniGame ]00000 :")
  self.showRed = 0
  GameGlobal.TaskManager():StartTask(function(TT)
    local res = UIStateSwitchReq:New()
    res:SetSucc(true)
    local campaign = UIActivityCampaign.New()
    campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_N28_MINI_GAME, ECampaignN28MiniGameComponentID.ECAMPAIGN_BOUNCE_MISSION)
    self._localProcess = campaign:GetLocalProcess()
    self._missionComponent = self._localProcess:GetComponent(ECampaignN28MiniGameComponentID.ECAMPAIGN_BOUNCE_MISSION)
    self.showRed = self._missionComponent:MissionCanRecvReward()
  end)
  Log.debug("[UISideEnterItemMiniGame ]showRed :" .. tostring(self.showRed))
  return self.showRed and 1 or 0
end
