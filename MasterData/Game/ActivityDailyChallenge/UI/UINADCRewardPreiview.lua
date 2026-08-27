local UINADCRewardPreiview = class("UINADCRewardPreiview", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithReceived = require("Game.CommonUI.Item.UINBaseItemWithReceived")

function UINADCRewardPreiview:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.bgClose, self, self.Hide)
  self._itemPool = UIItemPool.New(UINBaseItemWithReceived, self.ui.uINBaseItemWithReceived)
  self.ui.uINBaseItemWithReceived:SetActive(false)
end

function UINADCRewardPreiview:InitADCAwardPreview(adcAwardCfg, isPicked)
  local itemIds = adcAwardCfg.itemIds
  local itemCounts = adcAwardCfg.itemCounts
  self._itemPool:HideAll()
  for index, itemId in ipairs(itemIds) do
    local itemCfg = ConfigData.item[itemId]
    local itemCount = itemCounts[index]
    local item = self._itemPool:GetOne()
    item:InitItemWithCount(itemCfg, itemCount, nil, isPicked)
  end
end

return UINADCRewardPreiview
