-- baoruichang
local UpLevelCtrl = BaseClass("UpLevelCtrl", BaseUICtrl)
local M = UpLevelCtrl

function M:Init()
    self._view.btnClose:onClick(Bind(self, self.Close))
    local clip = self._view.animator.runtimeAnimatorController.animationClips[0]
    self.animTimer = clip.length + 0.5
end

-- 进入UI，可传参数
function M:OnEnter(closeFunc, labCh, labEn)
    self.closeFunc = closeFunc
    labCh = labCh or 80
    labEn = labEn or 505
    self._view.labChina:SetText(labCh)
    self._view.labEn1:SetText(labEn)
    self._view.labEn2:SetText(labEn)
    self.m_timer = TimerManager:GetInstance():GetTimer(self.animTimer, Bind(self, self._EndTime), self, true)
    self.m_timer:Start()
end

function M:_EndTime()
    if self.m_timer then
        self.m_timer:Stop()
        self.m_timer = nil
    end
    self:Close()
end

-- 点击设置退出键
function M:OnDeviceBack()
    self:Close()
    return true
end

function M:Close()
    --打开过程种不允许关闭解决卡死bug
    if IUIManager.isLoadingUI then
        return
    end
    M.super.Close(self)
end

function M:OnClose()
    if self.closeFunc then
        self.closeFunc()
    end
end

return UpLevelCtrl
