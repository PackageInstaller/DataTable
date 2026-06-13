-- baoruichang
-- 2021/12/8 22:43:33
local UIVotingShopCtrl = BaseClass("UIVotingShopCtrl", BaseUICtrl)
local M = UIVotingShopCtrl
local UIVotingShopItemCtrl = require("UI.Ctrl.UIVotingShop.UIVotingShopItemCtrl")
local UIVotingShopItemView = require("UI.View.UIVotingShop.UIVotingShopItemView")

function M:Init()
    self.ScrollView = self._view.ScrollView
    self.ScrollView:Init(UIVotingShopItemCtrl, UIVotingShopItemView)
    self.ScrollView:SetCreateItemCallback(Bind(self, self._OnCreateItem))
end

-- 进入UI，可传参数
function M:OnEnter(shopData)
    self:UpdateList(shopData)
end

function M:UpdateList(shopData)
    self.shopData = shopData
    self.ScrollView:SetDataList(shopData)
end

function M:_OnCreateItem(item)
    item:SetBuyCallBack(Bind(self, self._OnSelect))
end

function M:_OnSelect(shopData)
    local tempData = {}
    tempData.shopItemId = shopData.itemId
    tempData.costItemId = shopData.ConstItemId
    tempData.costItemNum = shopData.ConstItemNum
    tempData.canBuyNum = shopData.canNum
    UIManager:GetInstance():Show(UIDefine.UIShopConfirm, tempData, Bind(self, self._OnBuyClick, shopData.id))
end

function M:_OnBuyClick(id, num)
    self:GetContext():CommonActivityAwardReq(id, num)
end

return UIVotingShopCtrl
