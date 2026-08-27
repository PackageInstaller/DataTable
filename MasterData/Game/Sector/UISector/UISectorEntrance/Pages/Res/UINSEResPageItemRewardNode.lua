local base = UIBaseNode
local UINSEResPageItemRewardNode = class("UINSEResPageItemRewardNode", UIBaseNode)
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")

function UINSEResPageItemRewardNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.itemPool = UIItemPool.New(UINBaseItemWithCount, self.ui.uINBaseItemWithCount)
  self.ui.uINBaseItemWithCount:SetActive(false)
end

function UINSEResPageItemRewardNode:RefreshSERPIRewardNode(rewardProgress)
  local currentStage = rewardProgress.currentStage
  local totalStage = rewardProgress.totalStage
  local isReceiveAll = rewardProgress.isReceiveAll
  local curStageFullPointNum = rewardProgress.curStageFullPointNum
  local rewardItemList = rewardProgress.rewardItemList
  if currentStage == totalStage then
    self.ui.tex_RewardPoint:SetIndex(1)
  else
    self.ui.tex_RewardPoint:SetIndex(0, tostring(curStageFullPointNum))
  end
  self.ui.tex_RewardStage.text = tostring(currentStage) .. "/" .. tostring(totalStage)
  self.ui.obj_RewardReceivedAll:SetActive(isReceiveAll)
  self.itemPool:HideAll()
  for _, itemData in ipairs(rewardItemList) do
    local itemId = itemData.itemId
    local itemCount = itemData.itemNum
    local itemCfg = ConfigData.item[itemId]
    local item = self.itemPool:GetOne()
    item:InitItemWithCount(itemCfg, itemCount)
  end
  self.ui.emptyReward:SetActive(#rewardItemList <= 1)
  self.ui.obj_Anime:SetActive(not isReceiveAll)
end

function UINSEResPageItemRewardNode:OnDelete()
  base.OnDelete(self)
end

return UINSEResPageItemRewardNode
