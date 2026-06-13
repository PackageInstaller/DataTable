local ShortcutUICtrl = BaseClass("ShortcutUICtrl",BaseUICtrl)
local M = ShortcutUICtrl

function M:Init()
    self.view.clickMask:onClick(Bind(self,self.Close))
    self._maxCount = 20
end

function M:OnEnter()
    local uiConfig = UIContextMgr:GetInstance():GetTopUIConfig(CS.GameX.UIFormsType.Normal)
    for i=1,self._maxCount do
        local item = self.view["ItemBtn"..i] 
        if item then 
            item:SetCurUI(uiConfig)
        end
    end
end

--点击设置退出键
function M:OnDeviceBack()
    self:Close()
    return true 
end

function M:OnDispose()
    self.view.clickMask:onClick(nil)
    for i=1,self._maxCount do
        local item = self.view["ItemBtn"..i] 
        if item and item.OnDispose then 
            item:OnDispose()
        end
    end
    M.super.OnDispose(self)
end
return M 