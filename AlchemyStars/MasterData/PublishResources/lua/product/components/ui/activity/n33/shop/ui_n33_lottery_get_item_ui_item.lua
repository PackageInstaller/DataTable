require("ui_item")
require("ui_item_node")
require("ui_n33_item_normal_node")
_class("UIN33LotteryGetItemUIItem", UIItem)
UIN33LotteryGetItemUIItem = UIN33LotteryGetItemUIItem

function UIN33LotteryGetItemUIItem:_InitNodes()
  self._nodes = {}
  self._nodes[UIItemNode.N33Lottery] = UIN33ItemNormalNode:New(self:GetUIComponent("UIView", "g_n33_normal"), self)
end
