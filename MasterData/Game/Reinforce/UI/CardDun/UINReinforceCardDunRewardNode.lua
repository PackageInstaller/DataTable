local base = UIBaseNode
local UINReinforceCardDunRewardNode = class("UINReinforceCardDunRewardNode", base)
local UINBaseItemWithReceived = require("Game.CommonUI.Item.UINBaseItemWithReceived")

function UINReinforceCardDunRewardNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self._itemPool = UIItemPool.New(UINBaseItemWithReceived, self.ui.UINBaseItemWithReceived, false)
end

function UINReinforceCardDunRewardNode:RefreshRewardNode(levelData)
  local itemIds, itemCounts = levelData:GetNoRankFirstClearReward()
  local isPicked = levelData:GetNoRankFirstClearRewardIsPicked()
  self._itemPool:HideAll()
  for index, itemId in ipairs(itemIds) do
    local itemCfg = ConfigData.item[itemId]
    local itemCount = itemCounts[index]
    local item = self._itemPool:GetOne()
    item:InitItemWithCount(itemCfg, itemCount, nil, isPicked)
  end
end

function UINReinforceCardDunRewardNode:OnDelete()
  base.OnDelete(self)
end

return UINReinforceCardDunRewardNode
