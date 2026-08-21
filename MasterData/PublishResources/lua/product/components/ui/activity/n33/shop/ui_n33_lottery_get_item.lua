require("ui_get_item_controller")
require("ui_n33_lottery_get_item_row_item")
_class("UIN33LotteryGetItem", UIGetItemController)
UIN33LotteryGetItem = UIN33LotteryGetItem

function UIN33LotteryGetItem:_SpawnGetItemControllerItem(rowPool, count)
  rowPool:SpawnObjects("UIN33LotteryGetItemRowItem", count)
end

function UIN33LotteryGetItem:_GetItemCallBack()
  local function callback(type, id, count)
    self:OnItemSelect(type, id, count)
  end
  
  return callback
end

function UIN33LotteryGetItem:OnItemSelect(type, id, count)
  if not self._selectInfo then
    self._selectInfo = self.selectInfoPool:SpawnObject("UIN33ShopSelectInfo")
  end
  local data = {}
  data.m_reward_type = type
  data.m_item_id = id
  data.m_lottery_count = count
  self._selectInfo:SetData(data, nil, true, 0, true)
end
