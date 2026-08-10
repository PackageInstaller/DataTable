local var_0_0 = class("PosterCommonInitState", PosterCommonTimelineState)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.skipBlend = arg_1_2
end

function var_0_0.Enter(arg_2_0)
	var_0_0.super.Enter(arg_2_0)
	arg_2_0.actor:EnableEyeController(true)

	if manager.posterGirl:GetViewTag() == PosterGirlConst.ViewTag.home and #arg_2_0.actor:GetInteractionCfg()[PosterGirlConst.InteractionKey.idle] ~= 0 then
		arg_2_0.idleTimer = Timer.New(function()
			arg_2_0:OnlyMainActorDo(function()
				manager.posterGirl:DoIdle()
			end)
		end, 60, -1)

		arg_2_0.idleTimer:Start()
	end

	if arg_2_0.skipBlend then
		arg_2_0.skipBlend = nil

		arg_2_0:PlayAni("action1_1", 0)
	else
		arg_2_0:PlayAni("action1_1")
	end
end

function var_0_0.AnimationEndCall(arg_5_0)
	return
end

function var_0_0.Exit(arg_6_0)
	var_0_0.super.Exit(arg_6_0)

	if arg_6_0.idleTimer then
		arg_6_0.idleTimer:Stop()

		arg_6_0.idleTimer = nil
	end
end

return var_0_0
