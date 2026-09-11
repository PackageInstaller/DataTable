local PosterDlcCustomState = class("PosterDlcCustomState", PosterDlcTimelineState)

function PosterDlcCustomState:Ctor(arg_1_1)
	PosterDlcCustomState.super.Ctor(self, arg_1_1)

	function self.onTimelineComplete()
		self:TimelineStopCallback()
	end
end

function PosterDlcCustomState:Enter()
	PosterDlcCustomState.super.Enter(self)
	manager.ui:SetMainCameraCom("CinemachineBrain", true)
end

function PosterDlcCustomState:Exit()
	manager.ui:SetMainCameraCom("CinemachineBrain", false)

	self.onPlayComplete = nil

	PosterDlcCustomState.super.Exit(self)
end

function PosterDlcCustomState:TimelineStopCallback()
	if self.onPlayComplete then
		self.onPlayComplete()
	end
end

function PosterDlcCustomState:SetCompleteCallback(arg_6_1)
	self.onPlayComplete = arg_6_1
end

function PosterDlcCustomState:PlayAni(arg_7_1, arg_7_2)
	local var_7_0 = self.actor:GetHeroTimelineMgr()

	var_7_0:SetCallbackStopped(nil)
	var_7_0:SetCallbackBlendSignal(nil)
	var_7_0:PlayAction(arg_7_1, {
		fadeSecond = 0,
		talking = self.talking_
	})
	var_7_0:SetCallbackStopped(self.onTimelineComplete)
	var_7_0:SetCallbackBlendSignal(self.onTimelineComplete)
end

return PosterDlcCustomState
