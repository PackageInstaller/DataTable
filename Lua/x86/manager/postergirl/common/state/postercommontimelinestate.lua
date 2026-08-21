local var_0_0 = class("PosterCommonTimelineState", PosterGirlBaseState)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	function arg_1_0.onTimelineComplete()
		arg_1_0:TimelineStopCallback()
	end
end

function var_0_0.Enter(arg_3_0)
	var_0_0.super.Enter(arg_3_0)
end

local var_0_1 = 0.4

function var_0_0.PlayAni(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_0.actor:GetHeroTimelineMgr()

	var_4_0:SetCallbackStopped(nil)
	var_4_0:SetCallbackBlendSignal(nil)
	var_4_0:PlayAction(arg_4_1, {
		fadeSecond = arg_4_2 or var_0_1,
		talking = arg_4_0.talking_
	})
	var_4_0:SetCallbackStopped(arg_4_0.onTimelineComplete)
	var_4_0:SetCallbackBlendSignal(arg_4_0.onTimelineComplete)
end

function var_0_0.SkipToEnd(arg_5_0)
	arg_5_0.actor:GetHeroTimelineMgr():TryJumpToEnd()
end

function var_0_0.TimelineStopCallback(arg_6_0)
	local var_6_0 = arg_6_0.actor:GetHeroTimelineMgr()

	var_6_0:SetCallbackStopped(nil)
	var_6_0:SetCallbackBlendSignal(nil)
	arg_6_0.actor:ChangeState(PosterGirlConst.StateKay.init)
end

function var_0_0.Exit(arg_7_0, arg_7_1)
	arg_7_0:StopTalkDelayTimer()

	local var_7_0 = arg_7_0.actor:GetHeroTimelineMgr()

	var_7_0:SetCallbackStopped(nil)
	var_7_0:SetCallbackBlendSignal(nil)
	arg_7_0.actor:ResetBlendShapes()
	var_0_0.super.Exit(arg_7_0, arg_7_1)
end

function var_0_0.StopTalkDelayTimer(arg_8_0)
	if arg_8_0.talkDelayTimer then
		arg_8_0.talkDelayTimer:Stop()

		arg_8_0.talkDelayTimer = nil
	end
end

function var_0_0.PlaySpecialTalk(arg_9_0, arg_9_1, arg_9_2)
	arg_9_2 = arg_9_2 or 0

	if manager.story:IsPlay() then
		return
	end

	arg_9_0:StopTalkDelayTimer()

	local var_9_0, var_9_1 = HeroTools.GetIntHeroIDAndInteractionVoiceFileName(arg_9_1)

	if arg_9_2 > 0 then
		arg_9_0.talkDelayTimer = Timer.New(function()
			arg_9_0.actor:PlayHeroTalk(var_9_0, var_9_1, nil)
		end, arg_9_2 / 1000)

		arg_9_0.talkDelayTimer:Start()
	else
		arg_9_0.actor:PlayHeroTalk(var_9_0, var_9_1, nil)
	end
end

function var_0_0.OnlyMainActorDo(arg_11_0, arg_11_1)
	if manager.posterGirl.actor == arg_11_0.actor then
		arg_11_1()
	end
end

return var_0_0
