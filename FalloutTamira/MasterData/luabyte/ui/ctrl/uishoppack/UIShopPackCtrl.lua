local UIShopPackCtrl = BaseClass("UIShopPackCtrl", BaseUICtrl)
local M = UIShopPackCtrl
local ShopBagType = RechargeConst.ShopBagType
local tInsert = table.insert

function M:Init()
    local PackBuyItemCtrl = require("UI.Ctrl.Shop.PackBuyItemCtrl")
    local PackBuyItemView = require("UI.View.Shop.PackBuyItemView")

    self.gridScroll = self._view.grid
    self.gridScroll:Init(PackBuyItemCtrl, PackBuyItemView)
    self._view.btnBuy:onClick(Bind(self, self._OnBtnBuyClick))
    self._view.btnMask:onClick(Bind(self, self.OnClickCancle))

    local giftPackCtrl = require("UI.Ctrl.Shop.GiftPackItemCtrl")
    self._giftPackCtrl = giftPackCtrl.New(self._view.GiftPackItem)
end

-- 进入UI，可传参数
function M:OnEnter(shopData)
    self._shopData = shopData
    self._giftPackCtrl:UpdateItem(shopData, true)
    local shopId = self._shopData.shopConfId
    local shopBag = ConfigHelper.GetCfg("shopBag", shopId)
    if shopBag.costItem <= 0 or shopBag.costItemNum <= 0 then
        self._view.PropertyBar.gameObject:SetActive(false)
    else
        self._view.PropertyBar.gameObject:SetActive(true)
        self._view.PropertyBar:Action(shopBag.costItem)
    end
    local tempProps = {}
    for _, v in pairs(shopBag.itemGroup) do
        local itemGroup = ConfigHelper.GetCfg("itemGroup", v)
        for k, randomItem in pairs(itemGroup.items) do
            if tempProps[randomItem] then
                tempProps[randomItem] = tempProps[randomItem] + itemGroup.cnts[k]
            else
                tempProps[randomItem] = itemGroup.cnts[k]
            end
        end
    end
    local datas = {}
    for k, v in pairs(tempProps) do
        local data = {}
        data.id = k
        data.num = v
        tInsert(datas, data)
    end
    self.gridScroll:SetDataList(datas)
    if shopBag.type == ShopBagType.FreeLevelPack or shopBag.type == ShopBagType.PaidLevelPack then
        local openCondition = shopBag.openCondition
        self.isOpen = GameHelper.CheckLockByOpenConditionIds(openCondition)
        if not self.isOpen then
            self._view.UIState:SetState(2)
        end
    end
    if self._shopData.allNum > 0 and self._shopData.buyNum >= self._shopData.allNum then 
        self._view.UIState:SetState(2)
    end
end

function M:_OnBtnBuyClick()

    if self._shopData.allNum > 0 and self._shopData.buyNum >= self._shopData.allNum then 
        return
    end
    if self.alreadyBuy == true then return end
    local shopBagId = self._shopData.shopConfId
    local shopBag = ConfigHelper.GetCfg("shopBag", shopBagId)
    -- 等级礼包
    if shopBag.type == ShopBagType.FreeLevelPack or shopBag.type == ShopBagType.PaidLevelPack then
        local openCondition = shopBag.openCondition
        local isOpen = GameHelper.CheckLockByOpenConditionIds(openCondition)
        if not isOpen then
            GameHelper.TipsById(5085)
            return
        end
    end

    if shopBag.payId and shopBag.payId > 0 then
        SDKHelper.Pay(shopBag.payId, function(isOk)
            if not isOk then 
                GameHelper.TipsById(5789) -- 充值失败
            end
        end)
        self:Close()
    else
        if shopBag.costItem then
            local haveNum = ItemDataMgr:GetInstance():GetItemNumById(shopBag.costItem)
            if shopBag.costItemNum > haveNum then
                GameHelper.TipsById(5098)
                return
            end
            ShopDataMgr:RequestBuyItem(self._shopData.shopId, self._shopData.shopConfId, 1, Bind(self, self.BuyCallback))
        end
    end
end

function M:BuyCallback()
    self:Close()
end

function M:OnClickCancle(go)
    self:Close()
end

--点击设置退出键
function M:OnDeviceBack()
    self:Close()
    return true
end

function M:OnClose()
    self._rechargeCallback = nil
end

return UIShopPackCtrl
