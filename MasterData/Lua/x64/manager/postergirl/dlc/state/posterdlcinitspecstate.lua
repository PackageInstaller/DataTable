local PosterDlcInitState = class("PosterDlcInitState", PosterDlcTimelineState)

function PosterDlcInitState:Ctor(arg_1_1)
	PosterDlcInitState.super.Ctor(self, arg_1_1)
end

function PosterDlcInitState:Enter()
	PosterDlcInitState.super.Enter(self)
	self.actor:EnableEyeController(true)
	self.actor:StopHeroTalk()
	self.actor:MuteCamera(manager.posterGirl:GetViewTag() ~= PosterGirlConst.ViewTag.preview)
	self:PlayAniWithParams(manager.posterGirl:GetViewTag() == PosterGirlConst.ViewTag.playerInfo and "action1_1" or "action1_" .. self.actor:GetViewDirect() + 1)
end

function PosterDlcInitState:TimelineStopCallback()
	return
end

function PosterDlcInitState:Exit(arg_4_1)
	PosterDlcInitState.super.Exit(self, arg_4_1)
	self.actor:MuteCamera(false)
end

return PosterDlcInitState
