class = var_0_10000

local var_0_0 = "VoiceChatPlayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("Mgr.Story.model.animation.StoryAnimtion"))
local var_0_2 = 0
local var_0_3 = 1
local var_0_4 = 2
local var_0_5 = 3
local var_0_6 = 4

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0)

	arg_1_0._tf = arg_1_1.transform

	local var_1_0 = arg_1_0._tf
	local var_1_1 = var_2.Find(var_1_0, "front/Text")
	local var_1_2 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_1_0.content = var_1_2(var_1_1, var_5(var_1_10007))

	local var_1_3 = arg_1_0._tf

	arg_1_0.optionPanel = var_2.Find(var_1_3, "front/options_panel")
	UIItemList = var_2

	local var_1_4 = var_2.New
	local var_1_5 = arg_1_0.optionPanel
	local var_1_6 = var_4.Find(var_1_5, "options_c")
	local var_1_7 = arg_1_0.optionPanel

	arg_1_0.optionUIList = var_1_4(var_1_6, var_5.Find(var_1_7, "options_c/option_tpl"))

	local var_1_8 = arg_1_0._tf

	arg_1_0.closeBtn = var_2.Find(var_1_8, "front/btns/close_btn")

	return
end

function var_0_1.Play(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	if not arg_2_1 then
		arg_2_3()

		return
	end

	if not arg_2_1:GetStepByIndex(arg_2_2) then
		arg_2_3()

		return
	end

	arg_2_0.callback = arg_2_3

	arg_2_0:Reset(var_4)

	seriesAsync = var_5

	var_5({
		function(arg_3_0)
			local var_3_0 = arg_2_0

			if not var_1.EnterPhase(var_3_0, var_0_3) then
				return
			end

			local var_3_1 = arg_2_0

			var_1.PlayVoice(var_3_1, var_0)

			local var_3_2 = arg_2_0

			var_1.DispatcherEvent(var_3_2, var_0)

			local var_3_3 = arg_2_0

			var_1.ReigsetEvent(var_3_3, var_0, arg_3_0)

			return
		end,
		function(arg_4_0)
			local var_4_0 = arg_2_0

			if not var_1.EnterPhase(var_4_0, var_0_4) then
				return
			end

			local var_4_1 = arg_2_0

			var_1.ClearEvent(var_4_1)

			local var_4_2 = arg_2_0

			var_1.ClearChatTimer(var_4_2)

			local var_4_3 = arg_2_0

			var_1.DelayCall(var_4_3, 0.2, arg_4_0)

			return
		end,
		function(arg_5_0)
			local var_5_0 = arg_2_0

			if not var_1.EnterPhase(var_5_0, var_0_5) then
				return
			end

			local var_5_1 = arg_2_0

			var_1.StopVoice(var_5_1)

			local var_5_2 = arg_2_0

			var_1.InitOptionIfNeed(var_5_2, arg_2_1, var_0, arg_5_0)

			return
		end,
		function(arg_6_0)
			local var_6_0 = arg_2_0

			if not var_1.EnterPhase(var_6_0, var_0_6) then
				return
			end

			local var_6_1 = arg_2_0

			var_1.Clear(var_6_1, var_0, arg_6_0)

			return
		end
	}, arg_2_3)

	return
end

function var_0_1.EnterPhase(arg_7_0, arg_7_1)
	if arg_7_1 - 1 ~= arg_7_0.phase then
		return false
	end

	arg_7_0.phase = arg_7_1

	return true
end

function var_0_1.Reset(arg_8_0, arg_8_1)
	arg_8_0.phase = var_0_2
	setActive = var_2

	var_2(arg_8_0.optionPanel, false)
	arg_8_0:ClearEvent()

	return
end

function var_0_1.StopVoice(arg_9_0)
	if arg_9_0.currentVoice then
		local var_9_0 = arg_9_0.currentVoice

		var_1.Stop(var_9_0, true)

		arg_9_0.currentVoice = nil
	end

	return
end

function var_0_1.PlayVoice(arg_10_0, arg_10_1)
	arg_10_0:StopVoice()

	arg_10_0.content.text = arg_10_1:GetSay()

	local var_10_0 = arg_10_1:GetVoice()

	pg = var_3

	local var_10_1 = var_3.CriMgr.GetInstance()

	var_3.PlaySoundEffect_V3(var_10_1, var_10_0, function(arg_11_0)
		if arg_11_0 then
			arg_10_0.currentVoice = arg_11_0.playback
		end

		local var_11_0 = arg_11_0
		local var_11_1 = arg_11_0.GetLength(var_11_0) * 0.001
		local var_11_2 = arg_10_1
		local var_11_3 = var_2.GetWaitForClickTime(var_11_2)

		assert = var_11_0

		local var_11_4 = var_11_3 < var_11_1

		string = var_2_10006

		var_11_0(var_11_4, var_2_10006.format("chatShowTime must > wait time voice:%s voiceLenth:%f wait:%f", var_10_0, var_11_1, var_11_3))

		local var_11_5 = arg_10_0

		var_3.AddTimeTriggerNextOne(var_11_5, var_11_1)

		return
	end)

	return
end

function var_0_1.AddTimeTriggerNextOne(arg_12_0, arg_12_1)
	arg_12_0.chatTimer = arg_12_0:CreateDelayTimer(arg_12_1, function()
		local var_13_0 = arg_12_0

		var_0.ClearChatTimer(var_13_0)

		triggerButton = var_0

		var_0(arg_12_0._tf)

		return
	end)

	return
end

function var_0_1.ClearChatTimer(arg_14_0)
	if arg_14_0.chatTimer then
		local var_14_0 = arg_14_0.chatTimer

		var_1.Stop(var_14_0)

		arg_14_0.chatTimer = nil
	end

	return
end

function var_0_1.ReigsetEvent(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_1:GetWaitForClickTime()

	arg_15_0:DelayCall(var_15_0, function()
		onButton = var_2_10000

		local var_16_0 = arg_15_0
		local var_16_1 = arg_15_0._tf
		local var_16_2 = arg_15_2

		SFX_PANEL = var_2_10005

		var_2_10000(var_16_0, var_16_1, var_16_2, var_2_10005)

		return
	end)

	return
end

function var_0_1.ClearEvent(arg_17_0)
	removeOnButton = var_1_10001

	var_1_10001(arg_17_0._tf)

	return
end

function var_0_1.InitOptionIfNeed(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	setActive = var_1_10004

	var_1_10004(arg_18_0.optionPanel, arg_18_2:ExistOption())

	if not arg_18_2:ExistOption() then
		arg_18_3()

		return
	end

	setActive = var_4

	var_4(arg_18_0.closeBtn, false)

	local var_18_0 = arg_18_2:GetOptions()
	local var_18_1 = arg_18_0.optionUIList

	var_5.make(var_18_1, function(arg_19_0, arg_19_1, arg_19_2)
		UIItemList = var_2_10003

		if arg_19_0 == var_2_10003.EventUpdate then
			local var_19_0 = var_18_0[arg_19_1 + 1]
			local var_19_1 = arg_19_2:Find("content/Text")
			local var_19_2 = var_4.GetComponent

			typeof = var_7
			Text = var_2_10009
			var_19_2(var_19_1, var_7(var_2_10009)).text = var_19_0[1]
			onButton = var_5

			var_5(arg_18_0, arg_19_2, function()
				optionBlockOther = var_3_10000

				if var_3_10000 then
					return
				end

				local var_20_0 = arg_19_2
				local var_20_1 = var_0.Find(var_20_0, "selectAni")
				local var_20_2 = var_0.GetComponent

				typeof = var_3_10004
				Animation = var_3_10006

				local var_20_3 = var_20_2(var_20_1, var_3_10004(var_3_10006))

				setActive = var_20_0

				var_20_0(var_0, true)
				var_20_3:Play("anim_selectAni_loop")

				arg_18_0.optionBlockOther = true

				local var_20_4 = var_0
				local var_20_5 = var_0.GetComponent

				typeof = var_5
				DftAniEvent = var_3_10007

				local var_20_6 = var_20_5(var_20_4, var_5(var_3_10007))

				var_2.SetEndEvent(var_20_6, function()
					local var_21_0 = arg_18_0

					var_21_0.optionBlockOther = false
					setActive = var_21_0

					var_21_0(var_0, false)

					local var_21_1 = arg_18_1

					var_0.SetBranchCode(var_21_1, var_19_0[2])
					arg_18_3(var_19_0[2])

					setActive = var_0

					var_0(arg_18_0.closeBtn, true)

					return
				end)

				return
			end)
		end

		return
	end)

	local var_18_2 = arg_18_0.optionUIList

	var_5.align(var_18_2, #var_18_0)

	return
end

function var_0_1.DispatcherEvent(arg_22_0, arg_22_1)
	if not arg_22_1:ExistDispatcher() then
		return
	end

	local var_22_0 = arg_22_1:GetDispatcher()

	pg = var_1_10003

	local var_22_1 = var_1_10003.NewStoryMgr.GetInstance()

	var_3.ClearStoryEvent(var_22_1)

	pg = var_3

	local var_22_2 = var_3.m02

	var_3.sendNotification(var_22_2, var_22_0.name, {
		data = var_22_0.data,
		callbackData = var_22_0.callbackData
	})

	if arg_22_1:ShouldHideUI() then
		setActive = var_3

		var_3(arg_22_0._tf, false)
	end

	if arg_22_1:IsRecallDispatcher() then
		arg_22_0:CheckDispatcher(arg_22_1)
	end

	return var_22_0.nextOne
end

function var_0_1.CheckDispatcher(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_1:GetDispatcherRecallName()

	arg_23_0:ClearCheckDispatcher()

	Timer = var_3
	arg_23_0.checkTimer = var_3.New(function()
		pg = var_2_10000

		local var_24_0 = var_2_10000.NewStoryMgr.GetInstance()

		if var_0.CheckStoryEvent(var_24_0, var_23_0) then
			pg = var_0

			local var_24_1 = var_0.NewStoryMgr.GetInstance()

			if var_0.GetStoryEventArg(var_24_1, var_23_0) then
				existCall = var_2_10001

				var_2_10001(var_0.notifiCallback)
			end

			if var_0 and var_0.optionIndex then
				arg_23_0.skipOption = true
			end

			local var_24_2 = arg_23_1

			if var_1.ShouldHideUI(var_24_2) then
				setActive = var_1

				var_1(arg_23_0._tf, true)
			end

			local var_24_3 = arg_23_0

			var_1.ClearCheckDispatcher(var_24_3)
		end

		return
	end, 1, -1)

	local var_23_1 = arg_23_0.checkTimer

	var_3.Start(var_23_1)
	arg_23_0.checkTimer.func()

	return
end

function var_0_1.ClearCheckDispatcher(arg_25_0)
	if arg_25_0.checkTimer then
		local var_25_0 = arg_25_0.checkTimer

		var_1.Stop(var_25_0)

		arg_25_0.checkTimer = nil
	end

	return
end

function var_0_1.Clear(arg_26_0, arg_26_1, arg_26_2)
	arg_26_0:ClearAnimation()
	arg_26_0:StopVoice()
	arg_26_0:ClearChatTimer()
	arg_26_0:ClearCheckDispatcher()

	setActive = var_3

	var_3(arg_26_0.optionPanel, false)

	arg_26_0.callback = nil
	existCall = var_3

	var_3(arg_26_2)

	return
end

function var_0_1.OnPause(arg_27_0)
	return
end

function var_0_1.OnResume(arg_28_0)
	return
end

function var_0_1.OnStop(arg_29_0)
	arg_29_0:Reset()
	arg_29_0:ClearAnimation()
	arg_29_0:StopVoice()

	if arg_29_0.callback then
		arg_29_0.callback()

		arg_29_0.callback = nil
	end

	return
end

function var_0_1.OnStart(arg_30_0, arg_30_1)
	pg = var_1_10002

	var_1_10002.DelegateInfo.New(arg_30_0)

	return
end

function var_0_1.OnEnd(arg_31_0, arg_31_1)
	pg = var_1_10002

	var_1_10002.DelegateInfo.Dispose(arg_31_0)
	arg_31_0:ClearChatTimer()
	arg_31_0:ClearCheckDispatcher()

	return
end

return var_0_1
