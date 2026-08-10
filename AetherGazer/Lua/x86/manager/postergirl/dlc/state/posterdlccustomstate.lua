local var_0_0 = class("PosterDlcCustomState", PosterDlcTimelineState)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	function arg_1_0.onTimelineComplete()
		arg_1_0:TimelineStopCallback()
	end
end

function var_0_0.Enter(arg_3_0)
	var_0_0.super.Enter(arg_3_0)
	manager.ui:SetMainCameraCom("CinemachineBrain", true)
end

function var_0_0.Exit(arg_4_0)
	manager.ui:SetMainCameraCom("CinemachineBrain", false)

	arg_4_0.onPlayComplete = nil

	var_0_0.super.Exit(arg_4_0)
end

function var_0_0.TimelineStopCallback(arg_5_0)
	if arg_5_0.onPlayComplete then
		arg_5_0.onPlayComplete()
	end
end

function var_0_0.SetCompleteCallback(arg_6_0, arg_6_1)
	arg_6_0.onPlayComplete = arg_6_1
end

function var_0_0.PlayAni(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0.actor:GetHeroTimelineMgr()

	var_7_0:SetCallbackStopped(nil)
	var_7_0:SetCallbackBlendSignal(nil)
	var_7_0:PlayAction(arg_7_1, {
		fadeSecond = 0,
		talking = arg_7_0.talking_
	})
	var_7_0:SetCallbackStopped(arg_7_0.onTimelineComplete)
	var_7_0:SetCallbackBlendSignal(arg_7_0.onTimelineComplete)
end

return var_0_0
