local MonthCardPopupUICtrl = BaseClass("MonthCardPopupUICtrl", BaseUICtrl)
local M = MonthCardPopupUICtrl

function M:Init()
    self._view.rectBuy:onClick(Bind(self, self.OnBuyClick))
    self._view.rectTips:onClick(Bind(self, self.OnTipsClick))
    self._view.rectClose:onClick(Bind(self, self.Close))
end

function M:OnEnter(data)
    self.data = data
    self._view.imgIcon:SetPic(data.itemPicture)
    self._view.txtDes:SetText(data.desc)

    self:_SetCost(data)
    self:_SetRemainingDays()
    self:_InitItemList()
end

function M:_SetCost(data)
    if data.shopId > 0 then
        local paycfg = ConfigHelper.GetCfgByLua("pay", data.shopId)
        local currency = ConfigHelper.GetLocalString(paycfg.monetaryUnit)
        local price = string.format("%d", paycfg.truePrice / 100)
        -- if string.sub(price, -1) == "0" then
        --     price = string.sub(price, 1, -2)
        -- end
        self._view.txtCost:SetText((currency .. price))
    else
        self._view.txtCost:SetText(5083)
    end
end

function M:_SetRemainingDays()
    local days = RechargeDataMgr:GetInstance():GetRemainingDays()
    if days > 0 then
        self._view.rectDays:SetActive(true)
        local format = ConfigHelper.GetLocalString(200055)
        local daysDesc = string.format(format, days)
        self._view.txtDays:SetText(daysDesc)
    else
        self._view.rectDays:SetActive(false)
    end
end

function M:_InitItemList()
    self._view.scrollItems:SetCreateItemCallback(Bind(self, self.OnCreateItem))
    local ctrl = require("UI.Ctrl.Shop.PackBuyItemCtrl")
    local view = require("UI.View.Shop.PackBuyItemView")
    self._view.scrollItems:Init(ctrl, view)
    local items = RechargeDataMgr:GetInstance():GetMonthBuyItems()
    self._view.scrollItems:SetDataList(items)
end

function M:OnCreateItem(item)
    item.isMonthCard = true
end

function M:OnBuyClick()
    if self.data.shopId > 0 then
        SDKHelper.Pay(self.data.shopId, function(isOk)
            if not isOk then
                GameHelper.TipsById(5789) -- 充值失败
            end
        end)
    end
    self:Close()
end

function M:OnTipsClick()
    UIContextMgr:GetInstance():Show("ShopTipsUI", 4191, 4192)
end

function M:BuySuccess()
    IRedPointMgr:ForceCheck(RedPointConst.ShopBoxRedPointChecker)
    self:Close()
end

function M:OnClose()
end

--点击设置退出键
function M:OnDeviceBack()
    self:Close()
    return true
end

function M:OnDispose()
    self._view.scrollItems:Dispose()
    self._view.rectBuy:onClick(nil)
    self._view.rectTips:onClick(nil)
    self._view.rectClose:onClick(nil)
    M.super.OnDispose(self)
end

return MonthCardPopupUICtrl
