_class("StateBounceResume", StateBounceBase)
StateBounceResume = StateBounceResume

function StateBounceResume:OnEnter(TT, ...)
  self:Init()
  local resumeView = self.uiController:GetResumeView()
  resumeView:Start()
end

function StateBounceResume:OnExit(TT)
end
