local var_0_0 = class("MainWordView4Mellow", import("...theme_classic.view.MainWordView"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0.animationPlayer = arg_1_1:GetComponent(typeof(Animation))
	arg_1_0.dftAniEvent = arg_1_1:GetComponent(typeof(DftAniEvent))
	arg_1_0.cg = arg_1_1:GetComponent(typeof(CanvasGroup))

	return
end

function var_0_0.StartAnimation(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_0.stopChatFlag == true then
		return
	end

	local var_2_0 = getProxy(SettingsProxy)

	if not var_2_0:ShouldShipMainSceneWord() then
		arg_2_0.chatTf.localScale = Vector3.zero

		return
	end

	arg_2_0.cg.alpha = 1

	arg_2_0.dftAniEvent:SetStartEvent(nil)
	arg_2_0.dftAniEvent:SetStartEvent(function()
		arg_2_0.dftAniEvent:SetStartEvent(nil)

		arg_2_0.chatTf.localScale = Vector3.one

		return
	end)
	arg_2_0:AddTimer(function()
		if not arg_2_0.animationPlayer then
			return
		end

		arg_2_0.animationPlayer:Stop()
		arg_2_0:PlayHideAnimation(arg_2_1)

		return
	end, arg_2_1 + arg_2_2)
	arg_2_0.animationPlayer:Play("anim_newmain_chat_show")

	return
end

function var_0_0.StopAnimation(arg_5_0)
	if arg_5_0.animationPlayer then
		arg_5_0.animationPlayer:Stop()
	end

	arg_5_0:RemoveTimer()

	arg_5_0.chatTf.localScale = Vector3.zero

	return
end

function var_0_0.PlayHideAnimation(arg_6_0, arg_6_1)
	if arg_6_0.exited then
		return
	end

	local var_6_0 = getProxy(SettingsProxy)

	if not var_6_0:ShouldShipMainSceneWord() then
		arg_6_0.chatTf.localScale = Vector3.zero

		return
	end

	arg_6_0:AddTimer(function()
		if not arg_6_0.animationPlayer then
			return
		end

		arg_6_0.animationPlayer:Stop()

		arg_6_0.chatTf.localScale = Vector3.zero

		return
	end, arg_6_1)
	arg_6_0.animationPlayer:Play("anim_newmain_chat_hide")

	return
end

function var_0_0.AddTimer(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0:RemoveTimer()

	arg_8_0.timer = Timer.New(arg_8_1, arg_8_2, 1)

	arg_8_0.timer:Start()

	return
end

function var_0_0.RemoveTimer(arg_9_0)
	if arg_9_0.timer then
		arg_9_0.timer:Stop()

		arg_9_0.timer = nil
	end

	return
end

function var_0_0.Dispose(arg_10_0)
	var_0_0.super.Dispose(arg_10_0)
	arg_10_0:RemoveTimer()
	arg_10_0.dftAniEvent:SetStartEvent(nil)
	arg_10_0.dftAniEvent:SetEndEvent(nil)

	return
end

return var_0_0
