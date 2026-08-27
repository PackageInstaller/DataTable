local UINActivityDivergentRewardStepItem = require("Game.ActivityDivergent.UI.Reward.UINActivityDivergentRewardStepItem")
local UINActivityDivergentRewardItem = class("UINActivityDivergentRewardItem", UINActivityDivergentRewardStepItem)
local base = UINActivityDivergentRewardStepItem

function UINActivityDivergentRewardItem:InitDivergentRewardItem(divergentData, rewardData, heroId)
  base.InitDivergentRewardItem(self, divergentData, rewardData, heroId)
  local hasRightBar = true
  local rewardCfg = divergentData:GetDivergentHeroRewardGroupCfg(heroId)[rewardData.reward_stage]
  if rewardCfg[rewardData.reward_rank + 1] == nil then
    hasRightBar = false
  end
  self.ui.obj_RightBar:SetActive(hasRightBar)
  local isPicked = self:__IsDivergentRewardPicked()
  self.ui.img_Arrow.color = isPicked and self.ui.color_Complete or self.ui.color_UnComplete
  local fillAmountLeft, fillAmountRight = self:__GetDivergentFillAmount(hasRightBar)
  self.ui.img_FillLeft.fillAmount = fillAmountLeft
  self.ui.img_FillRight.fillAmount = fillAmountRight
end

function UINActivityDivergentRewardItem:__GetDivergentFillAmount(hasRightBar)
  local progressData = self._divergentData:GetDivergentHeroData(self._heroId)
  if progressData.rewardStage > self._rewardData.reward_stage then
    return 1, 1
  end
  local leftEdge, rightEdge = self:__GetDivergentProgressBarEdge()
  local midEdge = self._rewardData.reward_experience
  local fillAmountLeft = (progressData.rewardExp - leftEdge) / (midEdge - leftEdge)
  local fillAmountRight = hasRightBar and (progressData.rewardExp - midEdge) / (rightEdge - midEdge) or 0
  return fillAmountLeft, fillAmountRight
end

function UINActivityDivergentRewardItem:__GetDivergentProgressBarEdge()
  local rewardCfg = self._divergentData:GetDivergentHeroRewardGroupCfg(self._heroId)[self._rewardData.reward_stage]
  local leftEdge = 0
  local prefRankCfg = rewardCfg[self._rewardData.reward_rank - 1]
  if prefRankCfg ~= nil then
    leftEdge = (prefRankCfg.reward_experience + self._rewardData.reward_experience) * 0.5
  end
  local rightEdge = self._rewardData.reward_experience
  local nextRankCfg = rewardCfg[self._rewardData.reward_rank + 1]
  if nextRankCfg ~= nil then
    rightEdge = (nextRankCfg.reward_experience + self._rewardData.reward_experience) * 0.5
  end
  return leftEdge, rightEdge
end

return UINActivityDivergentRewardItem
