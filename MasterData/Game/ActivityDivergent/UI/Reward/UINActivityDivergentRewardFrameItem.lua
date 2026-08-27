local UINActivityDivergentRewardStepItem = require("Game.ActivityDivergent.UI.Reward.UINActivityDivergentRewardStepItem")
local UINActivityDivergentRewardFrameItem = class("UINActivityDivergentRewardFrameItem", UINActivityDivergentRewardStepItem)
local base = UINActivityDivergentRewardStepItem

function UINActivityDivergentRewardFrameItem:InitDivergentRewardItem(divergentData, rewardData, heroId)
  base.InitDivergentRewardItem(self, divergentData, rewardData, heroId)
  local levelCfg = self._divergentData:GetDivergentHeroRewardGroupCfg(heroId)[1]
  self.ui.obj_Sp:SetActive(rewardData.reward_rank == #levelCfg)
end

return UINActivityDivergentRewardFrameItem
