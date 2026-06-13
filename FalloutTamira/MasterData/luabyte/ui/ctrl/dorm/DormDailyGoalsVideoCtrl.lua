local DormDailyGoalsVideoCtrl = BaseClass("DormDailyGoalsVideoCtrl")
local M = DormDailyGoalsVideoCtrl

function M:__init(view)
    self._view = view
    self._view.btn:onClick(Bind(self, self.OnClickVideo))
    self.m_state = nil
end

function M:OnClickVideo()
    if self.m_state == 1 then
        self:Pause()
        return
    end

    if self.m_state == 2 then
        self:Play()
        return
    end
end

function M:PlayVideo(url)
    self._view.videoPlayer:Play(url)
    self:SetState(1)
end

function M:Pause()
    self._view.videoPlayer:Pause()
    self:SetState(2)
end

function M:Play()
    self._view.videoPlayer:Play()
    self:SetState(1)
end

function M:SetState(state)
    self.m_state = state
    self._view.playState:SetState(self.m_state)
end

function M:OnDispose()
    self.m_state = nil
    if self._view then
        self._view:OnDispose()
        self._view = nil
    end
end

return DormDailyGoalsVideoCtrl
