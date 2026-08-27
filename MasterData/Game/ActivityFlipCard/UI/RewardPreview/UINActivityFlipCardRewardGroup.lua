local UINActivityFlipCardRewardGroup = class("UINActivityFlipCardRewardGroup", UIBaseNode)
local base = UIBaseNode
local UINActivityFlipCardRewardItem = require("Game.ActivityFlipCard.UI.RewardPreview.UINActivityFlipCardRewardItem")

function UINActivityFlipCardRewardGroup:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self._rewardItemPool = UIItemPool.New(UINActivityFlipCardRewardItem, self.ui.rewardNode, false)
end

function UINActivityFlipCardRewardGroup:InitFlipRewardGroup(titleIndex, rewardIds, rewardNums, rewardGroupNums)
  self.ui.Tex_Title:SetIndex(titleIndex)
  self._rewardItemPool:HideAll()
  for index, rewardId in ipairs(rewardIds) do
    local rewardNum = rewardNums[index]
    local rewardItem = self._rewardItemPool:GetOne()
    local rewardGroupNum = rewardGroupNums[index]
    rewardItem:InitFlipRewardItem(rewardId, rewardNum, rewardGroupNum)
  end
end

return UINActivityFlipCardRewardGroup
