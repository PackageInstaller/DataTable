local DormShowGirlUICtrl = BaseClass("DormShowGirlUICtrl", BaseUICtrl)
local M = DormShowGirlUICtrl


function M:Init()
    self._view.closeBtn:onClick(Bind(self, self._OnClickCloseBtn))
end

function M:OnDispose()
    M.super.OnDispose(self)
end

function M:OnEnter(res, closeCallBack)
    self._view.pic1:SetPic(res)
    self.closeCallback = closeCallBack
end

--点击设置退出键
function M:OnDeviceBack()
    self:Close()
    return true
end

function M:_OnClickCloseBtn()
    self:Close()
end

function M:OnClose()
    if self.closeCallback then
        self.closeCallback()
    end
end 

return DormShowGirlUICtrl
