class = var_0_10000

local var_0_0 = var_0_10000("TimelinePlayer")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.GetComponent

	typeof = var_1_10005
	UnityEngine = var_1_10006
	arg_1_0.comDirector = var_1_1(var_1_0, var_1_10005(var_1_10006.Playables.PlayableDirector))
	GetComponent = var_3

	local var_1_2 = arg_1_1

	typeof = var_5
	TimelineSpeed = var_6

	if var_3(var_1_2, var_5(var_6)) then
		arg_1_0:SetSpeed(1)
	else
		GetOrAddComponent = var_3

		local var_1_3 = arg_1_1

		typeof = var_5
		TimelineSpeed = var_6

		var_3(var_1_3, var_5(var_6))
	end

	GetOrAddComponent = var_3
	arg_1_0.signalReceiver = var_3(arg_1_1, "DftCommonSignalReceiver")

	local var_1_4 = arg_1_0.signalReceiver

	var_3.SetCommonEvent(var_1_4, function(arg_2_0)
		local var_2_0 = arg_1_0

		var_1.TriggerEvent(var_2_0, arg_2_0)

		return
	end)

	local var_1_5 = arg_1_0.comDirector

	var_3.Stop(var_1_5)

	local var_1_6 = arg_1_0.comDirector

	if not arg_1_2 then
		::label_1_0::

		ReflectionHelp = var_1_5
		var_1_5 = var_1_5.RefGetField
		typeof = var_5
		var_1_5 = var_1_5(var_5("UnityEngine.Playables.DirectorWrapMode"), "Hold", nil)
	end

	var_1_6.extrapolationMode = var_1_5
	TimelineSupport = var_1_6

	var_1_6.InitTimeline(arg_1_0.comDirector)

	return
end

function var_0_0.Register(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 then
		local var_3_0 = arg_3_0.comDirector

		math = var_1_10004
		var_3_0.time = var_1_10004.clamp(arg_3_1, 0, arg_3_0.comDirector.duration)
	end

	if arg_3_2 then
		arg_3_0.triggerFunc = arg_3_2
	end

	return
end

function var_0_0.TriggerEvent(arg_4_0, arg_4_1)
	assert = var_1_10002

	var_1_10002(arg_4_0.triggerFunc)
	arg_4_0.triggerFunc(arg_4_0, arg_4_1, arg_4_0.mark)

	return
end

function var_0_0.Start(arg_5_0)
	arg_5_0.mark = {}

	arg_5_0:Play()

	return
end

function var_0_0.Play(arg_6_0)
	local var_6_0 = arg_6_0.comDirector

	var_1.Play(var_6_0)

	return
end

function var_0_0.Pause(arg_7_0)
	local var_7_0 = arg_7_0.comDirector

	var_1.Pause(var_7_0)

	return
end

function var_0_0.Stop(arg_8_0)
	local var_8_0 = arg_8_0.comDirector

	var_1.Stop(var_8_0)

	return
end

function var_0_0.Resume(arg_9_0)
	local var_9_0 = arg_9_0.comDirector

	var_1.Resume(var_9_0)

	return
end

function var_0_0.SetSpeed(arg_10_0, arg_10_1)
	setDirectorSpeed = var_1_10002

	var_1_10002(arg_10_0.comDirector, arg_10_1)

	return
end

function var_0_0.GetTime(arg_11_0)
	return arg_11_0.comDirector.time
end

function var_0_0.SetTime(arg_12_0, arg_12_1)
	arg_12_0.comDirector.time = arg_12_1

	local var_12_0 = arg_12_0.comDirector

	var_2.RebuildGraph(var_12_0)

	return
end

function var_0_0.RawSetTime(arg_13_0, arg_13_1)
	arg_13_0.comDirector.time = arg_13_1

	local var_13_0 = arg_13_0.comDirector

	var_2.Evaluate(var_13_0)

	return
end

function var_0_0.Dispose(arg_14_0)
	return
end

return var_0_0
