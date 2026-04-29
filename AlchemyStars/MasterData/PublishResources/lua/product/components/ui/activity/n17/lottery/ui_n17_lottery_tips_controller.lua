_class("UIN17LotteryTipsController", UIController)
UIN17LotteryTipsController = UIN17LotteryTipsController

function UIN17LotteryTipsController:Constructor()
end

function UIN17LotteryTipsController:OnShow(uiParams)
  local data = uiParams[1]
  if not data then
    return
  end
  self:_SetItem(data)
  local itemId = data:GetItemId()
  UIWidgetHelper.SetItemText(self, itemId, "Name", "Descripution")
  UIWidgetHelper.SetItemCount(self, itemId, "OwnCount", function(count)
    local c = HelperProxy:GetInstance():FormatItemCount(count)
    return StringTable.Get("str_item_public_owned") .. c
  end)
end

function UIN17LotteryTipsController:_SetItem(data)
  local obj = UIWidgetHelper.SpawnObject(self, "Item", "UIN17LotteryAwardCell")
  obj:InitData(data, nil, false, 0)
end

function UIN17LotteryTipsController:CloseBtnOnClick()
  self:CloseDialog()
end
