local var_0_0 = class("PosterCommonGreetingState", PosterCommonInteractionState)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.interactionKey = PosterGirlConst.InteractionKey.greeting
end

function var_0_0.Enter(arg_2_0)
	arg_2_0.greetTimer = Timer.New(function()
		arg_2_0:CheckInsteraction()
	end, 1.2, 1)

	arg_2_0.greetTimer:Start()
end

function var_0_0.Exit(arg_4_0)
	var_0_0.super.Exit(arg_4_0)

	if arg_4_0.greetTimer then
		arg_4_0.greetTimer:Stop()

		arg_4_0.greetTimer = nil
	end
end

return var_0_0
