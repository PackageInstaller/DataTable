local var_0_0 = class("PosterCommonCustomState", PosterCommonTimelineState)

function var_0_0.Enter(arg_1_0)
	var_0_0.super.Enter(arg_1_0)
end

function var_0_0.Exit(arg_2_0)
	arg_2_0.onPlayComplete = nil

	var_0_0.super.Exit(arg_2_0)
end

function var_0_0.TimelineStopCallback(arg_3_0)
	if arg_3_0.onPlayComplete then
		arg_3_0.onPlayComplete()
	end
end

function var_0_0.SetCompleteCallback(arg_4_0, arg_4_1)
	arg_4_0.onPlayComplete = arg_4_1
end

return var_0_0
