-- baoruichang
-- 2022/11/23 14:42:50
-- Masquerade_Shop
local UIMasqueradeShopCtrl = BaseClass("UIMasqueradeShopCtrl", BaseUICtrl)
local M = UIMasqueradeShopCtrl
local UIDanceShopItemCtrl = require("UI.Ctrl.UIMasquerade.UIDanceShopItemCtrl")
local UIDanceShopItemView = require("UI.View.UIMasquerade.UIDanceShopItemView")

function M:Init()
    self._view.btnBack:onClick(Bind(self, self.Close))
    self.grid = self._view.grid
    self.grid:Init(UIDanceShopItemCtrl, UIDanceShopItemView)
    self.grid:SetCreateItemCallback(Bind(self, self._OnCreateItem))
    self._view.ScrollRect.unity_uiscrollview.onValueChanged:AddListener(Bind(self, self.scrollRectChange))
    self._view.tfLeft:SetActive(false)
end

-- 进入UI，可传参数
function M:OnEnter(shopData)
    self.shopData = shopData
    self.grid:SetDataList(shopData)
    self._view.propertyBar:Action(self:GetContext():GetConstId())
end

function M:scrollRectChange(vector2)
    self._view.tfLeft:SetActive(vector2.x > 0)
    self._view.tfRight:SetActive(vector2.x < 1)
end

function M:_OnCreateItem(UIDanceShopItemCtrl)
    UIDanceShopItemCtrl:SetClickCallback(Bind(self, self._OnSelect))
end

function M:_OnSelect(data)
    self._selectSubActivityId = data.activityShop.id
    local tempData = {}
    tempData.shopItemId = data.activityShop.shopItem
    tempData.costItemId = data.activityShop.costItem
    tempData.costItemNum = data.activityShop.costNum
    tempData.canBuyNum = data.canBuyNum
    tempData.itemNum = data.activityShop.itemNum
    UIManager:GetInstance():Show(UIDefine.UIDanceShopConfirm, tempData, Bind(self, self._OnBuyClick))
end

function M:_OnBuyClick(num)
    local activityId = self:GetContext():GetActivityId()
    ActivityDataMgr:GetInstance():SendCommonReward(activityId, {self._selectSubActivityId}, Bind(self, self._OnRewardCallBack), {num})
end

function M:_OnRewardCallBack(awardData)
    GameHelper.ShowGetItems(awardData)
    self:GetContext():RefData()
end

function M:RefreshShopItem(shopData)
    self.shopData = shopData
    self.grid:SetDataList(shopData)
end

function M:OnDeviceBack()
    self:Close()
    return true
end

function M:OnDispose()
    self._view.ScrollRect.unity_uiscrollview.onValueChanged:RemoveAllListeners()
    M.super.OnDispose(self)
end

return UIMasqueradeShopCtrl
