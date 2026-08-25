local PVPRankRewardGroupItem, Super = System.NewComponent("PVPRankRewardGroupItem")

function PVPRankRewardGroupItem:ctor(obj, rewardGroup, onClickReward)
  Super.ctor(self)
  self.ui = UI_Pvp_Item_RewardResource(obj)
  self.rewardGroup = rewardGroup
  self.onClickReward = onClickReward
end

function PVPRankRewardGroupItem:OnBind(binder)
  binder:BindComponent(PVPRankRewardItem(self.ui.UI_Pvp_Item_Dan_1, self.rewardGroup[1], self.onClickReward))
  binder:BindComponent(PVPRankRewardItem(self.ui.UI_Pvp_Item_Dan_2, self.rewardGroup[2], self.onClickReward))
  binder:BindComponent(PVPRankRewardItem(self.ui.UI_Pvp_Item_Dan_3, self.rewardGroup[3], self.onClickReward))
end

return PVPRankRewardGroupItem
