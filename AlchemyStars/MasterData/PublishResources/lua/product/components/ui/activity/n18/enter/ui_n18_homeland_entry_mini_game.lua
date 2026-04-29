_class("UIN18HomelandEntryMiniGame", Object)
UIN18HomelandEntryMiniGame = UIN18HomelandEntryMiniGame

function UIN18HomelandEntryMiniGame:Constructor(campaign)
  self._campaign = campaign
end

function UIN18HomelandEntryMiniGame:GetNew()
  return false
end

function UIN18HomelandEntryMiniGame:GetRedCount()
  local primaryCount, seniorCount = HomelandFindTreasureConst.GetSingleCount()
  return seniorCount
end

function UIN18HomelandEntryMiniGame:OpenUI()
  UIActivityHelper.PlayFirstPlot_Component(self._campaign, ECampaignN18ComponentID.ECAMPAIGN_N18_MINI_GAME, function()
    GameGlobal.UIStateManager():ShowDialog("UIFindTreasureDetail", false, ECampaignType.CAMPAIGN_TYPE_N18, ECampaignN18ComponentID.ECAMPAIGN_N18_MINI_GAME)
  end)
end
