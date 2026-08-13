class = var_0_10000

local var_0_0 = var_0_10000("OreMiner")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.binder = arg_1_1
	arg_1_0._tf = arg_1_2
	arg_1_0.interval = arg_1_3
	findTF = var_1_10004

	local var_1_0 = var_1_10004(arg_1_0._tf, "Image")
	local var_1_1 = var_4.GetComponent

	typeof = var_7
	Animator = var_1_10009
	arg_1_0.animator = var_1_1(var_1_0, var_7(var_1_10009))

	arg_1_0:Init()

	return
end

function var_0_0.AddListener(arg_2_0)
	local var_2_0 = arg_2_0.binder
	local var_2_1 = var_1.bind

	OreGameConfig = var_1_10004

	var_2_1(var_2_0, var_1_10004.EVENT_ORE_EF_MINED, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_2_0

		var_2.PlayEFMined(var_3_0, arg_3_1.index)

		return
	end)

	return
end

function var_0_0.AddDftAniEvent(arg_4_0)
	findTF = var_1_10001

	local var_4_0 = var_1_10001(arg_4_0._tf, "Image")
	local var_4_1 = var_1.GetComponent

	typeof = var_4
	DftAniEvent = var_1_10006

	local var_4_2 = var_4_1(var_4_0, var_4(var_1_10006))

	var_1.SetTriggerEvent(var_4_2, function()
		local var_5_0 = arg_4_0.binder
		local var_5_1 = var_0.emit

		OreGameConfig = var_2_10003

		var_5_1(var_5_0, var_2_10003.EVENT_ORE_NEW, {
			index = arg_4_0.index,
			pos = arg_4_0._tf.parent.anchoredPosition
		})

		return
	end)

	findTF = var_1

	local var_4_3 = var_1(arg_4_0._tf, "EF")
	local var_4_4 = var_1.GetComponent

	typeof = var_4
	DftAniEvent = var_1_10006

	local var_4_5 = var_4_4(var_4_3, var_4(var_1_10006))

	var_1.SetEndEvent(var_4_5, function()
		setActive = var_2_10000
		findTF = var_2_10002

		var_2_10000(var_2_10002(arg_4_0._tf, "EF"), false)

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
	math = var_1_10001
	arg_8_0.interval = 1.5 + var_1_10001.random()
	arg_8_0.time = 1.5

	return
end

function var_0_0.PlayEFMined(arg_9_0, arg_9_1)
	if arg_9_0.index == arg_9_1 then
		setActive = var_2
		findTF = var_1_10004

		var_2(var_1_10004(arg_9_0._tf, "EF"), true)
	end

	return
end

function var_0_0.OnTimer(arg_10_0, arg_10_1)
	if arg_10_0.time >= arg_10_0.interval then
		local var_10_0 = arg_10_0.animator

		var_2.Play(var_10_0, "Mining")

		arg_10_0.time = 0
	end

	arg_10_0.time = arg_10_0.time + arg_10_1

	return
end

return var_0_0
