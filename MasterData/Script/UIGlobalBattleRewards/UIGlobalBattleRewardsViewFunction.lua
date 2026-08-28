local View = require("UIGlobalBattleRewards/UIGlobalBattleRewardsView")
local DataModel = require("UIGlobalBattleRewards/UIGlobalBattleRewardsDataModel")
local Controller = require("UIGlobalBattleRewards/UIGlobalBattleRewardsController")
local ViewFunction = {
  GlobalBattleRewards_Btn_Return_Click = function(btn, str)
    UIManager:GoBack()
  end,
  GlobalBattleRewards_Group_RewardList_ScrollGrid_RewardList_SetGrid = function(element, elementIndex)
    Controller:RefreshRewardElement(element, elementIndex)
  end,
  GlobalBattleRewards_Group_RewardList_ScrollGrid_RewardList_Group_Item_Group_Item_Btn_Reward_Click = function(btn, str)
    Controller:ReqGetAllReward()
  end,
  GlobalBattleRewards_Group_RewardList_ScrollGrid_RewardList_Group_Item_Group_Item_Btn_View_Click = function(btn, str)
    print_r(str)
    local itemId = tonumber(str)
    CommonTips.OpenPreRewardDetailTips(itemId)
  end
}
return ViewFunction
