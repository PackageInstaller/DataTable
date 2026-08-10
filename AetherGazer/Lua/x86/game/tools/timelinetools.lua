local var_0_0 = {}
local var_0_1
local var_0_2
local var_0_3 = handler(var_0_0, var_0_0.StopCallback)

function var_0_0.StopCallback()
	if var_0_1 == nil then
		return
	end

	var_0_1.stopped = var_0_1.stopped - var_0_0.StopCallback
	var_0_1.extrapolationMode = UnityEngine.Playables.DirectorWrapMode.None
	var_0_1 = nil

	if var_0_2 ~= nil then
		local var_1_0 = var_0_2

		var_0_2 = nil

		var_1_0()
	end
end

function var_0_0.StopAllCallBack()
	if var_0_1 ~= nil then
		var_0_1.stopped = var_0_1.stopped - var_0_0.StopCallback
		var_0_1.extrapolationMode = UnityEngine.Playables.DirectorWrapMode.None
		var_0_1.time = 0

		var_0_1:Stop()
	end

	var_0_1 = nil
	var_0_2 = nil
end

function var_0_0.PlayTimelineWithCallback(arg_3_0, arg_3_1, arg_3_2)
	if var_0_1 ~= nil then
		var_0_1.stopped = var_0_1.stopped - var_0_0.StopCallback
	end

	var_0_1 = arg_3_0
	var_0_2 = arg_3_2

	arg_3_0:Play(arg_3_1)

	arg_3_0.extrapolationMode = UnityEngine.Playables.DirectorWrapMode.None
	arg_3_0.time = 0
	arg_3_0.stopped = arg_3_0.stopped + var_0_0.StopCallback
end

return var_0_0
