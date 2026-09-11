local PosterCommonTimelineState = class("PosterCommonTimelineState", PosterGirlBaseState)

function PosterCommonTimelineState:Ctor(arg_1_1)
	PosterCommonTimelineState.super.Ctor(self, arg_1_1)

	function self.onTimelineComplete()
		self:TimelineStopCallback()
	end
end

function PosterCommonTimelineState:Enter()
	PosterCommonTimelineState.super.Enter(self)
end

local var_0_1 = 0.4

function PosterCommonTimelineState:PlayAni(arg_4_1, arg_4_2)
	local var_4_0 = self.actor:GetHeroTimelineMgr()

	var_4_0:SetCallbackStopped(nil)
	var_4_0:SetCallbackBlendSignal(nil)
	var_4_0:PlayAction(arg_4_1, {
		fadeSecond = arg_4_2 or var_0_1,
		talking = self.talking_
	})
	var_4_0:SetCallbackStopped(self.onTimelineComplete)
	var_4_0:SetCallbackBlendSignal(self.onTimelineComplete)
end

function PosterCommonTimelineState:SkipToEnd()
	self.actor:GetHeroTimelineMgr():TryJumpToEnd()
end

function PosterCommonTimelineState:TimelineStopCallback()
	local var_6_0 = self.actor:GetHeroTimelineMgr()

	var_6_0:SetCallbackStopped(nil)
	var_6_0:SetCallbackBlendSignal(nil)
	self.actor:ChangeState(PosterGirlConst.StateKay.init)
end

function PosterCommonTimelineState:Exit(arg_7_1)
	self:StopTalkDelayTimer()

	local var_7_0 = self.actor:GetHeroTimelineMgr()

	var_7_0:SetCallbackStopped(nil)
	var_7_0:SetCallbackBlendSignal(nil)
	self.actor:ResetBlendShapes()
	PosterCommonTimelineState.super.Exit(self, arg_7_1)
end

function PosterCommonTimelineState:StopTalkDelayTimer()
	if self.talkDelayTimer then
		self.talkDelayTimer:Stop()

		self.talkDelayTimer = nil
	end
end

function PosterCommonTimelineState:PlaySpecialTalk(arg_9_1, arg_9_2)
	arg_9_2 = arg_9_2 or 0

	if manager.story:IsPlay() then
		return
	end

	self:StopTalkDelayTimer()

	local var_9_0, var_9_1 = HeroTools.GetIntHeroIDAndInteractionVoiceFileName(arg_9_1)

	if arg_9_2 > 0 then
		self.talkDelayTimer = Timer.New(function()
			self.actor:PlayHeroTalk(var_9_0, var_9_1, nil)
		end, arg_9_2 / 1000)

		self.talkDelayTimer:Start()
	else
		self.actor:PlayHeroTalk(var_9_0, var_9_1, nil)
	end
end

function PosterCommonTimelineState:OnlyMainActorDo(arg_11_1)
	if manager.posterGirl.actor == self.actor then
		arg_11_1()
	end
end

return PosterCommonTimelineState
