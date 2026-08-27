local UINActivityDivergentRewardStepItem = class("UINActivityDivergentRewardStepItem", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithReceived = require("Game.CommonUI.Item.UINBaseItemWithReceived")

function UINActivityDivergentRewardStepItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self._rewardItem = UINBaseItemWithReceived.New()
  self._rewardItem:Init(self.ui.uINBaseItemWithReceived)
end

function UINActivityDivergentRewardStepItem:InitDivergentRewardItem(divergentData, rewardData, heroId)
  self._divergentData = divergentData
  self._rewardData = rewardData
  self._heroId = heroId
  local isPicked = self:__IsDivergentRewardPicked()
  self.ui.tex_ScoreNum.text = tostring(rewardData.reward_experience)
  self.ui.img_Count.color = isPicked and self.ui.color_Complete or self.ui.color_UnComplete
  self.ui.img_Icon.color = isPicked and self.ui.color_TextComplete or self.ui.color_TextUnComplete
  self.ui.tex_ScoreNum.color = isPicked and self.ui.color_TextComplete or self.ui.color_TextUnComplete
  local rewardId, rewardNum
  for kRewardId, vRewardNum in pairs(rewardData.reward) do
    rewardId = kRewardId
    rewardNum = vRewardNum
    break
  end
  local itemCfg = ConfigData.item[rewardId]
  self._rewardItem:InitItemWithCount(itemCfg, rewardNum, nil, isPicked)
end

function UINActivityDivergentRewardStepItem:__IsDivergentRewardPicked()
  local progressData = self._divergentData:GetDivergentHeroData(self._heroId)
  if progressData.rewardStage > self._rewardData.reward_stage or progressData.rewardStage == self._rewardData.reward_stage and progressData.rewardExp >= self._rewardData.reward_experience then
    return true
  end
  return false
end

return UINActivityDivergentRewardStepItem
