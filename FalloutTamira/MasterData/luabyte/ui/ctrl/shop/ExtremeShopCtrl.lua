local ShopUICtrl = BaseClass("ExtremeShopCtrl", BaseUICtrl)
local M = ShopUICtrl
local UIUniverseShopItemCtrl = require("UI.Ctrl.Shop.LimitShopItemCtrl")
local UIUniverseShopItemView = require("UI.View.UIUniverse.UIUniverseShopItemView")

function M:Init()
    self.UpdateShopHandler = EventMgr:AddListener(UIMessageNames.LIMITSHOP_UPDATE, Bind(self, self.OnUpdateShop))
    self._view.BackBtn:onClick(Bind(self, self._OnClickClose))

end

function M:OnEnter(data)
    self:_InitItemScrollView()
    self:OnUpdateShop(data)
end

function M:_InitItemScrollView()
    self.scrollView = self._view.CommodityScrollView
    self.scrollView:Init(UIUniverseShopItemCtrl, UIUniverseShopItemView)
end

function M:OnUpdateShop(data)
    self.curShopData = data
    self.scrollView:SetDataList(self.curShopData)
end

function M:_OnClickClose()
    self:Close()
end


function M:OnDispose()
    EventMgr:RemoveListener(UIMessageNames.LIMITSHOP_UPDATE, self.UpdateShopHandler)
    self.UpdateShopHandler = nil
    M.super.OnDispose(self)
end

return ShopUICtrl
