local var_0_0 = class("OreMiner")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.binder = arg_1_1
	arg_1_0._tf = arg_1_2
	arg_1_0.interval = arg_1_3
	arg_1_0.animator = findTF(arg_1_0._tf, "Image"):GetComponent(typeof(Animator))

	arg_1_0:Init()

	return
end

function var_0_0.AddListener(arg_2_0)
	arg_2_0.binder:bind(OreGameConfig.EVENT_ORE_EF_MINED, function(arg_3_0, arg_3_1)
		arg_2_0:PlayEFMined(arg_3_1.index)

		return
	end)

	return
end

function var_0_0.AddDftAniEvent(arg_4_0)
	findTF(arg_4_0._tf, "Image"):GetComponent(typeof(DftAniEvent)):SetTriggerEvent(function()
		arg_4_0.binder:emit(OreGameConfig.EVENT_ORE_NEW, {
			index = arg_4_0.index,
			pos = arg_4_0._tf.parent.anchoredPosition
		})

		return
	end)
	findTF(arg_4_0._tf, "EF"):GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
		setActive(findTF(arg_4_0._tf, "EF"), false)

		return
	end)

	return
end

function var_0_0.Init(arg_7_0)
	arg_7_0:AddListener()
	arg_7_0:AddDftAniEvent()

	arg_7_0.time = 1.5
	arg_7_0.index = arg_7_0._tf.name

	return
end

function var_0_0.Reset(arg_8_0)
	arg_8_0.interval = 1.5 + math.random()
	arg_8_0.time = 1.5

	return
end

function var_0_0.PlayEFMined(arg_9_0, arg_9_1)
	if arg_9_0.index == arg_9_1 then
		setActive(findTF(arg_9_0._tf, "EF"), true)
	end

	return
end

function var_0_0.OnTimer(arg_10_0, arg_10_1)
	if arg_10_0.time >= arg_10_0.interval then
		arg_10_0.animator:Play("Mining")

		arg_10_0.time = 0
	end

	arg_10_0.time = arg_10_0.time + arg_10_1

	return
end

return var_0_0
