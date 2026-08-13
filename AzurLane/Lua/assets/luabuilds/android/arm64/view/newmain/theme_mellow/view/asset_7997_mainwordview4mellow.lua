class = var_0_10000

local var_0_0 = "MainWordView4Mellow"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...theme_classic.view.MainWordView"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.GetComponent

	typeof = var_6
	Animation = var_1_10008
	arg_1_0.animationPlayer = var_1_1(var_1_0, var_6(var_1_10008))

	local var_1_2 = arg_1_1
	local var_1_3 = arg_1_1.GetComponent

	typeof = var_6
	DftAniEvent = var_1_10008
	arg_1_0.dftAniEvent = var_1_3(var_1_2, var_6(var_1_10008))

	local var_1_4 = arg_1_1
	local var_1_5 = arg_1_1.GetComponent

	typeof = var_6
	CanvasGroup = var_1_10008
	arg_1_0.cg = var_1_5(var_1_4, var_6(var_1_10008))

	return
end

function var_0_1.StartAnimation(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_0.stopChatFlag == true then
		return
	end

	getProxy = var_3
	SettingsProxy = var_1_10005

	local var_2_0 = var_3(var_1_10005)

	if not var_3.ShouldShipMainSceneWord(var_2_0) then
		local var_2_1 = arg_2_0.chatTf

		Vector3 = var_1_10004
		var_2_1.localScale = var_1_10004.zero

		return
	end

	arg_2_0.cg.alpha = 1

	local var_2_2 = arg_2_0.dftAniEvent

	var_3.SetStartEvent(var_2_2, nil)

	local var_2_3 = arg_2_0.dftAniEvent

	var_3.SetStartEvent(var_2_3, function()
		local var_3_0 = arg_2_0.dftAniEvent

		var_0.SetStartEvent(var_3_0, nil)

		local var_3_1 = arg_2_0.chatTf

		Vector3 = var_2_10001
		var_3_1.localScale = var_2_10001.one

		return
	end)
	arg_2_0:AddTimer(function()
		if not arg_2_0.animationPlayer then
			return
		end

		local var_4_0 = arg_2_0.animationPlayer

		var_0.Stop(var_4_0)

		local var_4_1 = arg_2_0

		var_0.PlayHideAnimation(var_4_1, arg_2_1)

		return
	end, arg_2_1 + arg_2_2)

	local var_2_4 = arg_2_0.animationPlayer

	var_3.Play(var_2_4, "anim_newmain_chat_show")

	return
end

function var_0_1.StopAnimation(arg_5_0)
	if arg_5_0.animationPlayer then
		local var_5_0 = arg_5_0.animationPlayer

		var_1.Stop(var_5_0)
	end

	arg_5_0:RemoveTimer()

	local var_5_1 = arg_5_0.chatTf

	Vector3 = var_1_10002
	var_5_1.localScale = var_1_10002.zero

	return
end

function var_0_1.PlayHideAnimation(arg_6_0, arg_6_1)
	if arg_6_0.exited then
		return
	end

	getProxy = var_2
	SettingsProxy = var_1_10004

	local var_6_0 = var_2(var_1_10004)

	if not var_2.ShouldShipMainSceneWord(var_6_0) then
		local var_6_1 = arg_6_0.chatTf

		Vector3 = var_1_10003
		var_6_1.localScale = var_1_10003.zero

		return
	end

	arg_6_0:AddTimer(function()
		if not arg_6_0.animationPlayer then
			return
		end

		local var_7_0 = arg_6_0.animationPlayer

		var_0.Stop(var_7_0)

		local var_7_1 = arg_6_0.chatTf

		Vector3 = var_2_10001
		var_7_1.localScale = var_2_10001.zero

		return
	end, arg_6_1)

	local var_6_2 = arg_6_0.animationPlayer

	var_2.Play(var_6_2, "anim_newmain_chat_hide")

	return
end

function var_0_1.AddTimer(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0:RemoveTimer()

	Timer = var_3
	arg_8_0.timer = var_3.New(arg_8_1, arg_8_2, 1)

	local var_8_0 = arg_8_0.timer

	var_3.Start(var_8_0)

	return
end

function var_0_1.RemoveTimer(arg_9_0)
	if arg_9_0.timer then
		local var_9_0 = arg_9_0.timer

		var_1.Stop(var_9_0)

		arg_9_0.timer = nil
	end

	return
end

function var_0_1.Dispose(arg_10_0)
	var_0_1.super.Dispose(arg_10_0)
	arg_10_0:RemoveTimer()

	local var_10_0 = arg_10_0.dftAniEvent

	var_1.SetStartEvent(var_10_0, nil)

	local var_10_1 = arg_10_0.dftAniEvent

	var_1.SetEndEvent(var_10_1, nil)

	return
end

return var_0_1
