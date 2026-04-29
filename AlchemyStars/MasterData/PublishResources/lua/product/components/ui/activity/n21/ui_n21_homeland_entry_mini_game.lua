_class("UIN21HomelandEntryMiniGame", Object)
UIN21HomelandEntryMiniGame = UIN21HomelandEntryMiniGame

function UIN21HomelandEntryMiniGame:Constructor(campaign)
  self._campaign = campaign
end

function UIN21HomelandEntryMiniGame:GetNew()
  return false
end

function UIN21HomelandEntryMiniGame:GetRedCount()
  local primaryCount, seniorCount = HomelandFindTreasureConst.GetSingleCount()
  return seniorCount
end

function UIN21HomelandEntryMiniGame:OpenUI()
  UIActivityHelper.PlayFirstPlot_Component(self._campaign, ECampaignN21ComponentID.ECAMPAIGN_N21_MINI_GAME, function()
    GameGlobal.UIStateManager():ShowDialog("UIFindTreasureDetail", false, ECampaignType.CAMPAIGN_TYPE_N21, ECampaignN21ComponentID.ECAMPAIGN_N21_MINI_GAME)
  end)
end
