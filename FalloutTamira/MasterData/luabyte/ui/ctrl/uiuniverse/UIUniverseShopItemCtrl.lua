-- baoruichang
-- 2022/11/23 15:23:58
local CircularScrollViewItem = require("Framework.UI.Component.CircularScrollViewItem")
local UIUniverseShopItemCtrl = BaseClass("UIUniverseShopItemCtrl", CircularScrollViewItem)
local M = UIUniverseShopItemCtrl

function M:Init()
    self._view:onClick(Bind(self, self._onClickItem))
end

function M:UpdateItem(data)
    self._data = data
    local itemId = data.activityShop.shopItem
    local item = ConfigHelper.GetCfgByLua("item", itemId)
    self._view.stateQuality:SetState(item.quality)
    self._view.imgIcon:SetItemIcon(itemId)
    self._view.labName:SetText(item.name)
    self._view.ComItemSlipCtrl:SetItemById(data.activityShop.costItem, data.activityShop.costNum)
    self._view.labCanBuyNum:SetText(tostring(data.canBuyNum) .. "/" .. data.activityShop.times)
    self._view.labNum:SetText(tostring(data.activityShop.itemNum))
    self._view.tfNull:SetActive(data.canBuyNum <= 0)
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

return UIUniverseShopItemCtrl
