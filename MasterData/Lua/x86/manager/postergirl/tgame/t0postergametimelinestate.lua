local T0PosterGameTimelineState = class("T0PosterGameTimelineState", PosterCommonTimelineState)

function T0PosterGameTimelineState:Ctor(arg_1_1)
	T0PosterGameTimelineState.super.Ctor(self, arg_1_1)

	self.gameInst = nil
end

function T0PosterGameTimelineState:Enter()
	manager.ui:SetMainCameraCom("CinemachineBrain", true)
	T0PosterGameTimelineState.super.Enter(self)
end

function T0PosterGameTimelineState:Exit(arg_3_1)
	if self.actor then
		self.actor:GetHeroTimelineMgr():TryJumpToEnd()
	end

	T0PosterGameTimelineState.super.Exit(self, arg_3_1)
	manager.ui:SetMainCameraCom("CinemachineBrain", false)
end

function T0PosterGameTimelineState:Dispose()
	if self.gameInst then
		self.gameInst:Reset()
	end

	T0PosterGameTimelineState.super.Dispose(self)
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

function T0PosterGameTimelineState:PlayAni(arg_7_1, arg_7_2, arg_7_3)
	self:PlayAniByActor(self.actor, arg_7_1, arg_7_2, arg_7_3)
end

function T0PosterGameTimelineState:PlayAniByActor(arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	if self.ignoreNextCrossFade then
		arg_8_4 = 0
	end

	self.playingNotSkipable = false

	local var_8_0 = var_0_1(self, arg_8_3)

	self.callback = var_8_0

	local var_8_1 = arg_8_1:GetHeroTimelineMgr()

	var_8_1:PlayAction(arg_8_2, {
		fadeSecond = arg_8_4 or var_0_2
	})
	;(arg_8_4 == 0 and var_8_1.SetCallbackStopped or var_8_1.SetCallbackBlendSignal)(var_8_1, var_8_0)

	self.ignoreNextCrossFade = false
end

function T0PosterGameTimelineState:PlayAniNotSkipable(arg_9_1, arg_9_2, arg_9_3)
	self:PlayAniNotSkipableByActor(self.actor, arg_9_1, arg_9_2, arg_9_3)
end

function T0PosterGameTimelineState:PlayAniNotSkipableByActor(arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	if self.ignoreNextCrossFade then
		arg_10_4 = 0
	end

	self.playingNotSkipable = true

	local var_10_0 = var_0_1(self, arg_10_3)

	self.callback = var_10_0

	local var_10_1 = arg_10_1:GetHeroTimelineMgr()

	var_10_1:PlayAction(arg_10_2, {
		fadeSecond = arg_10_4 or var_0_2
	})
	;(arg_10_4 == 0 and var_10_1.SetCallbackStopped or var_10_1.SetCallbackBlendSignal)(var_10_1, var_10_0)

	self.ignoreNextCrossFade = false
end

function T0PosterGameTimelineState:PlayNextAni()
	if self:CanPlayNextAni() then
		self:GetHeroTimelineMgr():SetCallbackBlendSignal(nil)

		if self.callback then
			self.callback()

			self.callback = nil
		end
	end
end

function T0PosterGameTimelineState:StopTalkDelayTimer()
	if self.talkDelayTimer_ then
		self.talkDelayTimer_:Stop()

		self.talkDelayTimer_ = nil
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

	local var_13_4 = HeroTools.FindMatchSkinVoiceID(arg_13_1, var_13_0)

	if var_13_4 then
		manager.notify:Invoke(HOME_POSTER_TALK, arg_13_1, var_13_4, (manager.audio:GetVoiceLength(var_13_1, var_13_2, var_13_3)))
	end
end

function T0PosterGameTimelineState:StartTalkDelayTimer(arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	self:StopTalkDelayTimer()

	if arg_14_4 > 0 then
		self.talkDelayTimer_ = Timer.New(function()
			var_0_3(self.actor, arg_14_1, arg_14_2, arg_14_3)
		end, arg_14_4)

		self.talkDelayTimer_:Start()
	else
		var_0_3(self.actor, arg_14_1, arg_14_2, arg_14_3)
	end
end

function T0PosterGameTimelineState:PlaySpecialTalk(arg_16_1, arg_16_2)
	if manager.story:IsPlay() then
		return
	end

	local var_16_1

	arg_16_2, var_16_1 = HeroTools.GetTalkInfoFromInteractionCfg(self.actor.skinId, arg_16_1, arg_16_2)

	if arg_16_2 then
		self:StartTalkDelayTimer(self.actor.skinId, arg_16_1, arg_16_2, var_16_1 / 1000)
	end
end

function T0PosterGameTimelineState:CanPlayNextAni()
	return not self.playingNotSkipable
end

function T0PosterGameTimelineState:AcceptTouch()
	return true
end

function T0PosterGameTimelineState:SetCanSkipable(arg_19_1)
	self.playingNotSkipable = arg_19_1
end

function T0PosterGameTimelineState:GetStateKey()
	return self.gameInst.GetStateName and self.gameInst:GetStateName() or "drawCardMiniGame"
end

function T0PosterGameTimelineState:SetStateKey(arg_21_1)
	self.gameInst = arg_21_1.args.gameInst

	self.gameInst:BindActorState(self)
end

function T0PosterGameTimelineState:SwipeToLeft()
	return self.gameInst:SwipeToLeft()
end

function T0PosterGameTimelineState:SwipeToRight()
	return self.gameInst:SwipeToRight()
end

function T0PosterGameTimelineState:ZoomToCamera(arg_24_1)
	return self.gameInst:ZoomToCamera(arg_24_1)
end

return T0PosterGameTimelineState
