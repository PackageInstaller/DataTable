local var_0_0 = class("TimelinePlayer")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.comDirector = arg_1_1:GetComponent(typeof(UnityEngine.Playables.PlayableDirector))

	if GetComponent(arg_1_1, typeof(TimelineSpeed)) then
		arg_1_0:SetSpeed(1)
	else
		GetOrAddComponent(arg_1_1, typeof(TimelineSpeed))
	end

	arg_1_0.signalReceiver = GetOrAddComponent(arg_1_1, "DftCommonSignalReceiver")

	arg_1_0.signalReceiver:SetCommonEvent(function(arg_2_0)
		arg_1_0:TriggerEvent(arg_2_0)

		return
	end)
	arg_1_0.comDirector:Stop()

	arg_1_0.comDirector.extrapolationMode = arg_1_2 or ReflectionHelp.RefGetField(typeof("UnityEngine.Playables.DirectorWrapMode"), "Hold", nil)

	TimelineSupport.InitTimeline(arg_1_0.comDirector)

	return
end

function var_0_0.Register(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 then
		arg_3_0.comDirector.time = math.clamp(arg_3_1, 0, arg_3_0.comDirector.duration)
	end

	if arg_3_2 then
		arg_3_0.triggerFunc = arg_3_2
	end

	return
end

function var_0_0.TriggerEvent(arg_4_0, arg_4_1)
	assert(arg_4_0.triggerFunc)
	arg_4_0:triggerFunc(arg_4_1, arg_4_0.mark)

	return
end

function var_0_0.Start(arg_5_0)
	arg_5_0.mark = {}

	arg_5_0:Play()

	return
end

function var_0_0.Play(arg_6_0)
	arg_6_0.comDirector:Play()

	return
end

function var_0_0.Pause(arg_7_0)
	arg_7_0.comDirector:Pause()

	return
end

function var_0_0.Stop(arg_8_0)
	arg_8_0.comDirector:Stop()

	return
end

function var_0_0.Resume(arg_9_0)
	arg_9_0.comDirector:Resume()

	return
end

function var_0_0.SetSpeed(arg_10_0, arg_10_1)
	setDirectorSpeed(arg_10_0.comDirector, arg_10_1)

	return
end

function var_0_0.GetTime(arg_11_0)
	return arg_11_0.comDirector.time
end

function var_0_0.SetTime(arg_12_0, arg_12_1)
	arg_12_0.comDirector.time = arg_12_1

	arg_12_0.comDirector:RebuildGraph()

	return
end

function var_0_0.RawSetTime(arg_13_0, arg_13_1)
	arg_13_0.comDirector.time = arg_13_1

	arg_13_0.comDirector:Evaluate()

	return
end

function var_0_0.Dispose(arg_14_0)
	return
end

return var_0_0
