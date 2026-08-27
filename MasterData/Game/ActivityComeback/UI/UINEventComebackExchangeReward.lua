local UINEventComebackExchangeReward = class("UINEventComebackExchangeReward", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")

function UINEventComebackExchangeReward:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self._item = UINBaseItemWithCount.New()
  self._item:Init(self.ui.uINBaseItemWithCount)
end

function UINEventComebackExchangeReward:InitExchangeReward(itemId, itemCount, remainTimes)
  local itemCfg = ConfigData.item[itemId]
  self._item:InitItemWithCount(itemCfg, itemCount)
  self.ui.tex_Count.text = tostring(remainTimes)
end

function UINEventComebackExchangeReward:SetExchangeRemainCount(remainTimes)
  self.ui.tex_Count.text = tostring(remainTimes)
end

return UINEventComebackExchangeReward
