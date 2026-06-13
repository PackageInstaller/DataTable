local M = BaseClass("PayChooseCtrl", BaseUICtrl)
local EPayChannel = CS.GameX.EPayChannel

function M:Init()
    self._view.toggleAli.onValueChanged:AddListener(Bind(self, self.OnClickAli))
    self._view.toggleWechat.onValueChanged:AddListener(Bind(self, self.OnClickWechat))
    self._view.btnBuy:onClick(Bind(self, self._OnClickBuy))
    self._view.btnBack:onClick(Bind(self, self.Close))
end

function M:OnEnter(selectCallback, payId)
    self._selectCallback = selectCallback
    self.payType = EPayChannel.AliPay
    self.payCfg = ConfigHelper.GetCfgByLua("pay", payId)
    local price = string.format("%d", self.payCfg.truePrice / 100)
    -- if string.sub(price, -1) == "0" then
    --     price = string.sub(price, 1, -2)
    -- end
    self._view.labNum:SetText(price)
    self._view.labName:SetText(self.payCfg.name)
    self._view.toggleAli:SetIsOn(true, false)
end

function M:OnClickAli(isOn)
    if not isOn then
        return
    end
    self.payType = EPayChannel.AliPay
end

function M:OnClickWechat(isOn)
    if not isOn then
        return
    end
    self.payType = EPayChannel.WeChat
end

function M:_OnClickBuy()
    if self._selectCallback then
        self._selectCallback(self.payType)
    end
    self:Close()
end

function M:OnClose()
    self._selectCallback = nil
end

return M
