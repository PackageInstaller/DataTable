class = var_0_10000

local var_0_0 = var_0_10000("CryptolaliaScrollRectAnimation")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._tf = arg_1_1
	arg_1_0.isInit = false

	return
end

function var_0_0.Init(arg_2_0)
	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_1.GetComponent

	typeof = var_1_10003
	Animation = var_1_10004
	arg_2_0.animation = var_2_1(var_2_0, var_1_10003(var_1_10004))

	local var_2_2 = arg_2_0._tf
	local var_2_3 = var_1.GetComponent

	typeof = var_3
	DftAniEvent = var_1_10004
	arg_2_0.dftAniEvent = var_2_3(var_2_2, var_3(var_1_10004))

	local var_2_4 = arg_2_0.dftAniEvent

	var_1.SetTriggerEvent(var_2_4, function()
		if arg_2_0.onTrigger then
			arg_2_0.onTrigger()
		end

		arg_2_0.onTrigger = nil

		return
	end)

	local var_2_5 = arg_2_0.dftAniEvent

	var_1.SetEndEvent(var_2_5, function()
		if arg_2_0.callback then
			arg_2_0.callback()
		end

		return
	end)

	local var_2_6 = arg_2_0._tf

	arg_2_0.subAnim = var_1.Find(var_2_6, "Main/anim")

	local var_2_7 = arg_2_0.subAnim
	local var_2_8 = var_1.GetComponent

	typeof = var_3
	Animation = var_1_10004
	arg_2_0.subAnimation = var_2_8(var_2_7, var_3(var_1_10004))

	local var_2_9 = arg_2_0.subAnim
	local var_2_10 = var_1.GetComponent

	typeof = var_3
	DftAniEvent = var_1_10004
	arg_2_0.subDftAniEvent = var_2_10(var_2_9, var_3(var_1_10004))

	local var_2_11 = arg_2_0.subDftAniEvent

	var_1.SetStartEvent(var_2_11, function()
		arg_2_0.playing = true

		return
	end)

	local var_2_12 = arg_2_0.subDftAniEvent

	var_1.SetEndEvent(var_2_12, function()
		arg_2_0.playing = false

		if arg_2_0.onLastUpdate then
			arg_2_0.onLastUpdate()

			arg_2_0.onLastUpdate = nil
		end

		return
	end)

	arg_2_0.playing = false

	if not arg_2_0.handle then
		UpdateBeat = var_1
		arg_2_0.handle = var_1:CreateListener(arg_2_0.Update, arg_2_0)
	end

	UpdateBeat = var_1

	var_1:AddListener(arg_2_0.handle)

	arg_2_0.isInit = true

	return
end

function var_0_0.Update(arg_7_0)
	if arg_7_0.playing and arg_7_0.onUpdate then
		local var_7_0 = arg_7_0:Evaluate()

		arg_7_0.onUpdate(var_7_0)
	elseif not arg_7_0.playing and arg_7_0.onUpdate then
		arg_7_0.onUpdate = nil
	end

	return
end

function var_0_0.Play(arg_8_0, arg_8_1)
	if not arg_8_0.isInit then
		arg_8_0:Init()
	end

	arg_8_0:Stop()

	local var_8_0 = arg_8_0.animation

	var_2.Play(var_8_0, "anim_Cryptolalia_change")

	local var_8_1 = arg_8_1 <= 0 and "anim_Cryptolalia_listup" or "anim_Cryptolalia_listdown"
	local var_8_2 = arg_8_0.subAnimation

	var_3.Play(var_8_2, var_8_1)

	return var_0_0
end

function var_0_0.OnUpdate(arg_9_0, arg_9_1)
	arg_9_0.onUpdate = arg_9_1

	return var_0_0
end

function var_0_0.OnLastUpdate(arg_10_0, arg_10_1)
	arg_10_0.onLastUpdate = arg_10_1

	return var_0_0
end

function var_0_0.OnTrigger(arg_11_0, arg_11_1)
	arg_11_0.onTrigger = arg_11_1

	return var_0_0
end

function var_0_0.OnComplete(arg_12_0, arg_12_1)
	arg_12_0.callback = arg_12_1

	return var_0_0
end

function var_0_0.Evaluate(arg_13_0)
	return arg_13_0.subAnim.localPosition
end

function var_0_0.Stop(arg_14_0)
	arg_14_0.playing = false

	local var_14_0 = arg_14_0.animation

	var_1.Stop(var_14_0)

	local var_14_1 = arg_14_0.subAnimation

	var_1.Stop(var_14_1)

	return
end

function var_0_0.Dispose(arg_15_0)
	local var_15_0 = arg_15_0.dftAniEvent

	var_1.SetTriggerEvent(var_15_0, nil)

	local var_15_1 = arg_15_0.dftAniEvent

	var_1.SetEndEvent(var_15_1, nil)

	local var_15_2 = arg_15_0.subDftAniEvent

	var_1.SetStartEvent(var_15_2, nil)

	local var_15_3 = arg_15_0.subDftAniEvent

	var_1.SetEndEvent(var_15_3, nil)

	if arg_15_0.handle then
		UpdateBeat = var_1

		var_1:RemoveListener(arg_15_0.handle)
	end

	return
end

return var_0_0
