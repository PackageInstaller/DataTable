local MonthCardItemCtrl = BaseClass("MonthCardItemCtrl")
local M = MonthCardItemCtrl

function M:__init(view)
    self._view = view
    self._data = nil

    self._view.rectItem:onClick(Bind(self, self.OnItemClick))
    self._view.rectTips:onClick(Bind(self, self.OnTipsClick))
end

function M:Dispose()
    self._view.rectItem:onClick(nil)
    self._view.rectTips:onClick(nil)
    self._data = nil
    self:OnDispose()
end

function M:OnDispose()
    if self._view then self._view:OnDispose() end
    self._view = nil
end

function M:OnItemClick()
    if self.canBuy then
        UIContextMgr:GetInstance():Show("MonthCardPopupUI", self.cardCfg)
    end
end

function M:OnTipsClick()
    UIContextMgr:GetInstance():Show("ComTipsPopupUI", 4191, 4192)
end

function M:UpdateItem(data)
    if data == nil then
        return
    end

    self._data = data
    self.shopBagCfg = ConfigHelper.GetCfgByLua("shopBag", self._data.shopConfId)
    self.cardCfg = ConfigHelper.GetCfgByLua("shopCard", self.shopBagCfg.shopCardId)
    self:_UpdateData(self.cardCfg)
end

function M:_UpdateData(data)
    self._view.imgIcon:SetPic(data.itemPicture)
    self._view.txtDes:SetText(data.desc)

    self:_SetCost(data)
    self:_SetRemainingDays()
end

function M:_SetCost(data)
    if data.shopId > 0 then
        local paycfg = ConfigHelper.GetCfgByLua("pay", data.shopId)
        local currency = ConfigHelper.GetLocalString(paycfg.monetaryUnit)
        local price = string.format("%d", paycfg.truePrice / 100)
        -- if string.sub(price, -1) == "0" then
        --     price = string.sub(price, 1, -2)
        -- end
        self._view.txtCost:SetText(currency .. price)
    else
        self._view.txtCost:SetText(5083)
    end
end

function M:_SetRemainingDays()
    local days = RechargeDataMgr:GetInstance():GetRemainingDays()
    self.canBuy = RechargeDataMgr:GetInstance():CheckBuyMonthCard(self.shopBagCfg.shopCardId)
    if days > 0 then
        self._view.rectDays:SetActive(true)
        local format = ConfigHelper.GetLocalString(200055)
        local daysDesc = string.format(format, days)
        self._view.txtDays:SetText(daysDesc)
        if self.canBuy then
            self._view.rectSoldout:SetActive(false)
        else
            self._view.rectSoldout:SetActive(true)
        end
    else
        self._view.rectDays:SetActive(false)
        self._view.rectSoldout:SetActive(false)
    end
end

return MonthCardItemCtrl
