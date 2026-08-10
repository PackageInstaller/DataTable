local var_0_0 = class("PosterDlcInitState", PosterDlcTimelineState)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)
end

function var_0_0.Enter(arg_2_0)
	var_0_0.super.Enter(arg_2_0)
	arg_2_0.actor:EnableEyeController(true)
	arg_2_0.actor:StopHeroTalk()
	arg_2_0.actor:MuteCamera(manager.posterGirl:GetViewTag() ~= PosterGirlConst.ViewTag.preview)

	local var_2_0 = "action1_1"
	local var_2_1

	if manager.posterGirl:GetViewTag() == PosterGirlConst.ViewTag.playerInfo then
		var_2_1 = "action1_1"
	else
		local var_2_2 = arg_2_0.actor:GetViewDirect() + 1

		var_2_1 = "action1_" .. var_2_2
	end

	arg_2_0:PlayAniWithParams(var_2_1)
end

function var_0_0.TimelineStopCallback(arg_3_0)
	return
end

function var_0_0.Exit(arg_4_0, arg_4_1)
	var_0_0.super.Exit(arg_4_0, arg_4_1)
	arg_4_0.actor:MuteCamera(false)
end

return var_0_0
