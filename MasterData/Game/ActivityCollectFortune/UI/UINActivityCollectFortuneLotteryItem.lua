local UINActivityCollectFortuneLotteryItem = class("UINActivityCollectFortuneLotteryItem", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithReceived = require("Game.CommonUI.Item.UINBaseItemWithReceived")

function UINActivityCollectFortuneLotteryItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.baseItem = UINBaseItemWithReceived.New()
  self.baseItem:Init(self.ui.UINBaseItemWithReceived)
end

function UINActivityCollectFortuneLotteryItem:InitCollectFortuneLotteryItem(itemId, itemNum, lotteryCount, getCount)
  local itemCfg = ConfigData.item[itemId]
  if itemCfg == nil then
    error("cant find itemCfg!! id:" .. tostring(itemId))
    return
  end
  local isPicked = lotteryCount < 999 and lotteryCount <= getCount
  self.baseItem:InitItemWithCount(itemCfg, itemNum, nil, isPicked)
  self.ui.TexBg:SetActive(lotteryCount < 999)
  if lotteryCount < 999 then
    self.ui.Tex_Num.text = tostring(getCount) .. "/" .. tostring(lotteryCount)
  end
end

function UINActivityCollectFortuneLotteryItem:OnDelete()
  base.OnDelete(self)
end

return UINActivityCollectFortuneLotteryItem
