require("ui_get_item_controller_item")
require("ui_n33_lottery_get_item_ui_item")
_class("UIN33LotteryGetItemRowItem", UIGetItemControllerItem)
UIN33LotteryGetItemRowItem = UIN33LotteryGetItemRowItem

function UIN33LotteryGetItemRowItem:GetUIItem()
  local sop = self:GetUIComponent("UISelectObjectPath", "uiitem")
  self.uiItem = sop:SpawnObject("UIN33LotteryGetItemUIItem")
  self.uiItem:SetForm(UIItemForm.N33Lottery)
end

function UIN33LotteryGetItemRowItem:_DoClickCallback(go)
  self._clickCallback(self._templateData.award_type, self._item_id, self._itemCount)
end

function UIN33LotteryGetItemRowItem:_SetUIItemData(nameColor)
  self.uiItem:SetData({
    count = self._templateData.item_count,
    icon = self._templateData.icon,
    awardType = self._templateData.award_type
  })
end
