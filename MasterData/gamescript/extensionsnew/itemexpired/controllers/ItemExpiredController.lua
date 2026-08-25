local ItemExpiredController = NewClass("ItemExpiredController", BaseController)

function ItemExpiredController:OnInit()
end

function ItemExpiredController:OnReset()
end

function ItemExpiredController:OnOpenItemExpiredView(itemList)
  UIManager.Instance:Reopen(Urls.ItemExpiredPanel, itemList)
end

return ItemExpiredController
