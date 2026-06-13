local DormitoryInteractiveTipsCtrl = BaseClass("DormitoryInteractiveTipsCtrl", BaseUICtrl)
local M = DormitoryInteractiveTipsCtrl

function M:Init()

end

function M:OnEnter(text)
    self._view.text:SetText(text)
    if self.timer then
        self.timer:Stop()
    end

    self.timer = TimerManager:GetInstance():GetTimer(1, Bind(self, self.Tick), self, true)
    self.timer:Start()
end

function M:Tick()
    self:Close()
    self.timer:Stop()
    self.timer = nil
end

function M:OnDispose()
    if self.timer then
        self.timer:Stop()
    end
    M.super.OnDispose(self)
end

return DormitoryInteractiveTipsCtrl
