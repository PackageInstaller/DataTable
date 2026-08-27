local UINWCRankRewardPanelItem = class("UINWCRankRewardPanelItem", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")
UINWCRankRewardPanelItem.eType = {actuallyRank = 1, percentRank = 2}

function UINWCRankRewardPanelItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.itemPool = UIItemPool.New(UINBaseItemWithCount, self.ui.uINBaseItemWithCount)
  self.ui.uINBaseItemWithCount:SetActive(false)
end

function UINWCRankRewardPanelItem:InitRankRewardPanelItem(rankRewardCfg, lastScore, isLastRegion, resloader)
  if UINWCRankRewardPanelItem.eType.actuallyRank == rankRewardCfg.type then
    if lastScore == nil or lastScore == 0 then
      if rankRewardCfg.score == 1 then
        self.ui.tex_AwardNumber:SetIndex(0, tostring(rankRewardCfg.score))
      else
        self.ui.tex_AwardNumber:SetIndex(1, "1", tostring(rankRewardCfg.score))
      end
    else
      self.ui.tex_AwardNumber:SetIndex(1, tostring(lastScore + 1), tostring(rankRewardCfg.score))
    end
  elseif UINWCRankRewardPanelItem.eType.percentRank == rankRewardCfg.type then
    if isLastRegion then
      self.ui.tex_AwardNumber:SetIndex(3)
    else
      self.ui.tex_AwardNumber:SetIndex(2, tostring(FormatNum(rankRewardCfg.score / 10)))
    end
  end
  self.itemPool:HideAll()
  for index, itemId in ipairs(rankRewardCfg.rewardIds) do
    local itemCfg = ConfigData.item[itemId]
    if itemCfg == nil then
      error("can't read itemCfg with id " .. tostring(itemId))
    else
      local item = self.itemPool:GetOne()
      item:BindBaseItemResloader(resloader)
      item:InitItemWithCount(itemCfg, rankRewardCfg.rewardNums[index])
    end
  end
end

function UINWCRankRewardPanelItem:OnDelete()
  base.OnDelete(self)
end

return UINWCRankRewardPanelItem
