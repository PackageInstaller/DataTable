local base = UIBaseNode
local UINComRankRewardItem = class("UINComRankRewardItem", base)
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")

function UINComRankRewardItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.itemPool = UIItemPool.New(UINBaseItemWithCount, self.ui.uINBaseItemWithCount, false)
end

function UINComRankRewardItem:InitComRankRewardItem(rankRewardCfg, resloader)
  local percent = FormatNum(rankRewardCfg.percent / 1)
  self.ui.tex_AwardNumber:SetIndex(0, tostring(percent))
  self.itemPool:HideAll()
  for index, itemId in ipairs(rankRewardCfg.rewardIds) do
    local itemCfg = ConfigData.item[itemId]
    local item = self.itemPool:GetOne()
    item:BindBaseItemResloader(resloader)
    item:InitItemWithCount(itemCfg, rankRewardCfg.rewardNums[index])
  end
  self:ShowComRankRewardItemIsCur(false)
end

function UINComRankRewardItem:ShowComRankRewardItemIsCur(isShow)
  self.ui.img_CurrentRank:SetActive(isShow)
end

function UINComRankRewardItem:OnDelete()
  self.itemPool:DeleteAll()
  base.OnDelete(self)
end

return UINComRankRewardItem
