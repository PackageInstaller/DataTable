local UINStageRewardPreItem = class("UINStageRewardPreItem", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithReceived = require("Game.CommonUI.Item.UINBaseItemWithReceived")

function UINStageRewardPreItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.rewardItemPool = UIItemPool.New(UINBaseItemWithReceived, self.ui.uINBaseItemWithCount, false)
end

function UINStageRewardPreItem:InitStageRewardPreItem(rewardPreCfg, isPick)
  local needNum
  if rewardPreCfg.need_point then
    needNum = rewardPreCfg.need_point
  else
    needNum = rewardPreCfg.score
  end
  self.ui.tex_Point.text = tostring(needNum)
  self.rewardItemPool:HideAll()
  for k, itemId in ipairs(rewardPreCfg.rewardIds) do
    local itemNum = rewardPreCfg.rewardNums[k]
    local item = self.rewardItemPool:GetOne()
    local itemCfg = ConfigData.item[itemId]
    item:InitItemWithCount(itemCfg, itemNum, nil, isPick)
    item:SetNotNeedAnyJump(true)
  end
end

function UINStageRewardPreItem:GetStageRewardPreItemCurHolder()
  return self.ui.curHolder
end

function UINStageRewardPreItem:OnDelete()
  self.rewardItemPool:DeleteAll()
  base.OnDelete(self)
end

return UINStageRewardPreItem
