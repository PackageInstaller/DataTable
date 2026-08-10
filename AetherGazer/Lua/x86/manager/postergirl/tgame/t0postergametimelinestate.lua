local var_0_0 = class("T0PosterGameTimelineState", PosterCommonTimelineState)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.gameInst = nil
end

function var_0_0.Enter(arg_2_0)
	manager.ui:SetMainCameraCom("CinemachineBrain", true)
	var_0_0.super.Enter(arg_2_0)
end

function var_0_0.Exit(arg_3_0, arg_3_1)
	if arg_3_0.actor then
		arg_3_0.actor:GetHeroTimelineMgr():TryJumpToEnd()
	end

	var_0_0.super.Exit(arg_3_0, arg_3_1)
	manager.ui:SetMainCameraCom("CinemachineBrain", false)
end

function var_0_0.Dispose(arg_4_0)
	if arg_4_0.gameInst then
		arg_4_0.gameInst:Reset()
	end

	var_0_0.super.Dispose(arg_4_0)
end

local function var_0_1(arg_5_0, arg_5_1)
	return function()
		arg_5_0.playingNotSkipable = true

		if arg_5_1 then
			arg_5_1()
		end
	end
end

local var_0_2 = 0.4

function var_0_0.PlayAni(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	arg_7_0:PlayAniByActor(arg_7_0.actor, arg_7_1, arg_7_2, arg_7_3)
end

function var_0_0.PlayAniByActor(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	if arg_8_0.ignoreNextCrossFade then
		arg_8_4 = 0
	end

	arg_8_0.playingNotSkipable = false

	local var_8_0 = var_0_1(arg_8_0, arg_8_3)

	arg_8_0.callback = var_8_0

	local var_8_1 = arg_8_1:GetHeroTimelineMgr()

	var_8_1:PlayAction(arg_8_2, {
		fadeSecond = arg_8_4 or var_0_2
	})

	local var_8_2

	if arg_8_4 == 0 then
		var_8_2 = var_8_1.SetCallbackStopped
	else
		var_8_2 = var_8_1.SetCallbackBlendSignal
	end

	var_8_2(var_8_1, var_8_0)

	arg_8_0.ignoreNextCrossFade = false
end

function var_0_0.PlayAniNotSkipable(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	arg_9_0:PlayAniNotSkipableByActor(arg_9_0.actor, arg_9_1, arg_9_2, arg_9_3)
end

function var_0_0.PlayAniNotSkipableByActor(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	if arg_10_0.ignoreNextCrossFade then
		arg_10_4 = 0
	end

	arg_10_0.playingNotSkipable = true

	local var_10_0 = var_0_1(arg_10_0, arg_10_3)

	arg_10_0.callback = var_10_0

	local var_10_1 = arg_10_1:GetHeroTimelineMgr()

	var_10_1:PlayAction(arg_10_2, {
		fadeSecond = arg_10_4 or var_0_2
	})

	local var_10_2

	if arg_10_4 == 0 then
		var_10_2 = var_10_1.SetCallbackStopped
	else
		var_10_2 = var_10_1.SetCallbackBlendSignal
	end

	var_10_2(var_10_1, var_10_0)

	arg_10_0.ignoreNextCrossFade = false
end

function var_0_0.PlayNextAni(arg_11_0)
	if arg_11_0:CanPlayNextAni() then
		arg_11_0:GetHeroTimelineMgr():SetCallbackBlendSignal(nil)

		if arg_11_0.callback then
			arg_11_0.callback()

			arg_11_0.callback = nil
		end
	end
end

function var_0_0.StopTalkDelayTimer(arg_12_0)
	if arg_12_0.talkDelayTimer_ then
		arg_12_0.talkDelayTimer_:Stop()

		arg_12_0.talkDelayTimer_ = nil
	end
end

local function var_0_3(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	if PosterGirlTools.ShouldMuteHomePosterTalk() then
		return
	end

	manager.audio:PlayUIAudioByVoice(arg_13_2)

	local var_13_0 = HeroTools.GetInteractionVoiceFileName(arg_13_3)
	local var_13_1 = string.format("vo_sys_%d", arg_13_1)
	local var_13_2 = string.format("v_s_%d_%s", arg_13_1, var_13_0)
	local var_13_3 = string.format("vo_sys_%d.awb", arg_13_1)

	HeroTools.PlayTalkWithLips(arg_13_0.skinId, arg_13_0.tpose.transform, var_13_1, var_13_2, var_13_3)
	manager.notify:Invoke(HERO_SOUND_PLAY, arg_13_1, var_13_0, 1)

	local var_13_4 = manager.audio:GetVoiceLength(var_13_1, var_13_2, var_13_3)
	local var_13_5 = HeroTools.FindMatchSkinVoiceID(arg_13_1, var_13_0)

	if var_13_5 then
		manager.notify:Invoke(HOME_POSTER_TALK, arg_13_1, var_13_5, var_13_4)
	end
end

function var_0_0.StartTalkDelayTimer(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	arg_14_0:StopTalkDelayTimer()

	if arg_14_4 > 0 then
		arg_14_0.talkDelayTimer_ = Timer.New(function()
			var_0_3(arg_14_0.actor, arg_14_1, arg_14_2, arg_14_3)
		end, arg_14_4)

		arg_14_0.talkDelayTimer_:Start()
	else
		var_0_3(arg_14_0.actor, arg_14_1, arg_14_2, arg_14_3)
	end
end

function var_0_0.PlaySpecialTalk(arg_16_0, arg_16_1, arg_16_2)
	if manager.story:IsPlay() then
		return
	end

	local var_16_0
	local var_16_1

	arg_16_2, var_16_1 = HeroTools.GetTalkInfoFromInteractionCfg(arg_16_0.actor.skinId, arg_16_1, arg_16_2)

	local var_16_2 = arg_16_0.actor.skinId

	if arg_16_2 then
		arg_16_0:StartTalkDelayTimer(var_16_2, arg_16_1, arg_16_2, var_16_1 / 1000)
	end
end

function var_0_0.CanPlayNextAni(arg_17_0)
	return not arg_17_0.playingNotSkipable
end

function var_0_0.AcceptTouch(arg_18_0)
	return true
end

function var_0_0.SetCanSkipable(arg_19_0, arg_19_1)
	arg_19_0.playingNotSkipable = arg_19_1
end

function var_0_0.GetStateKey(arg_20_0)
	return arg_20_0.gameInst.GetStateName and arg_20_0.gameInst:GetStateName() or "drawCardMiniGame"
end

function var_0_0.SetStateKey(arg_21_0, arg_21_1)
	arg_21_0.gameInst = arg_21_1.args.gameInst

	arg_21_0.gameInst:BindActorState(arg_21_0)
end

function var_0_0.SwipeToLeft(arg_22_0)
	return arg_22_0.gameInst:SwipeToLeft()
end

function var_0_0.SwipeToRight(arg_23_0)
	return arg_23_0.gameInst:SwipeToRight()
end

function var_0_0.ZoomToCamera(arg_24_0, arg_24_1)
	return arg_24_0.gameInst:ZoomToCamera(arg_24_1)
end

return var_0_0
