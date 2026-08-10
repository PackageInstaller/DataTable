local var_0_0 = import("game.views.momoTalk.momotalkItem.TalkShowItem.MomoTalkBubbleBaseItem")
local var_0_1 = class("MomoTalkBubbleTalkItem", var_0_0)
local var_0_2 = "TalkBubble"
local var_0_3 = "New State"
local var_0_4

function var_0_1.Init(arg_1_0)
	var_0_1.super.Init(arg_1_0)

	if arg_1_0.mainControllerEx_ then
		arg_1_0.voiceWordsController_ = arg_1_0.mainControllerEx_:GetController("showVoiceWords")
	end

	arg_1_0.isTalkBubblePlaying_ = false
end

function var_0_1.AddListeners(arg_2_0)
	if arg_2_0.buttonContent_ then
		arg_2_0:AddBtnListener(arg_2_0.buttonContent_, nil, function()
			arg_2_0:PlayVoice()
		end)
	end

	if arg_2_0.voiceWordsBtn_ then
		arg_2_0:AddBtnListener(arg_2_0.voiceWordsBtn_, nil, function()
			arg_2_0:ToggleVoiceWords()
		end)
	end
end

function var_0_1.OnReset(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_2 and arg_5_2.state == "delay"

	if arg_5_0.text_ then
		arg_5_0.text_.text = var_5_0 and "..." or arg_5_0:GetVoiceDurationText(arg_5_1)
	end

	if arg_5_0.voiceWordsText_ then
		arg_5_0.voiceWordsText_.text = var_5_0 and "..." or MomoTalkTools.GetItemDisplayContent(arg_5_2, arg_5_1)
	end

	if arg_5_0.voiceWordsController_ then
		arg_5_0.voiceWordsController_:SetSelectedState("hide")
	end

	arg_5_0:StopVoicePlaybackState()
end

function var_0_1.ResolveVoiceParams(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1 and arg_6_1.voice_params

	if type(var_6_0) == "table" and #var_6_0 >= 3 then
		return var_6_0
	end

	if not arg_6_1 or arg_6_1.type ~= MomoTalkConst.MSG_TYPE.AUDIO or arg_6_1.spokesmen == nil or arg_6_1.spokesmen <= 0 or arg_6_1.url == nil or arg_6_1.url == "" then
		return nil
	end

	local var_6_1 = tonumber(arg_6_1.spokesmen)

	if not var_6_1 or var_6_1 <= 0 then
		return nil
	end

	local var_6_2 = arg_6_1.url

	return {
		string.format("vo_sys_%d", var_6_1),
		var_6_2,
		string.format("vo_sys_%d.awb", var_6_1)
	}
end

function var_0_1.GetVoiceDurationText(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0:ResolveVoiceParams(arg_7_1)

	if not var_7_0 then
		return ""
	end

	local var_7_1 = manager.audio:GetVoiceLength(var_7_0[1], var_7_0[2], var_7_0[3] or "")

	return tostring(math.ceil(var_7_1 / 1000)) .. "s"
end

function var_0_1.PlayBubbleAnimation(arg_8_0, arg_8_1)
	if arg_8_0.speakAni_ and arg_8_1 ~= "" then
		arg_8_0.speakAni_:Play(arg_8_1)
		arg_8_0.speakAni_:Update(0)
	end
end

function var_0_1.PlayBubbleIdleAnimation(arg_9_0)
	arg_9_0:PlayBubbleAnimation(var_0_3)
end

function var_0_1.StopBubbleStateTimer(arg_10_0)
	if arg_10_0.bubbleStateTimer_ then
		arg_10_0.bubbleStateTimer_:Stop()

		arg_10_0.bubbleStateTimer_ = nil
	end
end

function var_0_1.StopVoicePlaybackState(arg_11_0, arg_11_1)
	arg_11_0:StopBubbleStateTimer()

	if arg_11_1 then
		manager.audio:StopVoice()
	end

	arg_11_0.isTalkBubblePlaying_ = false

	arg_11_0:PlayBubbleIdleAnimation()

	if var_0_4 == arg_11_0 then
		var_0_4 = nil
	end
end

function var_0_1.StartBubbleStateTimer(arg_12_0, arg_12_1)
	arg_12_0:StopBubbleStateTimer()

	arg_12_1 = math.max(arg_12_1 or 0, 0)

	if arg_12_1 <= 0 then
		arg_12_0:StopVoicePlaybackState()

		return
	end

	arg_12_0.bubbleStateTimer_ = Timer.New(function()
		arg_12_0.bubbleStateTimer_ = nil

		arg_12_0:StopVoicePlaybackState()
	end, arg_12_1, 1)

	arg_12_0.bubbleStateTimer_:Start()
end

function var_0_1.PlayVoice(arg_14_0)
	local var_14_0 = arg_14_0:ResolveVoiceParams(arg_14_0.cfg_)

	if var_14_0 then
		if var_0_4 and var_0_4 ~= arg_14_0 then
			var_0_4:StopVoicePlaybackState(true)
		elseif arg_14_0.isTalkBubblePlaying_ then
			return
		end

		local var_14_1 = manager.audio:GetVoiceLength(var_14_0[1], var_14_0[2], var_14_0[3] or "")

		HeroTools.StopTalk()
		manager.notify:Invoke(INTERRUPT_HOME_POSTER_TALK)

		var_0_4 = arg_14_0
		arg_14_0.isTalkBubblePlaying_ = true

		arg_14_0:PlayBubbleAnimation(var_0_2)
		arg_14_0:StartBubbleStateTimer(var_14_1 / 1000)
		manager.audio:PlayVoice(var_14_0[1], var_14_0[2], var_14_0[3])
	end
end

function var_0_1.ToggleVoiceWords(arg_15_0)
	if arg_15_0.voiceWordsController_ then
		local var_15_0 = arg_15_0.voiceWordsController_:GetSelectedState() == "show" and "hide" or "show"

		arg_15_0.voiceWordsController_:SetSelectedState(var_15_0)
		arg_15_0:RebuildLayout()
		arg_15_0:NotifyLayoutChanged()
		arg_15_0:DelayNotifyLayoutChanged()
	end
end

function var_0_1.NotifyLayoutChanged(arg_16_0)
	if arg_16_0.layoutChangedHandler_ then
		arg_16_0.layoutChangedHandler_(arg_16_0.layoutChangedSlot_)
	end
end

function var_0_1.DelayNotifyLayoutChanged(arg_17_0)
	arg_17_0:StopLayoutTimer()

	arg_17_0.layoutTimer_ = FrameTimer.New(function()
		arg_17_0.layoutTimer_ = nil

		arg_17_0:NotifyLayoutChanged()
	end, 1, 1)

	arg_17_0.layoutTimer_:Start()
end

function var_0_1.StopLayoutTimer(arg_19_0)
	if arg_19_0.layoutTimer_ then
		arg_19_0.layoutTimer_:Stop()

		arg_19_0.layoutTimer_ = nil
	end
end

function var_0_1.Dispose(arg_20_0)
	arg_20_0:StopLayoutTimer()
	arg_20_0:StopVoicePlaybackState(var_0_4 == arg_20_0)
	var_0_1.super.Dispose(arg_20_0)
end

return var_0_1
