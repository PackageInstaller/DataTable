local MonthCardRewardUICtrl = BaseClass("MonthCardRewardUICtrl", BaseUICtrl)
local M = MonthCardRewardUICtrl

function M:Init()
    self._closeCallback = nil
    self._view.rectClose:onClick(Bind(self, self.Close))
    self._view.item:SetItemNameActive(true)
end

function M:OnEnter(id, cnt, callback)
    self._closeCallback = callback
    self._view.item:SetInfo(id, ItemNumberType.TOTLE, cnt, 0)
    local format = ConfigHelper.GetLocalString(30232)
    local days = RechargeDataMgr:GetInstance():GetRemainingDays()
    self._view.txtRemainDays:SetText(string.format(format, days))
end

function M:OnClose()
    if self._closeCallback then
        self._closeCallback()
        self._closeCallback = nil
    end
end

function M:OnDispose() 
    M.super.OnDispose(self)
end

return MonthCardRewardUICtrl