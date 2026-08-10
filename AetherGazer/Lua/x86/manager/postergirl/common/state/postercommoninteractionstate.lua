local var_0_0 = class("PosterCommonInteractionState", PosterCommonTimelineState)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0.interactionKey = arg_1_2
end

function var_0_0.Enter(arg_2_0)
	arg_2_0:CheckInsteraction()
end

function var_0_0.CheckInsteraction(arg_3_0)
	arg_3_0.actor:EnableEyeController(false)

	local var_3_0 = arg_3_0.actor:GetSkinId()
	local var_3_1 = SkinCfg[var_3_0].hero
	local var_3_2 = arg_3_0.actor:GetInteractionCfg()
	local var_3_3 = var_3_2[arg_3_0.interactionKey]
	local var_3_4 = var_3_2[arg_3_0.interactionKey .. "_talk"]
	local var_3_5 = var_3_2[arg_3_0.interactionKey .. "_delay"]
	local var_3_6 = 1

	if #var_3_3 > 1 then
		if manager.posterGirl.actor == arg_3_0.actor then
			var_3_6 = arg_3_0:RandomIndexOfInteractionType(arg_3_0.interactionKey)
		else
			var_3_6 = manager.posterGirl.actor:GetCurrentState().lastIndex
		end
	end

	local var_3_7 = var_3_3[var_3_6]
	local var_3_8 = var_3_4[var_3_6]
	local var_3_9 = var_3_5[var_3_6]

	if var_3_7 then
		arg_3_0.talking_ = var_3_8

		arg_3_0:PlayAni(var_3_7)

		if var_3_8 and var_3_9 then
			arg_3_0:PlaySpecialTalk(var_3_8, var_3_9)
		end
	end

	if arg_3_0.interactionKey == PosterGirlConst.InteractionKey.mainTouch or arg_3_0.interactionKey == PosterGirlConst.InteractionKey.mainQuickTouch then
		PlayerAction.TouchPosterGirl()
	end
end

function var_0_0.RandomIndexOfInteractionType(arg_4_0, arg_4_1)
	arg_4_0.lastIndex = manager.posterGirl:GetForceRandomIndex() or PosterGirlTools.ActorRandomIndexOfInteractionType(arg_4_0.actor, arg_4_1, arg_4_0.lastIndex)

	return arg_4_0.lastIndex
end

function var_0_0.PlaySpecialTalk(arg_5_0, arg_5_1, arg_5_2)
	if manager.story:IsPlay() then
		return
	end

	if arg_5_0.talkDelayTimer_ then
		arg_5_0.talkDelayTimer_:Stop()

		arg_5_0.talkDelayTimer_ = nil
	end

	local var_5_0, var_5_1 = HeroTools.GetIntHeroIDAndInteractionVoiceFileName(arg_5_1)

	if arg_5_2 > 0 then
		arg_5_0.talkDelayTimer_ = Timer.New(function()
			arg_5_0.actor:PlayHeroTalk(var_5_0, var_5_1, nil)
		end, arg_5_2 / 1000)

		arg_5_0.talkDelayTimer_:Start()
	else
		arg_5_0.actor:PlayHeroTalk(var_5_0, var_5_1, nil)
	end
end

function var_0_0.Exit(arg_7_0)
	var_0_0.super.Exit(arg_7_0)

	if arg_7_0.talkDelayTimer_ then
		arg_7_0.talkDelayTimer_:Stop()

		arg_7_0.talkDelayTimer_ = nil
	end
end

return var_0_0
