local CircularScrollViewItem = require("Framework.UI.Component.CircularScrollViewItem")
local DormPuzzleActivityShopItemCtrl = BaseClass("UIDanceShopItemCtrl", CircularScrollViewItem)
local M = DormPuzzleActivityShopItemCtrl

function M:Init()
    self._view:onClick(Bind(self, self._onClickItem))
end

function M:UpdateItem(data)
    self._data = data
    local itemId = data.activityShop.shopItem
    local item = ConfigHelper.GetCfgByLua("item", itemId)
    self._view.stateQuality:SetState(item.quality)
    self._view.imgIcon:SetItemIcon(itemId)
    self._view.labCanBuyNum:SetText(tostring(data.canBuyNum))
    self._view.labName:SetText(item.name)
    self._view.ComItemSlipCtrl:SetItemById(data.activityShop.costItem, data.activityShop.costNum)
    self._view.stateSold:SetState(data.canBuyNum > 0 and 1 or 2)
end

function M:_onClickItem()
    if self._data.canBuyNum <= 0 then
        return
    end
    if self.clickCallBack then
        self.clickCallBack(self._data)
    end
end

function M:SetClickCallback(clickCallBack)
    self.clickCallBack = clickCallBack
end

return DormPuzzleActivityShopItemCtrl
