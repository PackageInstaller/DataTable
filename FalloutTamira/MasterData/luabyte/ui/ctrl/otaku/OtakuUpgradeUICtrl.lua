local M = BaseClass("OtakuUpgradeUICtrl", BaseUICtrl)

function M:Init()
    self._view.btn_mask:onClick(Bind(self, self.Close))
end

function M:OnEnter(roomData)
    self._view.upInfo:ShowUpgradeInfo(roomData, Bind(self, self.Close))
end

--点击设置退出键【关闭带顶栏的Normal窗口】
function M:OnDeviceBack()
    self:Close()
    return true
end

function M:OnBack()
    self:Close()
    return true
end

function M:OnVisible()
    self._view.upInfo:OnItemChanged()
end

return M
