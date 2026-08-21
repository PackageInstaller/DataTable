local var_0_0 = class("CryptolaliaScrollRectAnimation")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._tf = arg_1_1
	arg_1_0.isInit = false

	return
end

function var_0_0.Init(arg_2_0)
	arg_2_0.animation = arg_2_0._tf:GetComponent(typeof(Animation))
	arg_2_0.dftAniEvent = arg_2_0._tf:GetComponent(typeof(DftAniEvent))

	arg_2_0.dftAniEvent:SetTriggerEvent(function()
		if arg_2_0.onTrigger then
			arg_2_0.onTrigger()
		end

		arg_2_0.onTrigger = nil

		return
	end)
	arg_2_0.dftAniEvent:SetEndEvent(function()
		if arg_2_0.callback then
			arg_2_0.callback()
		end

		return
	end)

	arg_2_0.subAnim = arg_2_0._tf:Find("Main/anim")
	arg_2_0.subAnimation = arg_2_0.subAnim:GetComponent(typeof(Animation))
	arg_2_0.subDftAniEvent = arg_2_0.subAnim:GetComponent(typeof(DftAniEvent))

	arg_2_0.subDftAniEvent:SetStartEvent(function()
		arg_2_0.playing = true

		return
	end)
	arg_2_0.subDftAniEvent:SetEndEvent(function()
		arg_2_0.playing = false

		if arg_2_0.onLastUpdate then
			arg_2_0.onLastUpdate()

			arg_2_0.onLastUpdate = nil
		end

		return
	end)

	arg_2_0.playing = false
	arg_2_0.handle = arg_2_0.handle or UpdateBeat:CreateListener(arg_2_0.Update, arg_2_0)

	UpdateBeat:AddListener(arg_2_0.handle)

	arg_2_0.isInit = true

	return
end

function var_0_0.Update(arg_7_0)
	if arg_7_0.playing and arg_7_0.onUpdate then
		arg_7_0.onUpdate((arg_7_0:Evaluate()))
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
	arg_8_0.animation:Play("anim_Cryptolalia_change")
	arg_8_0.subAnimation:Play(arg_8_1 <= 0 and "anim_Cryptolalia_listup" or "anim_Cryptolalia_listdown")

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

	arg_14_0.animation:Stop()
	arg_14_0.subAnimation:Stop()

	return
end

function var_0_0.Dispose(arg_15_0)
	arg_15_0.dftAniEvent:SetTriggerEvent(nil)
	arg_15_0.dftAniEvent:SetEndEvent(nil)
	arg_15_0.subDftAniEvent:SetStartEvent(nil)
	arg_15_0.subDftAniEvent:SetEndEvent(nil)

	if arg_15_0.handle then
		UpdateBeat:RemoveListener(arg_15_0.handle)
	end

	return
end

return var_0_0
