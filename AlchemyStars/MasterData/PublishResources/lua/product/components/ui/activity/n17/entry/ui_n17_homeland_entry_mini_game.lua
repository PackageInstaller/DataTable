_class("UIN17HomelandEntryMiniGame", Object)
UIN17HomelandEntryMiniGame = UIN17HomelandEntryMiniGame

function UIN17HomelandEntryMiniGame:Constructor(campaign)
  self._campaign = campaign
end

function UIN17HomelandEntryMiniGame:GetNew()
  return false
end

function UIN17HomelandEntryMiniGame:GetRedCount()
  local primaryCount, seniorCount = HomelandFindTreasureConst.GetSingleCount()
  return seniorCount
end

function UIN17HomelandEntryMiniGame:OpenUI()
  UIActivityHelper.PlayFirstPlot_Component(self._campaign, ECampaignN17ComponentID.ECAMPAIGN_N17_MINI_GAME, function()
    GameGlobal.UIStateManager():ShowDialog("UIFindTreasureDetail", true, ECampaignType.CAMPAIGN_TYPE_N17, ECampaignN17ComponentID.ECAMPAIGN_N17_MINI_GAME)
  end)
end
